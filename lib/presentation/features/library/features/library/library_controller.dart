import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/repos/impl/home_api.swagger.dart';
import '../../api/repos/impl/search_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../generated_code/openapi.models.swagger.dart';

class LibraryController extends AppController {
  var searchController;
  final CategoryApiRepository _categoryApiRepository;
  final NewBookApiRepository _newBookApiRepository;
  final DiscountedBookApiRepository _discountedBookApiRepository;
  final BookBestRatedApiRepository _bookBestRatedApiRepository;
  final MostPopularBookApiRepository _bookMostPopularApiRepository;
  final BookMostOrderedApiRepository _bookMostOrderedApiRepository;
  final BookByCategoryIDApiRepository _bookByCategoryIDApiRepository;

  final RxList<String> features = <String>[].obs;
  RxList<BookMostPopularResponse> books = <BookMostPopularResponse>[].obs;
  var currentCategory = 'New'.obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxList<BookMostPopularResponse> trendingBooks =
      <BookMostPopularResponse>[].obs;
  final RxList<BookAdvancedSearchResponse> listVideos =
      <BookAdvancedSearchResponse>[].obs;
  RxBool isLoadingCarousel = true.obs;
  final RxList<BookBestRatedResponse> recommendedBooks =
      <BookBestRatedResponse>[].obs;
  final RxList<NewBookResponse> newBooks = <NewBookResponse>[].obs;
  final RxList<DiscountedBookResponse> booksOnPromotion =
      <DiscountedBookResponse>[].obs;
  final RxList<BookMostOrderedResponse> mostOrderedBooks =
      <BookMostOrderedResponse>[].obs;
  RxList<RetrieveBookByCategoryIdResponse> categoriesAppResponse =
      <RetrieveBookByCategoryIdResponse>[].obs;
  RxList<RetrieveBookByCategoryIdResponse> religionResponse =
      <RetrieveBookByCategoryIdResponse>[].obs;
  final AdvancedSearchApiRepository _searchApiRepository;

  LibraryController()
      : _categoryApiRepository = CategoryApiRepository(),
        _newBookApiRepository = NewBookApiRepository(),
        _discountedBookApiRepository = DiscountedBookApiRepository(),
        _bookBestRatedApiRepository = BookBestRatedApiRepository(),
        _bookMostPopularApiRepository = MostPopularBookApiRepository(),
        _bookMostOrderedApiRepository = BookMostOrderedApiRepository(),
        _bookByCategoryIDApiRepository = BookByCategoryIDApiRepository(),
        _searchApiRepository = AdvancedSearchApiRepository();

  @override
  Future<void> onInit() async {
    super.onInit();
    searchController = TextEditingController();
    await loadCategories();
    await loadBooks(currentCategory.value);
    await loadFeaturedBooks();
    await loadTrendingBooks();
    await loadRecommendedBooks();
    await loadNewBooks();
    await loadMostOrderedBooks();
    await loadBooksOnPromotion();
    await loadVideoBooks();
    await loadReligions();
  }

  Future<void> loadVideoBooks() async {
    try {
      final response = await _searchApiRepository.advanced_search_books(
          const BookAdvancedSearchRequest(resourceTypes: ['Video']), 20, 1);
      print('response.body: ${response.body}');
      listVideos.assignAll(response.body ?? []);
    } catch (e) {
      print('Error searching books: $e');
    } finally {
      update();
    }
  }

  Future<void> loadBookByCategoryId(int? categoryId) async {
    try {
      final fetchedAuthors = await _bookByCategoryIDApiRepository
          .get_book_by_category_id(categoryId, 30);

      if (fetchedAuthors.body != null &&
          fetchedAuthors.body?.books != null &&
          fetchedAuthors.body!.books!.isNotEmpty) {
        categoriesAppResponse.assignAll(fetchedAuthors.body?.books
                ?.whereType<RetrieveBookByCategoryIdResponse>()
                .toList() ??
            []);
      } else {
        categoriesAppResponse.assignAll([]);
      }
    } catch (e, stacktrace) {
      print('Error loading category id ($categoryId): $e');
      print('Stacktrace: $stacktrace');
    } finally {
      update();
    }
  }

  Future<void> loadReligions() async {
    try {
      final fetchedAuthors =
          await _bookByCategoryIDApiRepository.get_book_by_category_id(30, 30);
      print('fetchedAuthors.body: ${fetchedAuthors.body}');

      if (fetchedAuthors.body != null &&
          fetchedAuthors.body?.books != null &&
          fetchedAuthors.body!.books!.isNotEmpty) {
        religionResponse.assignAll(fetchedAuthors.body?.books
                ?.whereType<RetrieveBookByCategoryIdResponse>()
                .toList() ??
            []);
      } else {
        religionResponse.assignAll([]);
      }
    } catch (e, stacktrace) {
      print('Error loading category id: $e');
      print('Stacktrace: $stacktrace');
    } finally {
      update();
    }
  }

  Future<void> loadBooks(String feature) async {
    isLoadingCarousel.value = true;
    try {
      books.clear();
      await Future.delayed(const Duration(seconds: 2));
      books.assignAll(await _fetchBooks(feature));
    } catch (e) {
      print('Error loading books: $e');
    } finally {
      update(); // Update GetX controller
      isLoadingCarousel.value = false;
    }
  }

  Future<List<BookMostPopularResponse>> _fetchBooks(String feature) async {
    switch (feature) {
      case 'New':
      case 'Hot Releases':
        final fetchedBooks = await _newBookApiRepository.get_new_books();
        return _mapToBooks(fetchedBooks.body);
      case 'New & Hot':
        final fetchedBooks = await _newBookApiRepository.get_new_books();
        return _mapToBooks(fetchedBooks.body);
      case 'Popular':
        final fetchedBooks =
            await _bookMostPopularApiRepository.get_most_popular_book();
        return _mapToBooks(fetchedBooks.body);
      case 'Recommended':
        final fetchedBooks =
            await _discountedBookApiRepository.get_discounted_book();
        return _mapToBooks(fetchedBooks.body);
      case 'Top Picks':
      case "Editor's Choice":
      case 'Must Read':
      case 'Trending':
        final fetchedBooks =
            await _bookMostPopularApiRepository.get_most_popular_book();
        return _mapToBooks(fetchedBooks.body);
      case 'Best Sellers':
        final fetchedBooks =
            await _bookMostOrderedApiRepository.get_most_ordered();
        return _mapToBooks(fetchedBooks.body);
      default:
        return []; // Return empty if no category matches
    }
  }

  List<BookMostPopularResponse> _mapToBooks(List<dynamic>? fetchedBooks) {
    return fetchedBooks
            ?.map((book) => BookMostPopularResponse.fromJson(book.toJson()))
            .whereType<BookMostPopularResponse>()
            .toList() ??
        [];
  }

  Future<void> loadCategories() async {
    try {
      final fetchedCategories = await _categoryApiRepository.get_categories();

      categories.assignAll(
        fetchedCategories.body
                ?.map((category) => Category(
                      id: category
                          .id, // Assuming the API response contains 'id'
                      name: category.name,
                    ))
                .toList() ??
            [],
      );
    } catch (e) {
      print('Error loading categories: $e');
    } finally {
      update();
    }
  }

  Future<void> loadFeaturedBooks() async {
    try {
      // Your featured books fetching logic can go here
      final fetchedBooks = [
        'New',
        'New & Hot',
        'Popular',
        'Trending',
        'Recommended',
        'Top Picks',
        "Editor's Choice",
        'Hot Releases',
        'Best Sellers',
        'Must Read',
      ];
      features.assignAll(fetchedBooks.whereType<String>().toList());
    } catch (e) {
      print('Error loading featured books: $e');
    } finally {
      update();
    }
  }

  // Trending books
  Future<void> loadTrendingBooks() async {
    try {
      final fetchedBooks =
          await _bookMostPopularApiRepository.get_most_popular_book();
      trendingBooks.assignAll(fetchedBooks.body
              ?.map((book) => BookMostPopularResponse.fromJson(book.toJson()))
              .whereType<BookMostPopularResponse>()
              .toList() ??
          []);
    } catch (e) {
      print('Error loading trending books: $e');
    } finally {
      update();
    }
  }

  Future<void> loadRecommendedBooks() async {
    try {
      final fetchedBooks =
          await _bookBestRatedApiRepository.get_best_rated_book();
      recommendedBooks.assignAll(fetchedBooks.body
              ?.map((book) => BookBestRatedResponse.fromJson(book.toJson()))
              .whereType<BookBestRatedResponse>()
              .toList() ??
          []);
    } catch (e) {
      print('Error loading recommended books: $e');
    } finally {
      update();
    }
  }

  //load new books
  Future<void> loadNewBooks() async {
    try {
      final fetchedBooks = await _newBookApiRepository.get_new_books();
      newBooks.assignAll(fetchedBooks.body
              ?.map((book) => NewBookResponse.fromJson(book.toJson()))
              .whereType<NewBookResponse>()
              .toList() ??
          []);
    } catch (e) {
      print('Error loading new books: $e');
    } finally {
      update();
    }
  }

  //load most order
  Future<void> loadMostOrderedBooks() async {
    try {
      final fetchedBooks =
          await _bookMostOrderedApiRepository.get_most_ordered();
      mostOrderedBooks.assignAll(fetchedBooks.body
              ?.map((book) => BookMostOrderedResponse.fromJson(book.toJson()))
              .whereType<BookMostOrderedResponse>()
              .toList() ??
          []);
    } catch (e) {
      print('Error loading most ordered books: $e');
    } finally {
      update();
    }
  }

  //load books on promotion
  Future<void> loadBooksOnPromotion() async {
    try {
      final fetchedBooks =
          await _discountedBookApiRepository.get_discounted_book();
      booksOnPromotion.assignAll(fetchedBooks.body
              ?.map((book) => DiscountedBookResponse.fromJson(book.toJson()))
              .whereType<DiscountedBookResponse>()
              .toList() ??
          []);
    } catch (e) {
      print('Error loading books on promotion: $e');
    } finally {
      update();
    }
  }

  String? calculateBookAge(int ageAverage) {
    if (ageAverage <= 0) {
      return null;
    } else {
      return '$ageAverage';
    }
  }

  /// See more
}
