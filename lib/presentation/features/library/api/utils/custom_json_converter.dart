import 'dart:async';
import 'package:chopper/chopper.dart' as chopper;

import '../decoder/custom_json_decoder.dart';

class CustomConverter extends chopper.JsonConverter {
  final CustomJsonDecoder jsonDecoder;
  // Constructor to initialize the CustomJsonDecoder
  const CustomConverter(this.jsonDecoder);

  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // Handle 204 No Content case
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = await super.convertResponse(response);
    final decodedBody = jsonRes.body;

    // Handle cases where the response is wrapped inside an outer object (e.g., { items: [...] })
    if (decodedBody is Map<String, dynamic>) {
      //decoded contain items or data
      if (decodedBody.containsKey('items')) {
        final items = decodedBody;
        // Decode as List<Item> if items exist
        return jsonRes.copyWith<ResultType>(
          body: jsonDecoder.decode<Item>(items) as ResultType,
        );
      } else if (decodedBody.containsKey('data')) {
        final data = decodedBody['data'];

        if (ResultType == int || ResultType == String || ResultType == bool || ResultType == double) {
           if (data is Map<String, dynamic> && data.containsKey('id')) {
            return jsonRes.copyWith<ResultType>(
              body: data['id'] as ResultType, // Extract the id directly
            );
          }
        }
        // Decode as List<Item> if items exist
        return jsonRes.copyWith<ResultType>(
          body: jsonDecoder.decode<Item>(data) as ResultType,
        );
      } else {
        // Decode as Item if no items exist
        return jsonRes.copyWith<ResultType>(
          body: jsonDecoder.decode<Item>(decodedBody) as ResultType,
        );
      }
    }

    // Handle single object (Map) or raw list (List)
    if (decodedBody is Map<String, dynamic>) {
      return jsonRes.copyWith<ResultType>(
        body: jsonDecoder.decode<Item>(decodedBody) as ResultType,
      );
    } else if (decodedBody is List) {
      return jsonRes.copyWith<ResultType>(
        body: jsonDecoder.decode<Item>(decodedBody) as ResultType,
      );
    }

    // Return as-is if the response type is unexpected
    return response.copyWith();
  }
}
