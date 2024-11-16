import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;

import '../../../generated_code/openapi.models.swagger.dart';
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class MostPopularBookApiRepository
    extends OpenApiRepository<BookMostPopularResponse> {
  MostPopularBookApiRepository()
      : super(DefaultJsonDecoder<BookMostPopularResponse>(
            (json) => BookMostPopularResponse.fromJson(json)));

  Future<get_response.Response<List<BookMostPopularResponse>>>
      get_most_popular_book() async {
    final chopper_response.Response<List<BookMostPopularResponse>>
        chopperResult = await openapi.apiAppHomeMostPopularBooksGet();
    return convertChopperToGetResponseList(chopperResult);
  }
}

class BookMostOrderedApiRepository
    extends OpenApiRepository<BookMostOrderedResponse> {
  BookMostOrderedApiRepository()
      : super(DefaultJsonDecoder<BookMostOrderedResponse>(
            (json) => BookMostOrderedResponse.fromJson(json)));

  Future<get_response.Response<List<BookMostOrderedResponse>>>
      get_most_ordered() async {
    final chopper_response.Response<List<BookMostOrderedResponse>>
        chopperResult = await openapi.apiAppHomeMostOrderedBooksGet();
    return convertChopperToGetResponseList(chopperResult);
  }
}

class NewBookApiRepository extends OpenApiRepository<NewBookResponse> {
  NewBookApiRepository()
      : super(DefaultJsonDecoder<NewBookResponse>(
            (json) => NewBookResponse.fromJson(json)));

  Future<get_response.Response<List<NewBookResponse>>> get_new_books() async {
    final chopper_response.Response<List<NewBookResponse>> chopperResult =
        await openapi.apiAppHomeNewBooksGet();
    return convertChopperToGetResponseList(chopperResult);
  }
}

class DiscountedBookApiRepository
    extends OpenApiRepository<DiscountedBookResponse> {
  DiscountedBookApiRepository()
      : super(DefaultJsonDecoder<DiscountedBookResponse>(
            (json) => DiscountedBookResponse.fromJson(json)));

  Future<get_response.Response<List<DiscountedBookResponse>>>
      get_discounted_book() async {
    final chopper_response.Response<List<DiscountedBookResponse>>
        chopperResult = await openapi.apiAppHomeDiscountedBooksGet();
    return convertChopperToGetResponseList(chopperResult);
  }
}

class BookBestRatedApiRepository
    extends OpenApiRepository<BookBestRatedResponse> {
  BookBestRatedApiRepository()
      : super(DefaultJsonDecoder<BookBestRatedResponse>(
            (json) => BookBestRatedResponse.fromJson(json)));

  Future<get_response.Response<List<BookBestRatedResponse>>>
      get_best_rated_book() async {
    final chopper_response.Response<List<BookBestRatedResponse>> chopperResult =
        await openapi.apiAppHomeBestRatedBooksGet();
    return convertChopperToGetResponseList(chopperResult);
  }
}

class CategoryApiRepository extends OpenApiRepository<Category> {
  CategoryApiRepository()
      : super(DefaultJsonDecoder<Category>((json) {
          return Category.fromJson(json);
        }));
  Future<get_response.Response<List<Category>>> get_categories() async {
    final chopper_response.Response<List<Category>> chopperResult =
        await openapi.apiAppHomeCategoriesGet(page : 1, limit : 100);
    return convertChopperToGetResponseList(chopperResult);
  }
}

class BookByCategoryIDApiRepository
    extends OpenApiRepository<CategoryAppResponse> {
  BookByCategoryIDApiRepository()
      : super(DefaultJsonDecoder<CategoryAppResponse>((json) {
          return CategoryAppResponse.fromJson(json);
        }));

  Future<get_response.Response<CategoryAppResponse>> get_book_by_category_id(
      int? category_id, int? limit) async {
    final chopper_response.Response<CategoryAppResponse> chopperResult =
        await openapi.apiAppCategoriesIdGet(id: category_id, limit: limit);
    return convertChopperToGetResponse(chopperResult);
  }
}
