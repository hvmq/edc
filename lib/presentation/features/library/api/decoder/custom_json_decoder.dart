import '../../generated_code/openapi.swagger.dart';
import 'abs_json_decoder.dart';

class CustomJsonDecoder {
  CustomJsonDecoder(this.decoders);

  final Map<Type, AbsJsonDecoder<dynamic>> decoders;

  dynamic decode<T>(dynamic entity) {
    if (T == dynamic) {
      return entity;
    }

    if (T == int || T == String || T == bool || T == double) {
      return entity;
    }

    if (T != PaginatedResult &&
        entity is! List<dynamic> &&
        entity is Map<String, dynamic> &&
        entity.containsKey('items')) {
      entity = entity['items'];
    }
    if (entity is Iterable && T != List) {
      return _decodeList<T>(entity);
    }

    if (entity is Map<String, dynamic> && T != Map) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final decoder = decoders[T];
    if (decoder == null) {
      throw 'Could not find decoder for type $T.';
    }
    return decoder.decode(values) as T;
  }

  List<T> _decodeList<T>(Iterable values) {
    return values.map<T>((v) => decode<T>(v)).toList();
  }
}
