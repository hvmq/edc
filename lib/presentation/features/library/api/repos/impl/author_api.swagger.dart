import 'package:chopper/chopper.dart' as chopper_response;
import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;

import '../../../api/decoder/impl/default_json_decoder.dart';
import '../../../api/repos/abs_openapi.swagger.dart';
import '../../../generated_code/openapi.models.swagger.dart';

class AuthorApiRepository extends OpenApiRepository<Author> {
  AuthorApiRepository()
      : super(DefaultJsonDecoder<Author>((json) => Author.fromJson(json)));

  Future<get_response.Response<List<Author>>> get_authors(
      int? limit, int? page) async {
    // Custom login implementation for this specific API
    final chopper_response.Response<List<Author>> chopperResult =
        await openapi.apiAppAuthorsGet(limit: limit, page: page);
    return convertChopperToGetResponseList(chopperResult);
  }
}

class GetAuthorApiRepository extends OpenApiRepository<AuthorAppResponse> {
  GetAuthorApiRepository()
      : super(DefaultJsonDecoder<AuthorAppResponse>(
            (json) => AuthorAppResponse.fromJson(json)));

  Future<get_response.Response<AuthorAppResponse>> get_author(int? id) async {
    final chopper_response.Response<AuthorAppResponse> chopperResult =
        await openapi.apiAppAuthorsIdGet(id: id);
    return convertChopperToGetResponse(chopperResult);
  }
}
