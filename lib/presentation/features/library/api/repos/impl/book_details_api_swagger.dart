import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;

import '../../../generated_code/openapi.models.swagger.dart';
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class BookDetailsApiRepository extends OpenApiRepository<Book> {
  BookDetailsApiRepository()
      : super(DefaultJsonDecoder<Book>((json) => Book.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<Book>> get_book_by_id(int? bookId) async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<Book> chopperResult =
        await openapi.apiAppBooksIdGet(id: bookId);

    // Safely handle the response body and decode it
    final Book? book = chopperResult.body;

    if (book == null) {
      throw Exception('Failed to fetch books');
    }

    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: book,
    );
  }
}

class MyPurchaseBookApiRepository extends OpenApiRepository<PaginatedResult> {
  MyPurchaseBookApiRepository()
      : super(DefaultJsonDecoder<PaginatedResult>(
            (json) => PaginatedResult.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<List<Book>>> get_list_my_purchase_book() async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBooksMyPurchasedBooksGet(
            limit: 1000, page: 1, sort: 'Author', type: 'Asc');

    // Safely handle response and convert to List<Book>
    final List<Book> books = (chopperResult.body['items'] as List<dynamic>)
        .map((json) => Book.fromJson(json as Map<String, dynamic>))
        .toList();

    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: books,
    );
  }
}

class CheckBookPurchasedApiRepository extends OpenApiRepository<CheckPurchasedResponse> {
  CheckBookPurchasedApiRepository()
      : super(DefaultJsonDecoder<CheckPurchasedResponse>(
            (json) => CheckPurchasedResponse.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<CheckPurchasedResponse>> check_book_purchased(int? bookId) async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppOrderCheckBookPurchasedGet(bookId: bookId);

    final CheckPurchasedResponse books = CheckPurchasedResponse.fromJson(chopperResult.body[0] as Map<String, dynamic>);

    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: books,
    );
  }
}

class CheckPurchasedResponse {
  final bool isPurchased;
  final int bookId;

  CheckPurchasedResponse({required this.isPurchased, required this.bookId});

  factory CheckPurchasedResponse.fromJson(Map<String, dynamic> json) {
    return CheckPurchasedResponse(
      isPurchased: json['isPurchased'],
      bookId: json['bookId'],
    );
  }
}
