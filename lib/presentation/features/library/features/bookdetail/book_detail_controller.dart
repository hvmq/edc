import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../home/home.dart';
import '../../api/contanst.dart';
import '../../api/repos/impl/book_details_api_swagger.dart';
import '../../api/repos/impl/public_book_api.swagger.dart';
import '../../api/repos/impl/review_book_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../core/utils/show_noti.dart';
import '../../generated_code/openapi.models.swagger.dart';

class BookDetailController extends AppController {
  var authorData = {}.obs;
  RxBool isShowListBook = false.obs;
  RxList<String> reportOptions = [
    'Inappropriate Content',
    'Copyright Infringement',
    'Misinformation',
    'Privacy Violation',
    'Plagiarism',
    'Hate Speech',
    'Illegal Activities',
    'Fraudulent Content',
  ].obs;

  RxString selectedReportOption = ''.obs;
  RxBool selectFavorite = false.obs;
  var feedbackMessage = ''.obs;
  RxBool isLoading = true.obs;
  Rx<Book> bookDetail = const Book().obs;
  RxBool isExpanded = false.obs;
  RxList<Review> bookResponses = <Review>[].obs;
  BookReviewApiRepository bookReviewApiRepository = BookReviewApiRepository();
  MyPurchaseBookApiRepository myPurchaseBookApiRepository =
      MyPurchaseBookApiRepository();
  CheckBookPurchasedApiRepository checkBookPurchasedApiRepository =
      CheckBookPurchasedApiRepository();
  PublicABookRequestApiRepository publicABookRequestApiRepository =
      PublicABookRequestApiRepository();
  GetUserInfoApiRepository getUserInfoApiRepository =
      GetUserInfoApiRepository();

  var userId = 0.obs;
  var isBookPurchased = false.obs;
  var isShowRating = false.obs;
  var bookType = ''.obs;
  var isAlreadySendRequest = false.obs;
  static const String _key = 'publicBookRequests';
  final BookDetailsApiRepository _bookDetailsApiRepository =
      BookDetailsApiRepository();

//using in more like this
  Future<void> init(int idBook) async {
    isLoading.value = true;
    if (Get.arguments['tabName'] != null) {
      bookType.value = Get.arguments['tabName'];
    }
    await getUserInfo();
    await loadBookPurchase();
    await fetchBookDetail(idBook).then(
      (value) {
        //check publish approve
        if (publicBookRequestStatus() == 'PUBLIC') {
          bookType.value = 'Publiced';
        }
      },
    );
    selectFavorite.value = await isBookFavourite(idBook);
    await getListReviewBook(idBook);
    await Future.delayed(const Duration(seconds: 2));

    await hasUserRequestedBook(userId.value, idBook).then((value) {
      isAlreadySendRequest.value = value;
    });

    isLoading.value = false;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    final int idBook =
        Get.arguments['idBook']; // Retrieve idBook from arguments
    init(idBook);
  }

  Future<void> getUserInfo() async {
    final response = await getUserInfoApiRepository.get_info();
    if (response.statusCode == 200 && response.body != null) {
      userId.value = response.body!.id;
    } else {
      showError('Failed to get user info');
    }
  }

  // Save the requested book ID and user ID locally
  Future<void> savePublicBookRequest(int userId, int bookId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> requests = prefs.getStringList(_key) ?? [];

    // Add a new request as a JSON-encoded string
    final Map<String, int> newRequest = {
      'userId': userId,
      'bookId': bookId,
    };
    requests.add(jsonEncode(newRequest));

    await prefs.setStringList(_key, requests);
  }

  // Check if a book has already been requested by a user
  Future<bool> hasUserRequestedBook(int userId, int bookId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> requests = prefs.getStringList(_key) ?? [];

    for (String request in requests) {
      final Map<String, dynamic> decodedRequest = jsonDecode(request);
      if (decodedRequest['userId'] == userId &&
          decodedRequest['bookId'] == bookId) {
        return true;
      }
    }
    return false;
  }

  Future<void> publicABookRequest(int idBook) async {
    final response = await publicABookRequestApiRepository.pubic_a_book(
      idBook,
    );
    if (response.statusCode == 200 && response.body != null) {
      savePublicBookRequest(userId.value, idBook);
      showSuccess(response.body!.message!);
      isAlreadySendRequest.value = true;
    } else {
      showError('Failed to request public book');
    }
  }

  Future<void> loadBookPurchase() async {
    final int idBook = Get.arguments['idBook'];
    final response =
        await checkBookPurchasedApiRepository.check_book_purchased(idBook);
    if (response.statusCode == 200 && response.body != null) {
      isBookPurchased.value = response.body!.isPurchased;
    } else {
      showError('Failed to check book purchase');
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    final int idBook = Get.arguments['idBook'];
    await getListReviewBook(idBook);
  }

  void selectReportOption(String option) {
    selectedReportOption.value = option;
  }

  List<String> getBookImages() {
    // Check if bookDetail contains the 'images' field and it's a list
    if (bookDetail.value.images != null &&
        bookDetail.value.images!.isNotEmpty) {
      // Map the list of images to extract only the 'imageUrl' field
      return bookDetail.value.images!
          .map(
            (e) => e.imageUrl!,
          )
          .toList();
    } else {
      return [];
    }
  }

  String getBookRating() {
    if (bookDetail.value.bookReviewResponse != null) {
      if (bookDetail.value.bookReviewResponse!.averageRating != null) {
        return bookDetail.value.bookReviewResponse!.averageRating!
            .toStringAsFixed(2);
      }
      return '0';
    } else {
      return '0';
    }
  }

  String? getNumberOfBookReviews() {
    if (bookDetail.value.bookReviewResponse != null) {
      if (bookDetail.value.bookReviewResponse!.numberOfReviews != null) {
        return bookDetail.value.bookReviewResponse!.numberOfReviews.toString();
      }
      return '0';
    } else {
      return '0';
    }
  }

  String? publicBookRequestStatus() {
    if (bookDetail.value.publicBookRequestResponse != null) {
      if (bookDetail.value.publicBookRequestResponse!.status != null) {
        return bookDetail.value.publicBookRequestResponse!.status!.value;
      }
      return '';
    } else {
      return '';
    }
  }

  String? getAuthorOfBook() {
    if (bookDetail.value.author != null) {
      return bookDetail.value.author!.name;
    } else {
      return 'Unknown';
    }
  }

  List<String> getCategoriesOfBook() {
    // Check if bookDetail contains the 'images' field and it's a list
    if (bookDetail.value.category != null &&
        bookDetail.value.category!.isNotEmpty) {
      // Map the list of images to extract only the 'imageUrl' field
      return bookDetail.value.category!.map((e) => e.name!).toList();
    } else {
      return [];
    }
  }

  List<String> getTags() {
    // Check if bookDetail contains the 'images' field and it's a list
    if (bookDetail.value.tags != null && bookDetail.value.tags!.isNotEmpty) {
      // Map the list of images to extract only the 'imageUrl' field
      return bookDetail.value.tags!
          .map(
            (e) => e.tagName!,
          )
          .toList();
    } else {
      return [];
    }
  }

  String getCategoryOfBook() {
    final List<String> categories = getCategoriesOfBook();
    return categories.isNotEmpty ? categories.first : '';
  }

  List<String> getTagOfBooks() {
    final List<String> tags = getTags();
    return tags;
  }

  //get first image if any
  String getFirstBookImage() {
    final List<String> images = getBookImages();
    return images.isNotEmpty ? images.first : '';
  }

  // Fetch book data by idBook
  Future<void> fetchBookDetail(int idBook) async {
    try {
      final Response<Book> bookResponse =
          await _bookDetailsApiRepository.get_book_by_id(idBook);
      if (bookResponse.statusCode == 200) {
        bookDetail.value = bookResponse.body!;
        await fetchAuthorDetails(idAuthor: bookDetail.value.author!.id!);
      } else {
        print('Failed to load book data');
      }
    } catch (e) {
      print('Error fetching book details: $e');
    }
  }

  Future<String> postReport(
      {required int bookId, required String comments}) async {
    const url = '$baseUrl/app/book/report'; // Replace with your actual endpoint
    print('Posting comment for book ID: $bookId');
    final Map<String, dynamic> requestBody = {
      'bookId': bookId,
      'comments': comments,
    };
    final String accessToken = Get.find<HomeController>().accessToken;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $accessToken', // Adding the token in the Authorization header
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody), // Encode the request body to JSON
      );

      if (response.statusCode == 200) {
        print('Comment posted successfully.');
        final data = jsonDecode(response.body);
        return data['message'];
      } else {
        return 'Failed to post comment';
      }
    } catch (e) {
      print('Error posting comment: $e');
      return 'Failed to post comment';
    }
  }

  Future<String> toggleFavourite({required int bookId}) async {
    final String url = '$baseUrl/app/books/toggleFavourite?bookId=$bookId';
    print('Toggling favourite for book ID: $bookId');
    final String accessToken = Get.find<HomeController>().accessToken;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $accessToken', // Add your authorization token here
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Favourite toggled successfully.');
        final data = jsonDecode(response.body);
        return data['message'];
      } else {
        return 'Failed to toggle favourite';
      }
    } catch (e) {
      print('Error toggling favourite: $e');
      return 'Failed to toggle favourite';
    }
  }

  Future<bool> isBookFavourite(int bookId) async {
    const String url =
        'https://lib-dev.educhain.tech/app/api/app/books/favouriteListId?page=1&limit=100';
    print('Checking if book ID $bookId is in the favorite list...');
    final String accessToken = Get.find<HomeController>().accessToken;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $accessToken', // Add your authorization token here
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<int> favoriteBooks = List<int>.from(data['data']['items']);

        // Check if the bookId is in the favoriteBooks list
        final bool isFavourite = favoriteBooks.contains(bookId);

        if (isFavourite) {
          print('Book ID $bookId is a favorite.');
        } else {
          print('Book ID $bookId is not a favorite.');
        }

        return isFavourite;
      } else {
        print(
            'Failed to fetch favorite books. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error fetching favorite books: $e');
      return false;
    }
  }

  String convertMinutesToHours(int minutes) {
    final int hours =
        minutes ~/ 60; // Integer division to get the number of hours
    final int remainingMinutes =
        minutes % 60; // Get the remainder for the minutes

    // Build the output string
    String result = '';
    if (hours > 0) {
      result += '$hours hour${hours > 1 ? 's' : ''}';
    }
    if (remainingMinutes > 0) {
      if (result.isNotEmpty) {
        result += ' and '; // Add 'and' if there are both hours and minutes
      }
      result += '$remainingMinutes minute${remainingMinutes > 1 ? 's' : ''}';
    }

    return result.isNotEmpty ? result : '0 minutes';
  }

  String? calculateBookAge(String? bookAge) {
    final int? age = int.tryParse(bookAge ?? '-1');
    if (age == null || age <= 0) {
      return null;
    } else {
      return age.toString();
    }
  }

  Future<void> fetchAuthorDetails({required int idAuthor}) async {
    final String url = '$baseUrl/app/authors/$idAuthor?limit=100';
    final String accessToken = Get.find<HomeController>().accessToken;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $accessToken', // Adding the token in the Authorization header
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes))['data'];
        authorData.value = data; // Assign the parsed data to the observable
        print('authorData: $authorData');
      } else {
        showError('Failed to fetch author details');
      }
    } catch (e) {
      showError('Failed to fetch author details: $e');
    }
  }

  Future<void> getListReviewBook(int bookId) async {
    try {
      final response = await bookReviewApiRepository.getListFavouriteBooks(
        bookId,
        1, // Page number (starting from 1)
        100, // Limit the number of reviews to 100
      );

      if (response.statusCode == 200 && response.body != null) {
        print('bookResponses: ${response.body}');
        bookResponses.value = response.body!;
      } else {
        print(
            'Failed to fetch book reviews. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching book reviews: $e');
    }
  }

  String getFormatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
