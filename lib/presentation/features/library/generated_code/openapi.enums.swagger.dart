import 'package:json_annotation/json_annotation.dart';

enum PublicBookRequestResponseStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('NEW')
  $new('NEW'),
  @JsonValue('WAITING')
  waiting('WAITING'),
  @JsonValue('PUBLIC')
  public('PUBLIC'),
  @JsonValue('REJECT')
  reject('REJECT'),
  @JsonValue('UNPUBLIC')
  unpublic('UNPUBLIC');

  final String? value;

  const PublicBookRequestResponseStatus(this.value);
}

enum ApiAdminPublicBookIdStatusPostStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('PUBLIC')
  public('PUBLIC'),
  @JsonValue('UNPUBLIC')
  unpublic('UNPUBLIC'),
  @JsonValue('REJECT')
  reject('REJECT'),
  @JsonValue('WAITING')
  waiting('WAITING'),
  @JsonValue('NEW')
  $new('NEW');

  final String? value;

  const ApiAdminPublicBookIdStatusPostStatus(this.value);
}
