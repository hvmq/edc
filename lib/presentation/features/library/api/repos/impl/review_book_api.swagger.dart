import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;

import '../../../generated_code/openapi.models.swagger.dart';
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class BookReviewApiRepository extends OpenApiRepository<Review> {
  BookReviewApiRepository()
      : super(DefaultJsonDecoder<Review>(
            (json) => Review.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<List<Review>>> getListFavouriteBooks(
    int? bookId,
    int? page,
    int? limit,
  ) async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBookReviewBookBookIdReviewsGet(
            bookId: bookId, page: page, limit: limit);
    // Map each book to a Book object
    final List<Review> bookResponses =
        (chopperResult.body["items"] as List)
            .map((book) => Review.fromJson(book))
            .toList();

    // Return the response wrapped with additional metadata
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: bookResponses,
    );
  }
}

class BookReviewResponse {
  final int bookId;
  final int userId;
  final int rating;
  final String reviewText;

  BookReviewResponse({
    required this.bookId,
    required this.userId,
    required this.rating,
    required this.reviewText
  });

  // Factory method to create an instance of BookReviewResponse from JSON
  factory BookReviewResponse.fromJson(Map<String, dynamic> json) {
    return BookReviewResponse(
      bookId: json['bookId'],
      userId: json['userId'],
      rating: json['rating'],
      reviewText: json['reviewText']
    );
  }
}

class CreateBookReviewApiRepository
    extends OpenApiRepository<BookReviewResponse> {
  CreateBookReviewApiRepository()
      : super(DefaultJsonDecoder<BookReviewResponse>(
            (json) => BookReviewResponse.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<BookReviewResponse>> createReview(
    BookReviewRequest? bookReviewRequest,
  ) async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBookReviewCreatePost(body: bookReviewRequest);

    // Map each book to a Book object
    final BookReviewResponse bookResponses =
        BookReviewResponse.fromJson(chopperResult.body as Map<String, dynamic>);

    // Return the response wrapped with additional metadata
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: bookResponses,
    );
  }
}

class Review {
  final int id;
  final int bookId;
  final int userId;
  final int rating;
  final String reviewText;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool deleted;
  final String? userName;
  final String? avatarUrl;

  Review({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.rating,
    required this.reviewText,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
    required this.userName,
    required this.avatarUrl,
  });

  // Factory method to create an instance of Review from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      bookId: json['bookId'],
      userId: json['userId'],
      rating: json['rating'],
      reviewText: json['reviewText'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deleted: json['deleted'],
      userName: json['userName'],
      avatarUrl: json['avatarUrl'],
    );
  }

  // Method to convert the Review object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'userId': userId,
      'rating': rating,
      'reviewText': reviewText,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deleted': deleted,
    };
  }
}

