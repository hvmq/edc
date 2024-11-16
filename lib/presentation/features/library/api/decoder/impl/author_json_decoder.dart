

import '../../../generated_code/openapi.models.swagger.dart';
import '../abs_json_decoder.dart';

class AuthorJsonDecoder implements AbsJsonDecoder<Author> {
  @override
  Author decode(Map<String, dynamic> json) {
    // Convert updatedAt and createdAt to DateTime based on their types
    json['updatedAt'] = _convertToDateTime(json['updatedAt']);
    json['createdAt'] = _convertToDateTime(json['createdAt']);
    return Author.fromJson(json);
  }

  DateTime? _convertToDateTime(dynamic value) {
    if (value is String) {
      // Attempt to parse the string format
      try {
        return DateTime.parse(value);
      } catch (e) {
        print("Failed to parse date from string: $value");
        return null; // Handle parsing failure if necessary
      }
    } else if (value is int) {
      // Assume it's a timestamp in milliseconds
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return null; // Return null for unexpected formats
  }
}


