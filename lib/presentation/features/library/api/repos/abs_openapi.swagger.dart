import 'dart:async';

import 'package:chopper/chopper.dart' as chopper_response;
import 'package:chopper/chopper.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;

import '../../../../../data/preferences/app_preferences.dart';
import '../../generated_code/openapi.swagger.dart' as swagger;
import '../decoder/abs_json_decoder.dart';
import '../decoder/custom_json_decoder.dart';
import '../utils/custom_json_converter.dart';

class RequestInterceptor implements Interceptor {
  RequestInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final token = await getx.Get.find<AppPreferences>().getAccessToken();
    final request =
        applyHeader(chain.request, 'Authorization', 'Bearer $token');
    //content-type
    request.headers['Content-Type'] = 'application/json';
    //utf-8
    request.headers['Accept-Charset'] = 'utf-8';
    return chain.proceed(request);
  }
}

abstract class OpenApiRepository<T> {
  final swagger.Openapi _openapi;
  final AbsJsonDecoder _jsonDecoder;
  final String _baseUrl;
  // Constructor to initialize the swagger OpenAPI client
  OpenApiRepository(this._jsonDecoder)
      : _baseUrl = 'https://lib-dev.educhain.tech/app',
        _openapi = swagger.Openapi.create(
          baseUrl: Uri.parse('https://lib-dev.educhain.tech/app'),
          client: chopper_response.ChopperClient(
            baseUrl: Uri.parse('https://lib-dev.educhain.tech/app'),
            services: [],
            converter: CustomConverter(CustomJsonDecoder({
              T: _jsonDecoder,
            })),
            interceptors: [
              HttpLoggingInterceptor(),
              RequestInterceptor(),
            ],
          ),
        );

  swagger.Openapi get openapi => _openapi;

  /// Helper method to convert Chopper response to Get response
  get_response.Response<T> convertChopperToGetResponse(
      chopper_response.Response<T> chopperResponse) {
    // Convert fields from Chopper response to Get response
    return get_response.Response(
      body: chopperResponse.body,
      statusCode: chopperResponse.statusCode,
      headers: chopperResponse.headers,
      // Map other fields as necessary
    );
  }

  /// Helper method to convert Chopper response to Get response (list)
  get_response.Response<List<T>> convertChopperToGetResponseList(
      chopper_response.Response<List<T>> chopperResponse) {
    // Convert fields from Chopper response to Get response
    return get_response.Response(
      body: chopperResponse.body,
      statusCode: chopperResponse.statusCode,
      headers: chopperResponse.headers,
      // Map other fields as necessary
    );
  }
}
