
import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;

import '../../../generated_code/openapi.models.swagger.dart';
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class CreateUserProgressApiRepository
    extends OpenApiRepository<PaginatedResult> {
  CreateUserProgressApiRepository()
      : super(DefaultJsonDecoder<PaginatedResult>(
            (json) => PaginatedResult.fromJson(json)));

  Future<get_response.Response<dynamic>> create_user_progress(
      UserReadingProgressAppRequest userReadingProgressAppRequest) async {
    final chopper_response.Response<dynamic> chopperResult = await openapi
        .apiAppReadingProgressPost(body: userReadingProgressAppRequest);

    if (chopperResult.body == null) {
      throw Exception('Failed to create user progress');
    }

    if (chopperResult.statusCode == 201) {
      return get_response.Response(
        statusCode: chopperResult.base.statusCode,
        headers: chopperResult.base.headers,
        body: {
          "message": chopperResult.body,
          "status": chopperResult.statusCode
        },
      );
    } else {
      throw Exception('Failed to create user progress');
    }
  }
}

class GetUserProgressApiRepository
    extends OpenApiRepository<UserReadingProgress> {
  GetUserProgressApiRepository()
      : super(DefaultJsonDecoder<UserReadingProgress>(
            (json) => UserReadingProgress.fromJson(json)));

  // Future<get_response.Response<UserReadingProgress>> get_user_progress(
  //     int? bookId) async {
  //   final chopper_response.Response<UserReadingProgress> chopperResult =
  //       await openapi.apiAppReadingProgressUserBookIdGet(bookId: bookId);

  //   if (chopperResult.body == null) {
  //     throw Exception('Failed to get user progress');
  //   }

  //   if (chopperResult.statusCode == 200) {
  //     return get_response.Response(
  //       statusCode: chopperResult.base.statusCode,
  //       headers: chopperResult.base.headers,
  //       body: chopperResult.body,
  //     );
  //   } else {
  //     throw Exception('Failed to create user progress');
  //   }
  // }
  
}
