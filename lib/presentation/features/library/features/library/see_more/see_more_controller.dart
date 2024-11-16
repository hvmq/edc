import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../all.dart';
import '../../../api/contanst.dart';
import '../../../api/repos/impl/author_api.swagger.dart';
import '../../../api/repos/impl/favourite_book_api.swagger.dart';
import '../../../api/repos/impl/home_api.swagger.dart';
import '../../../api/repos/impl/search_api.swagger.dart';
import '../../../core/controllers/app_controller.dart';
import '../../../generated_code/openapi.models.swagger.dart';

class SeeMoreController extends AppController {
  final RxString title = ''.obs;
  final RxList<BookRaw> books = <BookRaw>[].obs; // Observable list of books
  final RxBool isLoading = false.obs; // Observable to track loading state
  final RxBool hasMoreData =
      true.obs; // Observable to track if more data is available
  final RxList<Book> favoriteBooks = <Book>[].obs;
  final RxList<Category> listCategories = <Category>[].obs;
  final RxList<Author> listAuthors = <Author>[].obs;
  RxList<int> authors = <int>[].obs;
  RxList<int> categories = <int>[].obs;
  RxString state = ''.obs;
  List<String> filter = ['Categories', 'Author'];
  RxBool isEdit = false.obs;

  int currentPage = 1; // Current page
  final int limit = 20; // Number of books per page

  final CategoryApiRepository _categoryApiRepository;
  final AuthorApiRepository _authorApiRepository;
  final FavouriteBookApiRepository _favouriteBookApiRepository;
  final FavouriteBookFilterApiRepository _favouriteBookFilterApiRepository;

  SeeMoreController()
      : _categoryApiRepository = CategoryApiRepository(),
        _authorApiRepository = AuthorApiRepository(),
        _favouriteBookApiRepository = FavouriteBookApiRepository(),
        _favouriteBookFilterApiRepository = FavouriteBookFilterApiRepository();

  @override
  Future<void> onInit() async {
    super.onInit();
    title.value = Get.arguments['title'];
    loadAuthorsAndCategories();
    loadFavoriteBooks();
  }

  Future<void> loadFavoriteBooks() async {
    try {
      // Clear previous books list
      books.clear();

      // Fetch the favorite books using the provided API repository
      //authors is list name author and categories is list name categories
      final RxList<Book> bookTemp = <Book>[].obs;

      await _loadBooks(() async {
        final fetchedBooks = await _favouriteBookApiRepository
            .getListFavouriteBooks(20, 1, categories.value, authors.value);
        return fetchedBooks.body ?? [];
      }, bookTemp);

      // Convert each book to BookRaw and add it to the books list
      books.addAll(bookTemp.map((book) => BookRaw.fromBook(book)));
    } catch (e) {
      print('Error loading favorite books: $e');
    }
  }

  Future<void> loadAuthorsAndCategories() async {
    try {
      // Fetch the data from the repository
      final fetchedResponse = await _favouriteBookFilterApiRepository
          .getListFavouriteBooksFilterData();

      if (fetchedResponse.body != null) {
        // Safely assign the authors and categories if they exist
        listAuthors.assignAll(fetchedResponse.body?.authors
                .map((author) {
                  return Author(id: author.id, name: author.name);
                })
                .whereType<Author>()
                .toList() ??
            []);
        listCategories.assignAll(fetchedResponse.body?.categories
                .map((category) {
                  return Category(id: category.id, name: category.name);
                })
                .whereType<Category>()
                .toList() ??
            []);
      } else {
        print('Error: No data returned from the API');
      }
    } catch (e) {
      print('Error loading authors and categories: $e');
    }
  }

  // Future<void> loadAuthors() async {
  //   await _loadBooks(() async {
  //     final fetchedAuthors = await _authorApiRepository.get_authors(20, 1);
  //     return fetchedAuthors.body
  //             ?.map((author) => author.name)
  //             .whereType<String>()
  //             .toList() ??
  //         [];
  //   }, listAuthors);
  // }

  // Future<void> loadCategories() async {
  //   await _loadBooks(() async {
  //     final fetchedCategories = await _categoryApiRepository.get_categories();
  //     return fetchedCategories.body
  //             ?.map((category) => category.name)
  //             .whereType<String>()
  //             .toList() ??
  //         [];
  //   }, listCategories);
  // }

  Future<void> _loadBooks<T>(
      Future<List<T>> Function() fetchFunction, RxList<T> list) async {
    try {
      final fetchedItems = await fetchFunction();
      list.assignAll(fetchedItems);
      print('${list.runtimeType} loaded: ${list.length}');
    } catch (e) {
      _handleError(e, 'Error loading ${list.runtimeType}: $e');
    } finally {
      update();
    }
  }

  Future<String> toggleFavourite({required int bookId}) async {
    final String url = '$baseUrl/app/books/toggleFavourite?bookId=$bookId';
    final String accessToken = Get.find<HomeController>().accessToken;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        books.removeWhere(
            (book) => book.id == bookId); // Remove the book from the list
        return data['message'];
      } else {
        return 'Failed to toggle favourite';
      }
    } catch (e) {
      _handleError(e, 'Error toggling favourite: $e');
      return 'Failed to toggle favourite';
    }
  }

  void _handleError(dynamic error, String message) {
    print(message);
    // You can add more sophisticated error handling here, e.g., showing a dialog or sending logs.
  }

  String calculateBookAge(int ageAverage) {
    return (ageAverage >= -1 && ageAverage <= 5) ? '5' : '$ageAverage';
  }

  String getFormattedPrice(double price) {
    try {
      if (price >= 1000) {
        return price % 1000 == 0
            ? '${(price / 1000).toInt()}k Loyalty Point'
            : '${(price / 1000.0).toStringAsFixed(2)}k Loyalty Point';
      } else {
        return '${price.toInt()} Loyalty Point';
      }
    } catch (e) {
      print(e);
      return '0 Loyalty Point'; // Default fallback in case of error
    }
  }
}

class BookRaw {
  final int id;
  final String title;
  final String? imageUrl;
  final String authorName;
  final double price;
  final int ageAverage;
  String category;

  BookRaw({
    required this.id,
    required this.title,
    required this.authorName,
    required this.price,
    required this.ageAverage,
    required this.category,
    this.imageUrl,
  });

  factory BookRaw.fromJson(Map<String, dynamic> json) {
    return BookRaw(
      id: json['id'] is String
          ? int.parse(json['id'])
          : json['id'], // Handle id as String or int
      title: json['title'] ?? '', // Safely handle missing title
      imageUrl: json['images']?[0]['imageUrl'], // Can be null
      authorName: json['author']?['name'] ??
          'Unknown', // Safely handle missing author name
      price:
          (json['price'] as num?)?.toDouble() ?? 0.0, // Handle price as double
      ageAverage: json['ageAverage'] is String
          ? int.parse(json['ageAverage'])
          : json['ageAverage'] ?? 0, // Handle ageAverage as String or int
      category: json['categories'] ?? 'Unknown',
    );
  }

  factory BookRaw.fromBook(Book book) {
    return BookRaw(
      id: book.id ?? 0,
      title: book.title ?? '',
      imageUrl: book.images?[0].imageUrl,
      authorName: book.author?.name ?? 'Unknown',
      price: book.price ?? 0.0,
      ageAverage: book.ageAverage ?? 0,
      category: book.category != null
          ? (book.category!.isNotEmpty
                  ? book.category?.first.name
                  : 'Unknown') ??
              'Unknown'
          : 'Unknown',
    );
  }

  factory BookRaw.fromBookMostPopular(BookMostPopularResponse book) {
    final String category =
        book.categories != null && book.categories!.isNotEmpty
            ? book.categories!.split(',').first
            : 'Unknown';
    return BookRaw(
      id: book.id ?? 0,
      title: book.title ?? '',
      imageUrl: book.imageUrl ?? '',
      authorName: book.author?.name ?? 'Unknown',
      price: book.price ?? 0.0,
      ageAverage: book.ageAverage ?? 0,
      category: category,
    );
  }

  factory BookRaw.fromRetrieveBookByAuthorId(
      RetrieveBookByAuthorIdResponse book) {
    final String category =
        book.categories != null && book.categories!.isNotEmpty
            ? book.categories!.split(',').first
            : 'Unknown';
    return BookRaw(
      id: book.id ?? 0,
      title: book.title ?? '',
      imageUrl: book.imageUrl ?? '',
      authorName: '',
      price: book.price ?? 0.0,
      ageAverage: book.ageAverage ?? 0,
      category: category,
    );
  }

  factory BookRaw.fromRetrieveBookByCategoryId(
      RetrieveBookByCategoryIdResponse book) {
    final String category =
        book.categories != null && book.categories!.isNotEmpty
            ? book.categories!.split(',').first
            : 'Unknown';
    return BookRaw(
      id: book.id ?? 0,
      title: book.title ?? '',
      imageUrl: book.imageUrl ?? '',
      authorName: book.author?.name ?? 'Unknown',
      price: book.price ?? 0.0,
      ageAverage: book.ageAverage ?? 0,
      category: category,
    );
  }

  factory BookRaw.fromDiscountedBook(DiscountedBookResponse book) {
    final String category =
        book.categories != null && book.categories!.isNotEmpty
            ? book.categories!.split(',').first
            : 'Unknown';
    return BookRaw(
      id: book.id ?? 0,
      title: book.title ?? '',
      imageUrl: book.imageUrl ?? '',
      authorName: book.author?.name ?? 'Unknown',
      price: book.price ?? 0.0,
      ageAverage: book.ageAverage ?? 0,
      category: category,
    );
  }

  factory BookRaw.fromVideoBook(BookAdvancedSearchResponse book) {
    final String category =
        book.categories != null && book.categories!.isNotEmpty
            ? book.categories!.split(',').first
            : 'Unknown';
    return BookRaw(
      id: book.id ?? 0,
      title: book.title ?? '',
      imageUrl: book.imageUrl ?? '',
      authorName: book.authorName ?? 'Unknown',
      price: book.price ?? 0.0,
      ageAverage: book.ageAverage ?? 0,
      category: category,
    );
  }

  factory BookRaw.fromBookBestRated(BookBestRatedResponse book) {
    final String category =
        book.categories != null && book.categories!.isNotEmpty
            ? book.categories!.split(',').first
            : 'Unknown';
    return BookRaw(
      id: book.id ?? 0,
      title: book.title ?? '',
      imageUrl: book.imageUrl ?? '',
      authorName: book.author?.name ?? 'Unknown',
      price: book.price ?? 0.0,
      ageAverage: book.ageAverage ?? 0,
      category: category,
    );
  }

  factory BookRaw.fromBookNew(NewBookResponse book) {
    final String category =
        book.categories != null && book.categories!.isNotEmpty
            ? book.categories!.split(',').first
            : 'Unknown';
    return BookRaw(
      id: book.id ?? 0,
      title: book.title ?? '',
      imageUrl: book.imageUrl ?? '',
      authorName: book.author?.name ?? 'Unknown',
      price: book.price ?? 0.0,
      ageAverage: book.ageAverage ?? 0,
      category: category,
    );
  }

  // The searchBooks method can be uncommented and updated as needed.
}
