import '../abs_json_decoder.dart';

class DefaultJsonDecoder<T> implements AbsJsonDecoder<T> {
  final T Function(Map<String, dynamic>) fromJson;

  DefaultJsonDecoder(this.fromJson);

  @override
  T decode(Map<String, dynamic> json) {
    return fromJson(json);
  }

  @override
  List<T> decodeList(List<dynamic> jsonList) {
    // Decode a list of JSON objects into a list of T
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Map<String, T> decodeMap(Map<String, dynamic> jsonMap) {
    // Decode a map of JSON objects into a map of T
    return jsonMap.map(
        (key, value) => MapEntry(key, fromJson(value as Map<String, dynamic>)));
  }
}
