
import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;

import '../../../generated_code/openapi.models.swagger.dart';
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class OrderHistoryDetail {
  final String title;
  final String resourceType;
  final double pricePurchased;
  final DateTime orderedAt;
  final String imageUrl;
  final String paymentMethod;

  OrderHistoryDetail({
    required this.title,
    required this.resourceType,
    required this.pricePurchased,
    required this.orderedAt,
    required this.imageUrl,
    required this.paymentMethod,
  });

  // Factory constructor for creating a BookDetail instance from JSON
  factory OrderHistoryDetail.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDetail(
      title: json['title'] as String,
      resourceType: json['resourceType'] as String,
      pricePurchased: json['pricePurchased'] as double,
      orderedAt: DateTime.parse(json['orderedAt'] as String),
      imageUrl: json['imageUrl'] as String,
      paymentMethod: json['paymentMethod'] as String,
    );
  }

  // Method to convert a BookDetail instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'resourceType': resourceType,
      'pricePurchased': pricePurchased,
      'orderedAt': orderedAt.toIso8601String(),
      'imageUrl': imageUrl,
      'paymentMethod': paymentMethod,
    };
  }
}

class OrderDetailsHistoryApiRepository
    extends OpenApiRepository<PaginatedResult> {
  OrderDetailsHistoryApiRepository()
      : super(DefaultJsonDecoder<PaginatedResult>(
            (json) => PaginatedResult.fromJson(json)));

  Future<get_response.Response<List<OrderHistoryDetail>>> get_order_history(
      {String? sortType = "DESC"}) async {

    final chopper_response.Response<PaginatedResult> chopperResult =
        await openapi.apiAppHistoryOrdersGet(
            limit: 100, page: 1, orderType: sortType);

    final PaginatedResult? paginatedResult = chopperResult.body;

    if (paginatedResult == null) {
      throw Exception('Failed to fetch orders history');
    }

    // Map each book to a BookSearchResponse object
    final List<OrderHistoryDetail> orderHistory = paginatedResult.items
            ?.map((book) =>
                OrderHistoryDetail.fromJson(book as Map<String, dynamic>))
            .toList() ??
        [];
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: orderHistory,
    );
  }
}


class PublicBookHistoryApiRepository
    extends OpenApiRepository<PaginatedResult> {
  PublicBookHistoryApiRepository()
      : super(DefaultJsonDecoder<PaginatedResult>(
            (json) => PaginatedResult.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<List<PublicBookHistoryDetail>>> get_public_book_history(
      {String? status = "WAITING"}) async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<PaginatedResult> chopperResult =
        await openapi.apiAppHistoryPublicBooksGet(
            limit: 100, page: 1, status: status);

    final PaginatedResult? paginatedResult = chopperResult.body;

    if (paginatedResult == null) {
      throw Exception('Failed to fetch public books history');
    }

    final List<PublicBookHistoryDetail> orderHistory = paginatedResult.items
            ?.map((book) =>
                PublicBookHistoryDetail.fromJson(book as Map<String, dynamic>))
            .toList() ??
        [];
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: orderHistory,
    );
  }
}

class PublicBookHistoryDetail {
  final int bookId;
  final String title;
  final double ageAverage;
  final double price;
  final int authorId;
  final String authorName;
  final int publisherId;
  final String publisherName;
  final String imageUrl;
  final DateTime requestedAt;
  final String status;

  PublicBookHistoryDetail({
    required this.bookId,
    required this.title,
    required this.ageAverage,
    required this.price,
    required this.authorId,
    required this.authorName,
    required this.publisherId,
    required this.publisherName,
    required this.imageUrl,
    required this.requestedAt,
    required this.status,
  });

  // Factory constructor to create an instance from JSON
  factory PublicBookHistoryDetail.fromJson(Map<String, dynamic> json) {
    return PublicBookHistoryDetail(
      bookId: json['bookId'] as int,
      title: json['title'] as String,
      ageAverage: json['ageAverage'] as double,
      price: json['price'] as double,
      authorId: json['authorId'] as int,
      authorName: json['authorName'] as String,
      publisherId: json['publisherId'] as int,
      publisherName: json['publisherName'] as String,
      imageUrl: json['imageUrl'] as String,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      status: json['status'] as String,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'title': title,
      'ageAverage': ageAverage,
      'price': price,
      'authorId': authorId,
      'authorName': authorName,
      'publisherId': publisherId,
      'publisherName': publisherName,
      'imageUrl': imageUrl,
      'requestedAt': requestedAt.toIso8601String(),
      'status': status,
    };
  }
}



class BookProgressHistoryApiRepository
    extends OpenApiRepository<BookReadingResponse> {
  BookProgressHistoryApiRepository()
      : super(DefaultJsonDecoder<BookReadingResponse>(
            (json) => BookReadingResponse.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<List<BookReadingResponse>>> get_book_progress_history() async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<List<BookReadingResponse>> chopperResult =
        await openapi.apiAppHistoryReadingProgressGet(limit: 100);

    final result = chopperResult.body;

    if (result == null) {
      throw Exception('Failed to fetch public books history');
    }

    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: result,
    );
  }
//    Future<List<BookProgress>> fetchReadingProgress() async {
//     final response = await http.get(
//       Uri.parse("https://lib-dev.educhain.tech/app/api/app/history/reading-progress?limit=10"),
//       headers: {
//         'accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       //utf 8 decode
//       final List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
//       return jsonData.map((item) => BookProgress.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load reading progress');
//     }
//   }
}

class BookProgress {
  final int progressId;
  final int userId;
  final bool isCompleted;
  final int currentChapter;
  final int totalChapters;
  final int currentPage;
  final int totalPage;
  final DateTime lastReadAt;
  final int bookId;
  final String title;
  final double ageAverage;
  final int authorId;
  final String authorName;
  final int publisherId;
  final String publisherName;
  final double price;
  final DateTime createdAt;
  final String imageUrl;

  BookProgress({
    required this.progressId,
    required this.userId,
    required this.isCompleted,
    required this.currentChapter,
    required this.totalChapters,
    required this.currentPage,
    required this.totalPage,
    required this.lastReadAt,
    required this.bookId,
    required this.title,
    required this.ageAverage,
    required this.authorId,
    required this.authorName,
    required this.publisherId,
    required this.publisherName,
    required this.price,
    required this.createdAt,
    required this.imageUrl,
  });

  factory BookProgress.fromJson(Map<String, dynamic> json) {
    return BookProgress(
      progressId: json['progressId'] as int,
      userId: json['userId'] as int,
      isCompleted: json['isCompleted'] as bool,
      currentChapter: json['currentChapter'] as int,
      totalChapters: json['totalChapters'] as int,
      currentPage: json['currentPage'] as int,
      totalPage: json['totalPage'] as int,
      lastReadAt: DateTime.parse(json['lastReadAt'] as String),
      bookId: json['bookId'] as int,
      title: json['title'] as String,
      ageAverage: json['ageAverage'] as double,
      authorId: json['authorId'] as int,
      authorName: json['authorName'] as String,
      publisherId: json['publisherId'] as int,
      publisherName: json['publisherName'] as String,
      price: json['price'] as double,
      createdAt: DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'progressId': progressId,
      'userId': userId,
      'isCompleted': isCompleted,
      'currentChapter': currentChapter,
      'totalChapters': totalChapters,
      'currentPage': currentPage,
      'totalPage': totalPage,
      'lastReadAt': lastReadAt.toIso8601String(),
      'bookId': bookId,
      'title': title,
      'ageAverage': ageAverage,
      'authorId': authorId,
      'authorName': authorName,
      'publisherId': publisherId,
      'publisherName': publisherName,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}

