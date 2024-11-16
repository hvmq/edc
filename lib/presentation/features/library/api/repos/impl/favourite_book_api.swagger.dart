import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;

import '../../../generated_code/openapi.models.swagger.dart';
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class FavouriteBookApiRepository extends OpenApiRepository<Book> {
  FavouriteBookApiRepository()
      : super(DefaultJsonDecoder<Book>((json) => Book.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<List<Book>>> getListFavouriteBooks(
    int? limit,
    int? page,
    List<int>? categories,
    List<int>? authors,
  ) async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBooksFavouriteListGet(
            limit: limit, page: page, authors: authors, categories: categories);

    // Map each book to a Book object
    final List<Book> bookResponses = (chopperResult.body['items'] as List)
        .map((book) => Book.fromJson(book))
        .toList();

    // Return the response wrapped with additional metadata
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: bookResponses,
    );
  }
}
class FavouriteBookFilterApiRepository extends OpenApiRepository<FavouriteFilterData> {
  FavouriteBookFilterApiRepository()
      : super(DefaultJsonDecoder<FavouriteFilterData>((json) => FavouriteFilterData.fromJson(json)));

  // Method to get FavouriteFilterData (not a list, just a single object)
  Future<get_response.Response<FavouriteFilterData>> getListFavouriteBooksFilterData() async {
    try {
      // Make the API call to get favourite book filter data
      final chopper_response.Response<dynamic> chopperResult =
          await openapi.apiAppBooksFavouriteFilterDataGet();
          // await openapi.apiAppBookReviewBookBookIdReviewsGet( );

      // Check if the response body is a Map<String, dynamic>
      if (chopperResult.body is Map<String, dynamic>) {
        final FavouriteFilterData bookResponse = FavouriteFilterData.fromJson(chopperResult.body);

        // Return the response wrapped with additional metadata
        return get_response.Response(
          statusCode: chopperResult.base.statusCode,
          headers: chopperResult.base.headers,
          body: bookResponse,
        );
      } else {
        throw Exception('Invalid response format, expected a Map<String, dynamic>');
      }
    } catch (e) {
      print('Error fetching favourite books: $e');
      rethrow;
    }
  }
}


class CategoryResponse {
  final int id;
  final String name;

  CategoryResponse({required this.id, required this.name});

  // Factory method to create a Category from a JSON object
  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'],
      name: json['name'],
    );
  }
}

class AuthorResponse {
  final int id;
  final String name;

  AuthorResponse({required this.id, required this.name});

  // Factory method to create an Author from a JSON object
  factory AuthorResponse.fromJson(Map<String, dynamic> json) {
    return AuthorResponse(
      id: json['id'],
      name: json['name'],
    );
  }
}

class FavouriteFilterData {
  final List<CategoryResponse> categories;
  final List<AuthorResponse> authors;

  FavouriteFilterData({required this.categories, required this.authors});

  // Factory method to create Data from JSON object
  factory FavouriteFilterData.fromJson(Map<String, dynamic> json) {
    return FavouriteFilterData(
      categories: List<CategoryResponse>.from(
        json['categories'].map((x) => CategoryResponse.fromJson(x)),
      ),
      authors: List<AuthorResponse>.from(
        json['authors'].map((x) => AuthorResponse.fromJson(x)),
      ),
    );
  }
}


