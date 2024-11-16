import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;

import '../../../generated_code/openapi.models.swagger.dart';
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class SearchApiRepository extends OpenApiRepository<PaginatedResult> {
  SearchApiRepository()
      : super(DefaultJsonDecoder<PaginatedResult>(
            (json) => PaginatedResult.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<PaginatedResult>> search_books(
      String? keyword, int? limit, int? page) async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<PaginatedResult> chopperResult =
        await openapi.apiAppSearchSearchGet(
            keyword: keyword, limit: limit, page: page);

    // Safely handle the response body and decode it
    final PaginatedResult? paginatedResult = chopperResult.body;

    if (paginatedResult == null) {
      throw Exception('Failed to fetch books');
    }

    // Map each book to a BookSearchResponse object
    final List<BookSearchResponse> bookSearchResponses = paginatedResult.items
            ?.map((book) =>
                _mapBookToBookSearchResponse(book as BookSearchResponse))
            .toList() ??
        [];

    // Return the response wrapped with additional metadata
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: PaginatedResult(
        items: bookSearchResponses,
        totalCount: paginatedResult.totalCount ?? 0,
        limit: paginatedResult.limit ?? 0,
        page: paginatedResult.page ?? 0,
      ),
    );
  }

  // Helper function to map the Book object to BookSearchResponse
  BookSearchResponse _mapBookToBookSearchResponse(BookSearchResponse book) {
    return BookSearchResponse(
      id: book.id,
      title: book.title,
      authorName:
          book.authorName, // Adjust according to how authors are structured
      categories: book.categories,
      tags: book.tags,
    );
  }
}

// Define the BookSearchResponse class to structure the API response
class BookSearchResponse {
  final int id;
  final String title;
  final String authorName;
  final String categories;
  final String tags;

  BookSearchResponse({
    required this.id,
    required this.title,
    required this.authorName,
    required this.categories,
    required this.tags,
  });

  // from Json
  factory BookSearchResponse.fromJson(Map<String, dynamic> json) {
    return BookSearchResponse(
      id: json['id'],
      title: json['title'],
      authorName: json['authorName'],
      categories: json['categories'],
      tags: json['tags'],
    );
  }
}

// Advanced Search Repository
class AdvancedSearchApiRepository
    extends OpenApiRepository<PaginatedResult> {
  AdvancedSearchApiRepository()
      : super(DefaultJsonDecoder<PaginatedResult>(
            (json) => PaginatedResult.fromJson(json)));

  Future<get_response.Response<List<BookAdvancedSearchResponse>>>
      advanced_search_books(
          BookAdvancedSearchRequest? bookSearch, int? limit, int? page) async {
    // Make the API call
    final chopper_response.Response<PaginatedResult> chopperResult =
        await openapi.apiAppSearchAdvancedSearchPost(
            body: bookSearch, limit: limit, page: page);

    // Safely handle the response body and decode it
     final List<BookAdvancedSearchResponse> books = chopperResult
            .body?.items
            ?.map((json) => BookAdvancedSearchResponse.fromJson(json as Map<String, dynamic>))
            .toList() ??
        [];

    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: books,
    );
  }
}

// Define the BookAdvancedSearchResponse class
class BookAdvancedSearchResponse {
  final int? id;
  final String? title;
  final String? authorName;
  final String? publisherName;
  final int? publicationYear;
  final String? language;
  final String? formatType;
  final double? price;
  final double? discountPercentage;
  final String? tags;
  final String? imageUrl;
  final String? categories;
  final int? ageAverage;

  BookAdvancedSearchResponse({
    required this.id,
    required this.title,
    required this.authorName,
    required this.publisherName,
    required this.publicationYear,
    required this.language,
    required this.formatType,
    required this.price,
    required this.discountPercentage,
    required this.tags,
    required this.imageUrl,
    required this.categories,
    required this.ageAverage,
  });

  factory BookAdvancedSearchResponse.fromBook(BookAdvancedSearchResponse book) {
    return BookAdvancedSearchResponse(
      id: book.id,
      title: book.title,
      authorName: book.authorName,
      publisherName: book.publisherName,
      publicationYear: book.publicationYear,
      language: book.language,
      formatType: book.formatType,
      price: book.price,
      discountPercentage: book.discountPercentage,
      tags: book.tags,
      imageUrl: book.imageUrl,
      categories: book.categories,
      ageAverage: book.ageAverage,
    );
  }

  // from Json
  factory BookAdvancedSearchResponse.fromJson(Map<String, dynamic> json) {
    return BookAdvancedSearchResponse(
      id: json['id'],
      title: json['title'],
      authorName: json['authorName'],
      publisherName: json['publisherName'],
      publicationYear: json['publicationYear'],
      language: json['language'],
      formatType: json['resourceType'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      tags: json['tags'],
      imageUrl: json['imageUrl'],
      categories: json["categories"],
      ageAverage: json['ageAverage'],
    );
  }
}

class SuggestedKeywordApiRepository
    extends OpenApiRepository<PaginatedResult> {
  SuggestedKeywordApiRepository()
      : super(DefaultJsonDecoder<PaginatedResult>(
            (json) => PaginatedResult.fromJson(json)));

  Future<get_response.Response<List<SuggestedKeywordResponse>>>
      get_suggested_keywords(String? keyword, int? limit, int? page) async {
    final chopper_response.Response<PaginatedResult> chopperResult =
        await openapi.apiAppSearchSuggestionsGet(keyword: keyword, limit: limit, page: page);
    final List<SuggestedKeywordResponse> suggestedKeywords = chopperResult
            .body?.items
            ?.map((json) => SuggestedKeywordResponse.fromJson(json as Map<String, dynamic>))
            .toList() ??
        [];
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: suggestedKeywords,
    );
  }
}

class SuggestedKeywordResponse {
  final String keyword;

  SuggestedKeywordResponse({
    required this.keyword,
  });

  factory SuggestedKeywordResponse.fromBook(SuggestedKeywordResponse book) {
    return SuggestedKeywordResponse(
      keyword: book.keyword,
    );
  }

  factory SuggestedKeywordResponse.fromJson(Map<String, dynamic> json) {
    return SuggestedKeywordResponse(
      keyword: json['suggestion'],
    );
  }

}
