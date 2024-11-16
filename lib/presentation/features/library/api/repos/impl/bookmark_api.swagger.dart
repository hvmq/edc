import 'package:chopper/chopper.dart' as chopper_response;
import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;

import '../../../api/decoder/impl/default_json_decoder.dart';
import '../../../api/repos/abs_openapi.swagger.dart';
import '../../../generated_code/openapi.models.swagger.dart';

class Bookmark {
  final int id;
  final int bookId;
  final int userId;
  final int chapterId;
  final double position;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? title;

  Bookmark({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.chapterId,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
  });

  // Factory constructor for creating a Bookmark instance from JSON
  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'] as int,
      bookId: json['bookId'] as int,
      userId: json['userId'] as int,
      chapterId: json['chapterId'] as int,
      position: (json['position'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String?,
    );
  }

  // Method to convert a Bookmark instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'userId': userId,
      'chapterId': chapterId,
      'position': position,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class GetBookmarkApiRepository extends OpenApiRepository<PaginatedResult> {
  GetBookmarkApiRepository()
      : super(DefaultJsonDecoder<PaginatedResult>(
            (json) => PaginatedResult.fromJson(json)));

  Future<get_response.Response<List<Bookmark>>> get_list_bookmark(
      int? bookId, int? chapterId, int? limit, int? page) async {
    // Custom login implementation for this specific API
    final chopper_response.Response<PaginatedResult> chopperResult =
        await openapi.apiAppBookmarksUserBookIdChapterIdGet(
            bookId: bookId, chapterId: chapterId, limit: limit, page: page);

    final PaginatedResult? paginatedResult = chopperResult.body;

    if (paginatedResult == null) {
      throw Exception('Failed to fetch books');
    }

    // Map each book to a BookSearchResponse object
    final List<Bookmark> bookSearchResponses = paginatedResult.items
            ?.map((book) => Bookmark.fromJson(book as Map<String, dynamic>))
            .toList() ??
        [];
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: bookSearchResponses,
    );
  }
}

class CreateBookmarkApiRepository extends OpenApiRepository<Bookmark> {
  CreateBookmarkApiRepository()
      : super(DefaultJsonDecoder<Bookmark>((json) => Bookmark.fromJson(json)));

  Future<get_response.Response<dynamic>> create_bookmark(
      BookmarkAppRequest? body) async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBookmarksPost(body: body);
    print(body);
    print(chopperResult.body);
    print(chopperResult.statusCode);
    print(chopperResult.error);
    if (chopperResult.statusCode == 201) {
      return get_response.Response(
        statusCode: chopperResult.base.statusCode,
        headers: chopperResult.base.headers,
        body: chopperResult.body,
      );
    } else {
      throw Exception('Failed to create bookmark');
    }
  }
}

class DeleteBookmarkApiRepository extends OpenApiRepository<Bookmark> {
  DeleteBookmarkApiRepository()
      : super(DefaultJsonDecoder<Bookmark>((json) => Bookmark.fromJson(json)));

  Future<get_response.Response<dynamic>> delete_bookmark(int? id) async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBookmarksIdDelete(id: id);

    if (chopperResult.statusCode == 200) {
      return get_response.Response(
        statusCode: chopperResult.base.statusCode,
        headers: chopperResult.base.headers,
        body: chopperResult.body,
      );
    } else {
      throw Exception('Failed to create bookmark');
    }
  }
}
