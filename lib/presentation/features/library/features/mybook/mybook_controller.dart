import 'dart:async';
import 'dart:convert'; // For decoding JSON

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // HTTP package for API calls

import '../../../home/home.dart';
import '../../core/controllers/app_controller.dart';

class MybookController extends AppController {
  final searchController = TextEditingController().obs;
  RxBool isShow = false.obs;
  RxString tabName = 'Purchased'.obs;
  RxBool isAuthor = true.obs;
  RxBool isLoading = false.obs;
  final RxList<BookRaw> books = <BookRaw>[].obs;
  // final RxList<Author> authors = <Author>[].obs;
  // final RxList<Category> categories = <Category>[].obs;
  // New property to hold grouped books
  final RxMap<String, List<BookRaw>> groupedBooks =
      <String, List<BookRaw>>{}.obs;
  final RxMap<String, List<BookRaw>> groupedBookCate =
      <String, List<BookRaw>>{}.obs;
  final RxList<BookRaw> filteredBooks = <BookRaw>[].obs;
  RxMap<String, List<BookRaw>> booksByAuthor = <String, List<BookRaw>>{}.obs;
  RxMap<String, List<BookRaw>> booksByDate = <String, List<BookRaw>>{}.obs;
  RxBool isVideo = false.obs;
  @override
  Future<void> onInit() async {
    isLoading.value = true;

    final bool isVideoArg = Get.arguments['isVideo'];
    if (isVideoArg) {
      isVideo.value = true;
    } else {
      isVideo.value = false;
    }
    await fetchBooksPurchased();
    await loadBookByAuthors();
    isLoading.value = false;
    super.onInit();
  }

  void turnOnPublic() {
    tabName.value = 'Publiced';
  }

  void turnOnUnPublic() {
    tabName.value = 'UnPubliced';
  }

  void turnOnPurchased() {
    tabName.value = 'Purchased';
  }

  // Function to update filtered books
  void updateFilteredBooks(String query) {
    if (query.isEmpty) {
      filteredBooks.value = books; // Show all books if search query is empty
    } else {
      filteredBooks.value = books.where((book) {
        return book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.authorName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  String? calculateBookAge(int ageAverage) {
    if (ageAverage <= 0) {
      return null;
    } else {
      return '$ageAverage';
    }
  }

  // Function to fetch the list of books
  Future<void> fetchBooksPurchased({int page = 1, int limit = 1000}) async {
    books.clear();
    const String url =
        'https://lib-dev.educhain.tech/app/api/app/books/myPurchasedBooks';

    // Append query parameters for pagination, sorting, etc.
    final Uri uri =
        Uri.parse('$url?page=$page&limit=$limit&sort=Author&type=Asc');
    final String accessToken = Get.find<HomeController>().accessToken;
    try {
      // Make the GET request
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        final data = json.decode(utf8.decode(response.bodyBytes));
        // Safely extract the list of books
        if (data != null && data['data']['items'] != null) {
          // Map the JSON data to BookRaw objects
          final List<BookRaw> fetchedBooks = (data['data']['items'] as List)
              .map((bookJson) => BookRaw.fromJson(bookJson))
              .toList();
          // Update the observable list of books
          //if isVideo = true, filter book is video
          if (isVideo.value) {
            books.assignAll(fetchedBooks
                .where((book) => book.resourceType!.toUpperCase() == 'VIDEO')
                .toList());
          } else {
            books.assignAll(fetchedBooks
                .where((book) => book.resourceType!.toUpperCase() != 'VIDEO')
                .toList());
          }
        }
      } else {
        // Handle non-successful responses
        print('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors during the request
      print('Error fetching books: $e');
    }
  }

  // Function to fetch the list of books
  Future<void> fetchBooksPublic({int page = 1, int limit = 1000}) async {
    books.clear();
    final String token = Get.find<HomeController>().accessToken;
    const String url =
        'https://lib-dev.educhain.tech/app/api/app/books/myUploadBooks';

    // Append query parameters for pagination, sorting, etc.
    final Uri uri = Uri.parse(
        '$url?page=$page&limit=$limit&isPublished=1&sort=Author&type=Asc');
    try {
      // Make the GET request
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        final data = json.decode(utf8.decode(response.bodyBytes));
        // Safely extract the list of books
        if (data != null && data['data']['items'] != null) {
          // Map the JSON data to BookRaw objects
          final List<BookRaw> fetchedBooks = (data['data']['items'] as List)
              .map((bookJson) => BookRaw.fromJson(bookJson))
              .toList();
          if (isVideo.value) {
            books.assignAll(fetchedBooks
                .where((book) => book.resourceType!.toUpperCase() == 'VIDEO')
                .toList());
          } else {
            books.assignAll(fetchedBooks
                .where((book) => book.resourceType!.toUpperCase() != 'VIDEO')
                .toList());
          }
        }
      } else {
        // Handle non-successful responses
        print('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors during the request
      print('Error fetching books: $e');
    }
  }

  Future<void> loadBookByAuthors() async {
    isLoading.value = true;
    booksByAuthor.clear();
    for (var book in books.value) {
      final String authorName = book.authorName;

      if (booksByAuthor.containsKey(authorName)) {
        booksByAuthor[authorName]!.add(book);
      } else {
        booksByAuthor[authorName] = [book];
      }
    }
    isLoading.value = false;
  }

  Future<void> loadBookByDate() async {
    isLoading.value = true;
    booksByDate.clear();

    for (var book in books.value) {
      // Format the `createdAt` date
      final String formattedDate =
          DateFormat('yyyy-MM-dd').format(book.createdAt);

      // Group books by their `createdAt` date
      if (booksByDate.containsKey(formattedDate)) {
        booksByDate[formattedDate]!.add(book);
      } else {
        booksByDate[formattedDate] = [book];
      }
    }
    print('Books by date: $booksByDate');
    isLoading.value = false;
  }

  Future<void> fetchBooksUnPublic({int page = 1, int limit = 1000}) async {
    books.clear();

    const String url =
        'https://lib-dev.educhain.tech/app/api/app/books/myUploadBooks';

    // Append query parameters for pagination, sorting, etc.
    final Uri uri = Uri.parse(
        '$url?page=$page&limit=$limit&isPublished=0&sort=Author&type=Asc');
    final String token = Get.find<HomeController>().accessToken;
    try {
      // Make the GET request
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        final data = json.decode(utf8.decode(response.bodyBytes));
        print(data);
        // Safely extract the list of books
        if (data != null && data['data']['items'] != null) {
          // Map the JSON data to BookRaw objects
          final List<BookRaw> fetchedBooks = (data['data']['items'] as List)
              .map((bookJson) => BookRaw.fromJson(bookJson))
              .toList();
          // Update the observable list of books
          if (isVideo.value) {
            books.assignAll(fetchedBooks
                .where((book) => book.resourceType!.toUpperCase() == 'VIDEO')
                .toList());
          } else {
            books.assignAll(fetchedBooks
                .where((book) => book.resourceType!.toUpperCase() != 'VIDEO')
                .toList());
          }
        }
      } else {
        // Handle non-successful responses
        print('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors during the request
      print('Error fetching books: $e');
    }
  }
}

class Author {
  final int id;
  final String name;

  Author({required this.id, required this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
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
  final DateTime createdAt;
  final String? resourceType;
  BookRaw({
    required this.id,
    required this.title,
    required this.authorName,
    required this.price,
    required this.ageAverage,
    required this.category,
    required this.createdAt,
    required this.resourceType,
    this.imageUrl,
  });

  factory BookRaw.fromJson(Map<String, dynamic> json) {
    var imageUrl = '';
    if (json['images'] != null && json['images'].isNotEmpty) {
      imageUrl = json['images'][0]['imageUrl'];
    }
    return BookRaw(
      id: json['id'] is String
          ? int.parse(json['id'])
          : json['id'], // Handle id as String or int
      title: json['title'] ?? '', // Safely handle missing title
      imageUrl: imageUrl, // Can be null
      authorName: json['author']?['name'] ??
          'Unknown', // Safely handle missing author name
      price:
          (json['price'] as num?)?.toDouble() ?? 0.0, // Handle price as double
      ageAverage: json['ageAverage'] is String
          ? int.parse(json['ageAverage'])
          : json['ageAverage'] ?? 0, // Handle ageAverage as String or int
      category: json['categories'] ?? 'Unknown',
      createdAt: DateTime.parse(json['createdAt']),
      resourceType: json['resourceType'],
    );
  }
}
