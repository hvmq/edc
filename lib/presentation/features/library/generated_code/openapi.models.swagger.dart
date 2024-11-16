// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'openapi.enums.swagger.dart' as enums;

part 'openapi.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class ContentModeration {
  const ContentModeration({
    this.id,
    this.bookId,
    this.status,
    this.moderatedBy,
    this.comments,
    this.moderatedAt,
    this.data,
  });

  factory ContentModeration.fromJson(Map<String, dynamic> json) =>
      _$ContentModerationFromJson(json);

  static const toJsonFactory = _$ContentModerationToJson;
  Map<String, dynamic> toJson() => _$ContentModerationToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'status', includeIfNull: false)
  final String? status;
  @JsonKey(name: 'moderatedBy', includeIfNull: false)
  final int? moderatedBy;
  @JsonKey(name: 'comments', includeIfNull: false)
  final String? comments;
  @JsonKey(name: 'moderatedAt', includeIfNull: false)
  final DateTime? moderatedAt;
  @JsonKey(name: 'data', includeIfNull: false)
  final Map<String, dynamic>? data;
  static const fromJsonFactory = _$ContentModerationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ContentModeration &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.moderatedBy, moderatedBy) ||
                const DeepCollectionEquality()
                    .equals(other.moderatedBy, moderatedBy)) &&
            (identical(other.comments, comments) ||
                const DeepCollectionEquality()
                    .equals(other.comments, comments)) &&
            (identical(other.moderatedAt, moderatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.moderatedAt, moderatedAt)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(moderatedBy) ^
      const DeepCollectionEquality().hash(comments) ^
      const DeepCollectionEquality().hash(moderatedAt) ^
      const DeepCollectionEquality().hash(data) ^
      runtimeType.hashCode;
}

extension $ContentModerationExtension on ContentModeration {
  ContentModeration copyWith(
      {int? id,
      int? bookId,
      String? status,
      int? moderatedBy,
      String? comments,
      DateTime? moderatedAt,
      Map<String, dynamic>? data}) {
    return ContentModeration(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        status: status ?? this.status,
        moderatedBy: moderatedBy ?? this.moderatedBy,
        comments: comments ?? this.comments,
        moderatedAt: moderatedAt ?? this.moderatedAt,
        data: data ?? this.data);
  }

  ContentModeration copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<int?>? bookId,
      Wrapped<String?>? status,
      Wrapped<int?>? moderatedBy,
      Wrapped<String?>? comments,
      Wrapped<DateTime?>? moderatedAt,
      Wrapped<Map<String, dynamic>?>? data}) {
    return ContentModeration(
        id: (id != null ? id.value : this.id),
        bookId: (bookId != null ? bookId.value : this.bookId),
        status: (status != null ? status.value : this.status),
        moderatedBy:
            (moderatedBy != null ? moderatedBy.value : this.moderatedBy),
        comments: (comments != null ? comments.value : this.comments),
        moderatedAt:
            (moderatedAt != null ? moderatedAt.value : this.moderatedAt),
        data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class ContentModerationRequest {
  const ContentModerationRequest({
    this.bookId,
    this.comments,
  });

  factory ContentModerationRequest.fromJson(Map<String, dynamic> json) =>
      _$ContentModerationRequestFromJson(json);

  static const toJsonFactory = _$ContentModerationRequestToJson;
  Map<String, dynamic> toJson() => _$ContentModerationRequestToJson(this);

  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'comments', includeIfNull: false)
  final String? comments;
  static const fromJsonFactory = _$ContentModerationRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ContentModerationRequest &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.comments, comments) ||
                const DeepCollectionEquality()
                    .equals(other.comments, comments)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(comments) ^
      runtimeType.hashCode;
}

extension $ContentModerationRequestExtension on ContentModerationRequest {
  ContentModerationRequest copyWith({int? bookId, String? comments}) {
    return ContentModerationRequest(
        bookId: bookId ?? this.bookId, comments: comments ?? this.comments);
  }

  ContentModerationRequest copyWithWrapped(
      {Wrapped<int?>? bookId, Wrapped<String?>? comments}) {
    return ContentModerationRequest(
        bookId: (bookId != null ? bookId.value : this.bookId),
        comments: (comments != null ? comments.value : this.comments));
  }
}

@JsonSerializable(explicitToJson: true)
class AdminFileUploadFormRequest {
  const AdminFileUploadFormRequest({
    this.fileData,
    this.classify,
    this.id,
  });

  factory AdminFileUploadFormRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminFileUploadFormRequestFromJson(json);

  static const toJsonFactory = _$AdminFileUploadFormRequestToJson;
  Map<String, dynamic> toJson() => _$AdminFileUploadFormRequestToJson(this);

  @JsonKey(name: 'fileData', includeIfNull: false)
  final String? fileData;
  @JsonKey(name: 'classify', includeIfNull: false)
  final String? classify;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  static const fromJsonFactory = _$AdminFileUploadFormRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdminFileUploadFormRequest &&
            (identical(other.fileData, fileData) ||
                const DeepCollectionEquality()
                    .equals(other.fileData, fileData)) &&
            (identical(other.classify, classify) ||
                const DeepCollectionEquality()
                    .equals(other.classify, classify)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(fileData) ^
      const DeepCollectionEquality().hash(classify) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $AdminFileUploadFormRequestExtension on AdminFileUploadFormRequest {
  AdminFileUploadFormRequest copyWith(
      {String? fileData, String? classify, String? id}) {
    return AdminFileUploadFormRequest(
        fileData: fileData ?? this.fileData,
        classify: classify ?? this.classify,
        id: id ?? this.id);
  }

  AdminFileUploadFormRequest copyWithWrapped(
      {Wrapped<String?>? fileData,
      Wrapped<String?>? classify,
      Wrapped<String?>? id}) {
    return AdminFileUploadFormRequest(
        fileData: (fileData != null ? fileData.value : this.fileData),
        classify: (classify != null ? classify.value : this.classify),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class InputPart {
  const InputPart({
    this.contentTypeFromMessage,
    this.bodyAsString,
    this.mediaType,
    this.body,
    this.fileName,
    this.headers,
  });

  factory InputPart.fromJson(Map<String, dynamic> json) =>
      _$InputPartFromJson(json);

  static const toJsonFactory = _$InputPartToJson;
  Map<String, dynamic> toJson() => _$InputPartToJson(this);

  @JsonKey(name: 'contentTypeFromMessage', includeIfNull: false)
  final bool? contentTypeFromMessage;
  @JsonKey(name: 'bodyAsString', includeIfNull: false)
  final String? bodyAsString;
  @JsonKey(name: 'mediaType', includeIfNull: false)
  final MediaType? mediaType;
  @JsonKey(name: 'body', includeIfNull: false)
  final Object? body;
  @JsonKey(name: 'fileName', includeIfNull: false)
  final String? fileName;
  @JsonKey(name: 'headers', includeIfNull: false)
  final Map<String, dynamic>? headers;
  static const fromJsonFactory = _$InputPartFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is InputPart &&
            (identical(other.contentTypeFromMessage, contentTypeFromMessage) ||
                const DeepCollectionEquality().equals(
                    other.contentTypeFromMessage, contentTypeFromMessage)) &&
            (identical(other.bodyAsString, bodyAsString) ||
                const DeepCollectionEquality()
                    .equals(other.bodyAsString, bodyAsString)) &&
            (identical(other.mediaType, mediaType) ||
                const DeepCollectionEquality()
                    .equals(other.mediaType, mediaType)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.fileName, fileName) ||
                const DeepCollectionEquality()
                    .equals(other.fileName, fileName)) &&
            (identical(other.headers, headers) ||
                const DeepCollectionEquality().equals(other.headers, headers)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(contentTypeFromMessage) ^
      const DeepCollectionEquality().hash(bodyAsString) ^
      const DeepCollectionEquality().hash(mediaType) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(fileName) ^
      const DeepCollectionEquality().hash(headers) ^
      runtimeType.hashCode;
}

extension $InputPartExtension on InputPart {
  InputPart copyWith(
      {bool? contentTypeFromMessage,
      String? bodyAsString,
      MediaType? mediaType,
      Object? body,
      String? fileName,
      Map<String, dynamic>? headers}) {
    return InputPart(
        contentTypeFromMessage:
            contentTypeFromMessage ?? this.contentTypeFromMessage,
        bodyAsString: bodyAsString ?? this.bodyAsString,
        mediaType: mediaType ?? this.mediaType,
        body: body ?? this.body,
        fileName: fileName ?? this.fileName,
        headers: headers ?? this.headers);
  }

  InputPart copyWithWrapped(
      {Wrapped<bool?>? contentTypeFromMessage,
      Wrapped<String?>? bodyAsString,
      Wrapped<MediaType?>? mediaType,
      Wrapped<Object?>? body,
      Wrapped<String?>? fileName,
      Wrapped<Map<String, dynamic>?>? headers}) {
    return InputPart(
        contentTypeFromMessage: (contentTypeFromMessage != null
            ? contentTypeFromMessage.value
            : this.contentTypeFromMessage),
        bodyAsString:
            (bodyAsString != null ? bodyAsString.value : this.bodyAsString),
        mediaType: (mediaType != null ? mediaType.value : this.mediaType),
        body: (body != null ? body.value : this.body),
        fileName: (fileName != null ? fileName.value : this.fileName),
        headers: (headers != null ? headers.value : this.headers));
  }
}

@JsonSerializable(explicitToJson: true)
class MediaType {
  const MediaType({
    this.type,
    this.subtype,
    this.parameters,
    this.wildcardType,
    this.wildcardSubtype,
  });

  factory MediaType.fromJson(Map<String, dynamic> json) =>
      _$MediaTypeFromJson(json);

  static const toJsonFactory = _$MediaTypeToJson;
  Map<String, dynamic> toJson() => _$MediaTypeToJson(this);

  @JsonKey(name: 'type', includeIfNull: false)
  final String? type;
  @JsonKey(name: 'subtype', includeIfNull: false)
  final String? subtype;
  @JsonKey(name: 'parameters', includeIfNull: false)
  final Map<String, dynamic>? parameters;
  @JsonKey(name: 'wildcardType', includeIfNull: false)
  final bool? wildcardType;
  @JsonKey(name: 'wildcardSubtype', includeIfNull: false)
  final bool? wildcardSubtype;
  static const fromJsonFactory = _$MediaTypeFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MediaType &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.subtype, subtype) ||
                const DeepCollectionEquality()
                    .equals(other.subtype, subtype)) &&
            (identical(other.parameters, parameters) ||
                const DeepCollectionEquality()
                    .equals(other.parameters, parameters)) &&
            (identical(other.wildcardType, wildcardType) ||
                const DeepCollectionEquality()
                    .equals(other.wildcardType, wildcardType)) &&
            (identical(other.wildcardSubtype, wildcardSubtype) ||
                const DeepCollectionEquality()
                    .equals(other.wildcardSubtype, wildcardSubtype)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(subtype) ^
      const DeepCollectionEquality().hash(parameters) ^
      const DeepCollectionEquality().hash(wildcardType) ^
      const DeepCollectionEquality().hash(wildcardSubtype) ^
      runtimeType.hashCode;
}

extension $MediaTypeExtension on MediaType {
  MediaType copyWith(
      {String? type,
      String? subtype,
      Map<String, dynamic>? parameters,
      bool? wildcardType,
      bool? wildcardSubtype}) {
    return MediaType(
        type: type ?? this.type,
        subtype: subtype ?? this.subtype,
        parameters: parameters ?? this.parameters,
        wildcardType: wildcardType ?? this.wildcardType,
        wildcardSubtype: wildcardSubtype ?? this.wildcardSubtype);
  }

  MediaType copyWithWrapped(
      {Wrapped<String?>? type,
      Wrapped<String?>? subtype,
      Wrapped<Map<String, dynamic>?>? parameters,
      Wrapped<bool?>? wildcardType,
      Wrapped<bool?>? wildcardSubtype}) {
    return MediaType(
        type: (type != null ? type.value : this.type),
        subtype: (subtype != null ? subtype.value : this.subtype),
        parameters: (parameters != null ? parameters.value : this.parameters),
        wildcardType:
            (wildcardType != null ? wildcardType.value : this.wildcardType),
        wildcardSubtype: (wildcardSubtype != null
            ? wildcardSubtype.value
            : this.wildcardSubtype));
  }
}

@JsonSerializable(explicitToJson: true)
class MultipartFormDataInput {
  const MultipartFormDataInput({
    this.formDataMap,
    this.preamble,
    this.parts,
  });

  factory MultipartFormDataInput.fromJson(Map<String, dynamic> json) =>
      _$MultipartFormDataInputFromJson(json);

  static const toJsonFactory = _$MultipartFormDataInputToJson;
  Map<String, dynamic> toJson() => _$MultipartFormDataInputToJson(this);

  @JsonKey(name: 'formDataMap', includeIfNull: false)
  final Map<String, dynamic>? formDataMap;
  @JsonKey(name: 'preamble', includeIfNull: false)
  final String? preamble;
  @JsonKey(name: 'parts', includeIfNull: false, defaultValue: <InputPart>[])
  final List<InputPart>? parts;
  static const fromJsonFactory = _$MultipartFormDataInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MultipartFormDataInput &&
            (identical(other.formDataMap, formDataMap) ||
                const DeepCollectionEquality()
                    .equals(other.formDataMap, formDataMap)) &&
            (identical(other.preamble, preamble) ||
                const DeepCollectionEquality()
                    .equals(other.preamble, preamble)) &&
            (identical(other.parts, parts) ||
                const DeepCollectionEquality().equals(other.parts, parts)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(formDataMap) ^
      const DeepCollectionEquality().hash(preamble) ^
      const DeepCollectionEquality().hash(parts) ^
      runtimeType.hashCode;
}

extension $MultipartFormDataInputExtension on MultipartFormDataInput {
  MultipartFormDataInput copyWith(
      {Map<String, dynamic>? formDataMap,
      String? preamble,
      List<InputPart>? parts}) {
    return MultipartFormDataInput(
        formDataMap: formDataMap ?? this.formDataMap,
        preamble: preamble ?? this.preamble,
        parts: parts ?? this.parts);
  }

  MultipartFormDataInput copyWithWrapped(
      {Wrapped<Map<String, dynamic>?>? formDataMap,
      Wrapped<String?>? preamble,
      Wrapped<List<InputPart>?>? parts}) {
    return MultipartFormDataInput(
        formDataMap:
            (formDataMap != null ? formDataMap.value : this.formDataMap),
        preamble: (preamble != null ? preamble.value : this.preamble),
        parts: (parts != null ? parts.value : this.parts));
  }
}

@JsonSerializable(explicitToJson: true)
class MultivaluedMapStringString {
  const MultivaluedMapStringString({
    this.empty,
  });

  factory MultivaluedMapStringString.fromJson(Map<String, dynamic> json) =>
      _$MultivaluedMapStringStringFromJson(json);

  static const toJsonFactory = _$MultivaluedMapStringStringToJson;
  Map<String, dynamic> toJson() => _$MultivaluedMapStringStringToJson(this);

  @JsonKey(name: 'empty', includeIfNull: false)
  final bool? empty;
  static const fromJsonFactory = _$MultivaluedMapStringStringFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MultivaluedMapStringString &&
            (identical(other.empty, empty) ||
                const DeepCollectionEquality().equals(other.empty, empty)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(empty) ^ runtimeType.hashCode;
}

extension $MultivaluedMapStringStringExtension on MultivaluedMapStringString {
  MultivaluedMapStringString copyWith({bool? empty}) {
    return MultivaluedMapStringString(empty: empty ?? this.empty);
  }

  MultivaluedMapStringString copyWithWrapped({Wrapped<bool?>? empty}) {
    return MultivaluedMapStringString(
        empty: (empty != null ? empty.value : this.empty));
  }
}

@JsonSerializable(explicitToJson: true)
class FilterRequest {
  const FilterRequest({
    this.filters,
    this.sorts,
    this.limit,
    this.page,
  });

  factory FilterRequest.fromJson(Map<String, dynamic> json) =>
      _$FilterRequestFromJson(json);

  static const toJsonFactory = _$FilterRequestToJson;
  Map<String, dynamic> toJson() => _$FilterRequestToJson(this);

  @JsonKey(name: 'filters', includeIfNull: false)
  final Filters? filters;
  @JsonKey(name: 'sorts', includeIfNull: false)
  final Sorts? sorts;
  @JsonKey(name: 'limit', includeIfNull: false)
  final int? limit;
  @JsonKey(name: 'page', includeIfNull: false)
  final int? page;
  static const fromJsonFactory = _$FilterRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FilterRequest &&
            (identical(other.filters, filters) ||
                const DeepCollectionEquality()
                    .equals(other.filters, filters)) &&
            (identical(other.sorts, sorts) ||
                const DeepCollectionEquality().equals(other.sorts, sorts)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(filters) ^
      const DeepCollectionEquality().hash(sorts) ^
      const DeepCollectionEquality().hash(limit) ^
      const DeepCollectionEquality().hash(page) ^
      runtimeType.hashCode;
}

extension $FilterRequestExtension on FilterRequest {
  FilterRequest copyWith(
      {Filters? filters, Sorts? sorts, int? limit, int? page}) {
    return FilterRequest(
        filters: filters ?? this.filters,
        sorts: sorts ?? this.sorts,
        limit: limit ?? this.limit,
        page: page ?? this.page);
  }

  FilterRequest copyWithWrapped(
      {Wrapped<Filters?>? filters,
      Wrapped<Sorts?>? sorts,
      Wrapped<int?>? limit,
      Wrapped<int?>? page}) {
    return FilterRequest(
        filters: (filters != null ? filters.value : this.filters),
        sorts: (sorts != null ? sorts.value : this.sorts),
        limit: (limit != null ? limit.value : this.limit),
        page: (page != null ? page.value : this.page));
  }
}

@JsonSerializable(explicitToJson: true)
class FilterRule {
  const FilterRule({
    this.field,
    this.$operator,
    this.$value,
  });

  factory FilterRule.fromJson(Map<String, dynamic> json) =>
      _$FilterRuleFromJson(json);

  static const toJsonFactory = _$FilterRuleToJson;
  Map<String, dynamic> toJson() => _$FilterRuleToJson(this);

  @JsonKey(name: 'field', includeIfNull: false)
  final String? field;
  @JsonKey(name: 'operator', includeIfNull: false)
  final String? $operator;
  @JsonKey(name: 'value', includeIfNull: false)
  final String? $value;
  static const fromJsonFactory = _$FilterRuleFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FilterRule &&
            (identical(other.field, field) ||
                const DeepCollectionEquality().equals(other.field, field)) &&
            (identical(other.$operator, $operator) ||
                const DeepCollectionEquality()
                    .equals(other.$operator, $operator)) &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(field) ^
      const DeepCollectionEquality().hash($operator) ^
      const DeepCollectionEquality().hash($value) ^
      runtimeType.hashCode;
}

extension $FilterRuleExtension on FilterRule {
  FilterRule copyWith({String? field, String? $operator, String? $value}) {
    return FilterRule(
        field: field ?? this.field,
        $operator: $operator ?? this.$operator,
        $value: $value ?? this.$value);
  }

  FilterRule copyWithWrapped(
      {Wrapped<String?>? field,
      Wrapped<String?>? $operator,
      Wrapped<String?>? $value}) {
    return FilterRule(
        field: (field != null ? field.value : this.field),
        $operator: ($operator != null ? $operator.value : this.$operator),
        $value: ($value != null ? $value.value : this.$value));
  }
}

@JsonSerializable(explicitToJson: true)
class Filters {
  const Filters({
    this.condition,
    this.rules,
  });

  factory Filters.fromJson(Map<String, dynamic> json) =>
      _$FiltersFromJson(json);

  static const toJsonFactory = _$FiltersToJson;
  Map<String, dynamic> toJson() => _$FiltersToJson(this);

  @JsonKey(name: 'condition', includeIfNull: false)
  final String? condition;
  @JsonKey(name: 'rules', includeIfNull: false, defaultValue: <FilterRule>[])
  final List<FilterRule>? rules;
  static const fromJsonFactory = _$FiltersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Filters &&
            (identical(other.condition, condition) ||
                const DeepCollectionEquality()
                    .equals(other.condition, condition)) &&
            (identical(other.rules, rules) ||
                const DeepCollectionEquality().equals(other.rules, rules)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(condition) ^
      const DeepCollectionEquality().hash(rules) ^
      runtimeType.hashCode;
}

extension $FiltersExtension on Filters {
  Filters copyWith({String? condition, List<FilterRule>? rules}) {
    return Filters(
        condition: condition ?? this.condition, rules: rules ?? this.rules);
  }

  Filters copyWithWrapped(
      {Wrapped<String?>? condition, Wrapped<List<FilterRule>?>? rules}) {
    return Filters(
        condition: (condition != null ? condition.value : this.condition),
        rules: (rules != null ? rules.value : this.rules));
  }
}

@JsonSerializable(explicitToJson: true)
class SortRule {
  const SortRule({
    this.field,
    this.ascending,
  });

  factory SortRule.fromJson(Map<String, dynamic> json) =>
      _$SortRuleFromJson(json);

  static const toJsonFactory = _$SortRuleToJson;
  Map<String, dynamic> toJson() => _$SortRuleToJson(this);

  @JsonKey(name: 'field', includeIfNull: false)
  final String? field;
  @JsonKey(name: 'ascending', includeIfNull: false)
  final bool? ascending;
  static const fromJsonFactory = _$SortRuleFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SortRule &&
            (identical(other.field, field) ||
                const DeepCollectionEquality().equals(other.field, field)) &&
            (identical(other.ascending, ascending) ||
                const DeepCollectionEquality()
                    .equals(other.ascending, ascending)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(field) ^
      const DeepCollectionEquality().hash(ascending) ^
      runtimeType.hashCode;
}

extension $SortRuleExtension on SortRule {
  SortRule copyWith({String? field, bool? ascending}) {
    return SortRule(
        field: field ?? this.field, ascending: ascending ?? this.ascending);
  }

  SortRule copyWithWrapped(
      {Wrapped<String?>? field, Wrapped<bool?>? ascending}) {
    return SortRule(
        field: (field != null ? field.value : this.field),
        ascending: (ascending != null ? ascending.value : this.ascending));
  }
}

@JsonSerializable(explicitToJson: true)
class Sorts {
  const Sorts({
    this.rules,
  });

  factory Sorts.fromJson(Map<String, dynamic> json) => _$SortsFromJson(json);

  static const toJsonFactory = _$SortsToJson;
  Map<String, dynamic> toJson() => _$SortsToJson(this);

  @JsonKey(name: 'rules', includeIfNull: false, defaultValue: <SortRule>[])
  final List<SortRule>? rules;
  static const fromJsonFactory = _$SortsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Sorts &&
            (identical(other.rules, rules) ||
                const DeepCollectionEquality().equals(other.rules, rules)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(rules) ^ runtimeType.hashCode;
}

extension $SortsExtension on Sorts {
  Sorts copyWith({List<SortRule>? rules}) {
    return Sorts(rules: rules ?? this.rules);
  }

  Sorts copyWithWrapped({Wrapped<List<SortRule>?>? rules}) {
    return Sorts(rules: (rules != null ? rules.value : this.rules));
  }
}

@JsonSerializable(explicitToJson: true)
class Author {
  const Author({
    this.id,
    this.name,
    this.biography,
    this.createdAt,
    this.updatedAt,
    this.deleted,
    this.avatarUrl,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  static const toJsonFactory = _$AuthorToJson;
  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'biography', includeIfNull: false)
  final String? biography;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  @JsonKey(name: 'avatarUrl', includeIfNull: false)
  final String? avatarUrl;
  static const fromJsonFactory = _$AuthorFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Author &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.biography, biography) ||
                const DeepCollectionEquality()
                    .equals(other.biography, biography)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality()
                    .equals(other.deleted, deleted)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(biography) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(deleted) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      runtimeType.hashCode;
}

extension $AuthorExtension on Author {
  Author copyWith(
      {int? id,
      String? name,
      String? biography,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? deleted,
      String? avatarUrl}) {
    return Author(
        id: id ?? this.id,
        name: name ?? this.name,
        biography: biography ?? this.biography,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted,
        avatarUrl: avatarUrl ?? this.avatarUrl);
  }

  Author copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? name,
      Wrapped<String?>? biography,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? deleted,
      Wrapped<String?>? avatarUrl}) {
    return Author(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        biography: (biography != null ? biography.value : this.biography),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        deleted: (deleted != null ? deleted.value : this.deleted),
        avatarUrl: (avatarUrl != null ? avatarUrl.value : this.avatarUrl));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthorRequest {
  const AuthorRequest({
    this.name,
    this.biography,
    this.avatarUrl,
  });

  factory AuthorRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthorRequestFromJson(json);

  static const toJsonFactory = _$AuthorRequestToJson;
  Map<String, dynamic> toJson() => _$AuthorRequestToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'biography', includeIfNull: false)
  final String? biography;
  @JsonKey(name: 'avatarUrl', includeIfNull: false)
  final String? avatarUrl;
  static const fromJsonFactory = _$AuthorRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthorRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.biography, biography) ||
                const DeepCollectionEquality()
                    .equals(other.biography, biography)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(biography) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      runtimeType.hashCode;
}

extension $AuthorRequestExtension on AuthorRequest {
  AuthorRequest copyWith({String? name, String? biography, String? avatarUrl}) {
    return AuthorRequest(
        name: name ?? this.name,
        biography: biography ?? this.biography,
        avatarUrl: avatarUrl ?? this.avatarUrl);
  }

  AuthorRequest copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? biography,
      Wrapped<String?>? avatarUrl}) {
    return AuthorRequest(
        name: (name != null ? name.value : this.name),
        biography: (biography != null ? biography.value : this.biography),
        avatarUrl: (avatarUrl != null ? avatarUrl.value : this.avatarUrl));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthorImageFormRequest {
  const AuthorImageFormRequest({
    this.fileData,
    this.authorId,
  });

  factory AuthorImageFormRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthorImageFormRequestFromJson(json);

  static const toJsonFactory = _$AuthorImageFormRequestToJson;
  Map<String, dynamic> toJson() => _$AuthorImageFormRequestToJson(this);

  @JsonKey(name: 'fileData', includeIfNull: false)
  final String? fileData;
  @JsonKey(name: 'authorId', includeIfNull: false)
  final String? authorId;
  static const fromJsonFactory = _$AuthorImageFormRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthorImageFormRequest &&
            (identical(other.fileData, fileData) ||
                const DeepCollectionEquality()
                    .equals(other.fileData, fileData)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(fileData) ^
      const DeepCollectionEquality().hash(authorId) ^
      runtimeType.hashCode;
}

extension $AuthorImageFormRequestExtension on AuthorImageFormRequest {
  AuthorImageFormRequest copyWith({String? fileData, String? authorId}) {
    return AuthorImageFormRequest(
        fileData: fileData ?? this.fileData,
        authorId: authorId ?? this.authorId);
  }

  AuthorImageFormRequest copyWithWrapped(
      {Wrapped<String?>? fileData, Wrapped<String?>? authorId}) {
    return AuthorImageFormRequest(
        fileData: (fileData != null ? fileData.value : this.fileData),
        authorId: (authorId != null ? authorId.value : this.authorId));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthorResponse {
  const AuthorResponse({
    this.id,
    this.name,
  });

  factory AuthorResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthorResponseFromJson(json);

  static const toJsonFactory = _$AuthorResponseToJson;
  Map<String, dynamic> toJson() => _$AuthorResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$AuthorResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthorResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $AuthorResponseExtension on AuthorResponse {
  AuthorResponse copyWith({int? id, String? name}) {
    return AuthorResponse(id: id ?? this.id, name: name ?? this.name);
  }

  AuthorResponse copyWithWrapped({Wrapped<int?>? id, Wrapped<String?>? name}) {
    return AuthorResponse(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class Book {
  const Book({
    this.id,
    this.title,
    this.author,
    this.publisher,
    this.publicationYear,
    this.isbn,
    this.price,
    this.description,
    this.resourceType,
    this.language,
    this.pageCount,
    this.createdAt,
    this.updatedAt,
    this.deleted,
    this.category,
    this.createdBy,
    this.updatedBy,
    this.excerpt,
    this.authorEvaluation,
    this.images,
    this.readingTime,
    this.numberOfChapters,
    this.uploadedBy,
    this.tags,
    this.publicBookRequestResponse,
    this.ageAverage,
    this.status,
    this.chapters,
    this.bookReviewResponse,
    this.isPurchased,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  static const toJsonFactory = _$BookToJson;
  Map<String, dynamic> toJson() => _$BookToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'author', includeIfNull: false)
  final AuthorResponse? author;
  @JsonKey(name: 'publisher', includeIfNull: false)
  final Publisher? publisher;
  @JsonKey(name: 'publicationYear', includeIfNull: false)
  final int? publicationYear;
  @JsonKey(name: 'isbn', includeIfNull: false)
  final String? isbn;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'resourceType', includeIfNull: false)
  final String? resourceType;
  @JsonKey(name: 'language', includeIfNull: false)
  final String? language;
  @JsonKey(name: 'pageCount', includeIfNull: false)
  final int? pageCount;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  @JsonKey(name: 'category', includeIfNull: false, defaultValue: <Category>[])
  final List<Category>? category;
  @JsonKey(name: 'createdBy', includeIfNull: false)
  final String? createdBy;
  @JsonKey(name: 'updatedBy', includeIfNull: false)
  final String? updatedBy;
  @JsonKey(name: 'excerpt', includeIfNull: false)
  final String? excerpt;
  @JsonKey(name: 'authorEvaluation', includeIfNull: false)
  final String? authorEvaluation;
  @JsonKey(name: 'images', includeIfNull: false, defaultValue: <BookImage>[])
  final List<BookImage>? images;
  @JsonKey(name: 'readingTime', includeIfNull: false)
  final int? readingTime;
  @JsonKey(name: 'numberOfChapters', includeIfNull: false)
  final int? numberOfChapters;
  @JsonKey(name: 'uploadedBy', includeIfNull: false)
  final String? uploadedBy;
  @JsonKey(name: 'tags', includeIfNull: false, defaultValue: <TagModel>[])
  final List<TagModel>? tags;
  @JsonKey(name: 'publicBookRequestResponse', includeIfNull: false)
  final PublicBookRequestResponse? publicBookRequestResponse;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  @JsonKey(name: 'status', includeIfNull: false)
  final bool? status;
  @JsonKey(
      name: 'chapters', includeIfNull: false, defaultValue: <BookChapter>[])
  final List<BookChapter>? chapters;
  @JsonKey(name: 'bookReviewResponse', includeIfNull: false)
  final BookReviewResponse? bookReviewResponse;
  @JsonKey(name: 'isPurchased', includeIfNull: false)
  final int? isPurchased;
  static const fromJsonFactory = _$BookFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Book &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.publicationYear, publicationYear) ||
                const DeepCollectionEquality()
                    .equals(other.publicationYear, publicationYear)) &&
            (identical(other.isbn, isbn) ||
                const DeepCollectionEquality().equals(other.isbn, isbn)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.resourceType, resourceType) ||
                const DeepCollectionEquality()
                    .equals(other.resourceType, resourceType)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.pageCount, pageCount) ||
                const DeepCollectionEquality()
                    .equals(other.pageCount, pageCount)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality()
                    .equals(other.deleted, deleted)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality()
                    .equals(other.createdBy, createdBy)) &&
            (identical(other.updatedBy, updatedBy) ||
                const DeepCollectionEquality()
                    .equals(other.updatedBy, updatedBy)) &&
            (identical(other.excerpt, excerpt) ||
                const DeepCollectionEquality()
                    .equals(other.excerpt, excerpt)) &&
            (identical(other.authorEvaluation, authorEvaluation) ||
                const DeepCollectionEquality()
                    .equals(other.authorEvaluation, authorEvaluation)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
            (identical(other.readingTime, readingTime) ||
                const DeepCollectionEquality()
                    .equals(other.readingTime, readingTime)) &&
            (identical(other.numberOfChapters, numberOfChapters) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfChapters, numberOfChapters)) &&
            (identical(other.uploadedBy, uploadedBy) ||
                const DeepCollectionEquality()
                    .equals(other.uploadedBy, uploadedBy)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.publicBookRequestResponse, publicBookRequestResponse) ||
                const DeepCollectionEquality()
                    .equals(other.publicBookRequestResponse, publicBookRequestResponse)) &&
            (identical(other.ageAverage, ageAverage) || const DeepCollectionEquality().equals(other.ageAverage, ageAverage)) &&
            (identical(other.status, status) || const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.chapters, chapters) || const DeepCollectionEquality().equals(other.chapters, chapters)) &&
            (identical(other.bookReviewResponse, bookReviewResponse) || const DeepCollectionEquality().equals(other.bookReviewResponse, bookReviewResponse)) &&
            (identical(other.isPurchased, isPurchased) || const DeepCollectionEquality().equals(other.isPurchased, isPurchased)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(publicationYear) ^
      const DeepCollectionEquality().hash(isbn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(resourceType) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(pageCount) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(deleted) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(updatedBy) ^
      const DeepCollectionEquality().hash(excerpt) ^
      const DeepCollectionEquality().hash(authorEvaluation) ^
      const DeepCollectionEquality().hash(images) ^
      const DeepCollectionEquality().hash(readingTime) ^
      const DeepCollectionEquality().hash(numberOfChapters) ^
      const DeepCollectionEquality().hash(uploadedBy) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(publicBookRequestResponse) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(chapters) ^
      const DeepCollectionEquality().hash(bookReviewResponse) ^
      const DeepCollectionEquality().hash(isPurchased) ^
      runtimeType.hashCode;
}

extension $BookExtension on Book {
  Book copyWith(
      {int? id,
      String? title,
      AuthorResponse? author,
      Publisher? publisher,
      int? publicationYear,
      String? isbn,
      double? price,
      String? description,
      String? resourceType,
      String? language,
      int? pageCount,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? deleted,
      List<Category>? category,
      String? createdBy,
      String? updatedBy,
      String? excerpt,
      String? authorEvaluation,
      List<BookImage>? images,
      int? readingTime,
      int? numberOfChapters,
      String? uploadedBy,
      List<TagModel>? tags,
      PublicBookRequestResponse? publicBookRequestResponse,
      int? ageAverage,
      bool? status,
      List<BookChapter>? chapters,
      BookReviewResponse? bookReviewResponse,
      int? isPurchased}) {
    return Book(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        publisher: publisher ?? this.publisher,
        publicationYear: publicationYear ?? this.publicationYear,
        isbn: isbn ?? this.isbn,
        price: price ?? this.price,
        description: description ?? this.description,
        resourceType: resourceType ?? this.resourceType,
        language: language ?? this.language,
        pageCount: pageCount ?? this.pageCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted,
        category: category ?? this.category,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        excerpt: excerpt ?? this.excerpt,
        authorEvaluation: authorEvaluation ?? this.authorEvaluation,
        images: images ?? this.images,
        readingTime: readingTime ?? this.readingTime,
        numberOfChapters: numberOfChapters ?? this.numberOfChapters,
        uploadedBy: uploadedBy ?? this.uploadedBy,
        tags: tags ?? this.tags,
        publicBookRequestResponse:
            publicBookRequestResponse ?? this.publicBookRequestResponse,
        ageAverage: ageAverage ?? this.ageAverage,
        status: status ?? this.status,
        chapters: chapters ?? this.chapters,
        bookReviewResponse: bookReviewResponse ?? this.bookReviewResponse,
        isPurchased: isPurchased ?? this.isPurchased);
  }

  Book copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? title,
      Wrapped<AuthorResponse?>? author,
      Wrapped<Publisher?>? publisher,
      Wrapped<int?>? publicationYear,
      Wrapped<String?>? isbn,
      Wrapped<double?>? price,
      Wrapped<String?>? description,
      Wrapped<String?>? resourceType,
      Wrapped<String?>? language,
      Wrapped<int?>? pageCount,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? deleted,
      Wrapped<List<Category>?>? category,
      Wrapped<String?>? createdBy,
      Wrapped<String?>? updatedBy,
      Wrapped<String?>? excerpt,
      Wrapped<String?>? authorEvaluation,
      Wrapped<List<BookImage>?>? images,
      Wrapped<int?>? readingTime,
      Wrapped<int?>? numberOfChapters,
      Wrapped<String?>? uploadedBy,
      Wrapped<List<TagModel>?>? tags,
      Wrapped<PublicBookRequestResponse?>? publicBookRequestResponse,
      Wrapped<int?>? ageAverage,
      Wrapped<bool?>? status,
      Wrapped<List<BookChapter>?>? chapters,
      Wrapped<BookReviewResponse?>? bookReviewResponse,
      Wrapped<int?>? isPurchased}) {
    return Book(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        author: (author != null ? author.value : this.author),
        publisher: (publisher != null ? publisher.value : this.publisher),
        publicationYear: (publicationYear != null
            ? publicationYear.value
            : this.publicationYear),
        isbn: (isbn != null ? isbn.value : this.isbn),
        price: (price != null ? price.value : this.price),
        description:
            (description != null ? description.value : this.description),
        resourceType:
            (resourceType != null ? resourceType.value : this.resourceType),
        language: (language != null ? language.value : this.language),
        pageCount: (pageCount != null ? pageCount.value : this.pageCount),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        deleted: (deleted != null ? deleted.value : this.deleted),
        category: (category != null ? category.value : this.category),
        createdBy: (createdBy != null ? createdBy.value : this.createdBy),
        updatedBy: (updatedBy != null ? updatedBy.value : this.updatedBy),
        excerpt: (excerpt != null ? excerpt.value : this.excerpt),
        authorEvaluation: (authorEvaluation != null
            ? authorEvaluation.value
            : this.authorEvaluation),
        images: (images != null ? images.value : this.images),
        readingTime:
            (readingTime != null ? readingTime.value : this.readingTime),
        numberOfChapters: (numberOfChapters != null
            ? numberOfChapters.value
            : this.numberOfChapters),
        uploadedBy: (uploadedBy != null ? uploadedBy.value : this.uploadedBy),
        tags: (tags != null ? tags.value : this.tags),
        publicBookRequestResponse: (publicBookRequestResponse != null
            ? publicBookRequestResponse.value
            : this.publicBookRequestResponse),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage),
        status: (status != null ? status.value : this.status),
        chapters: (chapters != null ? chapters.value : this.chapters),
        bookReviewResponse: (bookReviewResponse != null
            ? bookReviewResponse.value
            : this.bookReviewResponse),
        isPurchased:
            (isPurchased != null ? isPurchased.value : this.isPurchased));
  }
}

@JsonSerializable(explicitToJson: true)
class BookChapter {
  const BookChapter({
    this.id,
    this.bookId,
    this.title,
    this.chapterNumber,
    this.resourceLink,
    this.type,
    this.format,
    this.isEncrypted,
    this.createdAt,
    this.updatedAt,
  });

  factory BookChapter.fromJson(Map<String, dynamic> json) =>
      _$BookChapterFromJson(json);

  static const toJsonFactory = _$BookChapterToJson;
  Map<String, dynamic> toJson() => _$BookChapterToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'chapterNumber', includeIfNull: false)
  final int? chapterNumber;
  @JsonKey(name: 'resourceLink', includeIfNull: false)
  final String? resourceLink;
  @JsonKey(name: 'type', includeIfNull: false)
  final String? type;
  @JsonKey(name: 'format', includeIfNull: false)
  final String? format;
  @JsonKey(name: 'isEncrypted', includeIfNull: false)
  final bool? isEncrypted;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  static const fromJsonFactory = _$BookChapterFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookChapter &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.chapterNumber, chapterNumber) ||
                const DeepCollectionEquality()
                    .equals(other.chapterNumber, chapterNumber)) &&
            (identical(other.resourceLink, resourceLink) ||
                const DeepCollectionEquality()
                    .equals(other.resourceLink, resourceLink)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.format, format) ||
                const DeepCollectionEquality().equals(other.format, format)) &&
            (identical(other.isEncrypted, isEncrypted) ||
                const DeepCollectionEquality()
                    .equals(other.isEncrypted, isEncrypted)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(chapterNumber) ^
      const DeepCollectionEquality().hash(resourceLink) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(format) ^
      const DeepCollectionEquality().hash(isEncrypted) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $BookChapterExtension on BookChapter {
  BookChapter copyWith(
      {int? id,
      int? bookId,
      String? title,
      int? chapterNumber,
      String? resourceLink,
      String? type,
      String? format,
      bool? isEncrypted,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return BookChapter(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        title: title ?? this.title,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        resourceLink: resourceLink ?? this.resourceLink,
        type: type ?? this.type,
        format: format ?? this.format,
        isEncrypted: isEncrypted ?? this.isEncrypted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  BookChapter copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<int?>? bookId,
      Wrapped<String?>? title,
      Wrapped<int?>? chapterNumber,
      Wrapped<String?>? resourceLink,
      Wrapped<String?>? type,
      Wrapped<String?>? format,
      Wrapped<bool?>? isEncrypted,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt}) {
    return BookChapter(
        id: (id != null ? id.value : this.id),
        bookId: (bookId != null ? bookId.value : this.bookId),
        title: (title != null ? title.value : this.title),
        chapterNumber:
            (chapterNumber != null ? chapterNumber.value : this.chapterNumber),
        resourceLink:
            (resourceLink != null ? resourceLink.value : this.resourceLink),
        type: (type != null ? type.value : this.type),
        format: (format != null ? format.value : this.format),
        isEncrypted:
            (isEncrypted != null ? isEncrypted.value : this.isEncrypted),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt));
  }
}

@JsonSerializable(explicitToJson: true)
class BookImage {
  const BookImage({
    this.id,
    this.bookId,
    this.imageUrl,
    this.caption,
    this.createdAt,
    this.priority,
    this.deleted,
  });

  factory BookImage.fromJson(Map<String, dynamic> json) =>
      _$BookImageFromJson(json);

  static const toJsonFactory = _$BookImageToJson;
  Map<String, dynamic> toJson() => _$BookImageToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'caption', includeIfNull: false)
  final String? caption;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'priority', includeIfNull: false)
  final int? priority;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  static const fromJsonFactory = _$BookImageFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookImage &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.caption, caption) ||
                const DeepCollectionEquality()
                    .equals(other.caption, caption)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.priority, priority) ||
                const DeepCollectionEquality()
                    .equals(other.priority, priority)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality().equals(other.deleted, deleted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(caption) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(priority) ^
      const DeepCollectionEquality().hash(deleted) ^
      runtimeType.hashCode;
}

extension $BookImageExtension on BookImage {
  BookImage copyWith(
      {int? id,
      int? bookId,
      String? imageUrl,
      String? caption,
      DateTime? createdAt,
      int? priority,
      bool? deleted}) {
    return BookImage(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        imageUrl: imageUrl ?? this.imageUrl,
        caption: caption ?? this.caption,
        createdAt: createdAt ?? this.createdAt,
        priority: priority ?? this.priority,
        deleted: deleted ?? this.deleted);
  }

  BookImage copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<int?>? bookId,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? caption,
      Wrapped<DateTime?>? createdAt,
      Wrapped<int?>? priority,
      Wrapped<bool?>? deleted}) {
    return BookImage(
        id: (id != null ? id.value : this.id),
        bookId: (bookId != null ? bookId.value : this.bookId),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        caption: (caption != null ? caption.value : this.caption),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        priority: (priority != null ? priority.value : this.priority),
        deleted: (deleted != null ? deleted.value : this.deleted));
  }
}

@JsonSerializable(explicitToJson: true)
class BookReviewResponse {
  const BookReviewResponse({
    this.numberOfReviews,
    this.averageRating,
  });

  factory BookReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$BookReviewResponseFromJson(json);

  static const toJsonFactory = _$BookReviewResponseToJson;
  Map<String, dynamic> toJson() => _$BookReviewResponseToJson(this);

  @JsonKey(name: 'numberOfReviews', includeIfNull: false)
  final int? numberOfReviews;
  @JsonKey(name: 'averageRating', includeIfNull: false)
  final double? averageRating;
  static const fromJsonFactory = _$BookReviewResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookReviewResponse &&
            (identical(other.numberOfReviews, numberOfReviews) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfReviews, numberOfReviews)) &&
            (identical(other.averageRating, averageRating) ||
                const DeepCollectionEquality()
                    .equals(other.averageRating, averageRating)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(numberOfReviews) ^
      const DeepCollectionEquality().hash(averageRating) ^
      runtimeType.hashCode;
}

extension $BookReviewResponseExtension on BookReviewResponse {
  BookReviewResponse copyWith({int? numberOfReviews, double? averageRating}) {
    return BookReviewResponse(
        numberOfReviews: numberOfReviews ?? this.numberOfReviews,
        averageRating: averageRating ?? this.averageRating);
  }

  BookReviewResponse copyWithWrapped(
      {Wrapped<int?>? numberOfReviews, Wrapped<double?>? averageRating}) {
    return BookReviewResponse(
        numberOfReviews: (numberOfReviews != null
            ? numberOfReviews.value
            : this.numberOfReviews),
        averageRating:
            (averageRating != null ? averageRating.value : this.averageRating));
  }
}

@JsonSerializable(explicitToJson: true)
class Category {
  const Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deleted,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  static const toJsonFactory = _$CategoryToJson;
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  static const fromJsonFactory = _$CategoryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Category &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality().equals(other.deleted, deleted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(deleted) ^
      runtimeType.hashCode;
}

extension $CategoryExtension on Category {
  Category copyWith(
      {int? id,
      String? name,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? deleted}) {
    return Category(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted);
  }

  Category copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? name,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? deleted}) {
    return Category(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        deleted: (deleted != null ? deleted.value : this.deleted));
  }
}

@JsonSerializable(explicitToJson: true)
class PublicBookRequestResponse {
  const PublicBookRequestResponse({
    this.status,
    this.uploadedRole,
  });

  factory PublicBookRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$PublicBookRequestResponseFromJson(json);

  static const toJsonFactory = _$PublicBookRequestResponseToJson;
  Map<String, dynamic> toJson() => _$PublicBookRequestResponseToJson(this);

  @JsonKey(
    name: 'status',
    includeIfNull: false,
    toJson: publicBookRequestResponseStatusNullableToJson,
    fromJson: publicBookRequestResponseStatusNullableFromJson,
  )
  final enums.PublicBookRequestResponseStatus? status;
  @JsonKey(name: 'uploadedRole', includeIfNull: false)
  final String? uploadedRole;
  static const fromJsonFactory = _$PublicBookRequestResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PublicBookRequestResponse &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.uploadedRole, uploadedRole) ||
                const DeepCollectionEquality()
                    .equals(other.uploadedRole, uploadedRole)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(uploadedRole) ^
      runtimeType.hashCode;
}

extension $PublicBookRequestResponseExtension on PublicBookRequestResponse {
  PublicBookRequestResponse copyWith(
      {enums.PublicBookRequestResponseStatus? status, String? uploadedRole}) {
    return PublicBookRequestResponse(
        status: status ?? this.status,
        uploadedRole: uploadedRole ?? this.uploadedRole);
  }

  PublicBookRequestResponse copyWithWrapped(
      {Wrapped<enums.PublicBookRequestResponseStatus?>? status,
      Wrapped<String?>? uploadedRole}) {
    return PublicBookRequestResponse(
        status: (status != null ? status.value : this.status),
        uploadedRole:
            (uploadedRole != null ? uploadedRole.value : this.uploadedRole));
  }
}

@JsonSerializable(explicitToJson: true)
class Publisher {
  const Publisher({
    this.id,
    this.name,
    this.address,
    this.contactInfo,
    this.createdAt,
    this.updatedAt,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) =>
      _$PublisherFromJson(json);

  static const toJsonFactory = _$PublisherToJson;
  Map<String, dynamic> toJson() => _$PublisherToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'address', includeIfNull: false)
  final String? address;
  @JsonKey(name: 'contactInfo', includeIfNull: false)
  final String? contactInfo;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  static const fromJsonFactory = _$PublisherFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Publisher &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.contactInfo, contactInfo) ||
                const DeepCollectionEquality()
                    .equals(other.contactInfo, contactInfo)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(contactInfo) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $PublisherExtension on Publisher {
  Publisher copyWith(
      {int? id,
      String? name,
      String? address,
      String? contactInfo,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return Publisher(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        contactInfo: contactInfo ?? this.contactInfo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Publisher copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? name,
      Wrapped<String?>? address,
      Wrapped<String?>? contactInfo,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt}) {
    return Publisher(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        address: (address != null ? address.value : this.address),
        contactInfo:
            (contactInfo != null ? contactInfo.value : this.contactInfo),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt));
  }
}

@JsonSerializable(explicitToJson: true)
class TagModel {
  const TagModel({
    this.id,
    this.tagName,
    this.createdAt,
    this.updatedAt,
    this.deleted,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  static const toJsonFactory = _$TagModelToJson;
  Map<String, dynamic> toJson() => _$TagModelToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'tagName', includeIfNull: false)
  final String? tagName;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  static const fromJsonFactory = _$TagModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TagModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.tagName, tagName) ||
                const DeepCollectionEquality()
                    .equals(other.tagName, tagName)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality().equals(other.deleted, deleted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(tagName) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(deleted) ^
      runtimeType.hashCode;
}

extension $TagModelExtension on TagModel {
  TagModel copyWith(
      {int? id,
      String? tagName,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? deleted}) {
    return TagModel(
        id: id ?? this.id,
        tagName: tagName ?? this.tagName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted);
  }

  TagModel copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? tagName,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? deleted}) {
    return TagModel(
        id: (id != null ? id.value : this.id),
        tagName: (tagName != null ? tagName.value : this.tagName),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        deleted: (deleted != null ? deleted.value : this.deleted));
  }
}

@JsonSerializable(explicitToJson: true)
class BookRequest {
  const BookRequest({
    this.title,
    this.authorId,
    this.publisherId,
    this.publicationYear,
    this.isbn,
    this.price,
    this.description,
    this.resourceType,
    this.language,
    this.pageCount,
    this.excerpt,
    this.authorEvaluation,
    this.readingTime,
    this.numberOfChapters,
    this.categoryIds,
    this.tagIds,
    this.ageAverage,
    this.status,
  });

  factory BookRequest.fromJson(Map<String, dynamic> json) =>
      _$BookRequestFromJson(json);

  static const toJsonFactory = _$BookRequestToJson;
  Map<String, dynamic> toJson() => _$BookRequestToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'authorId', includeIfNull: false)
  final int? authorId;
  @JsonKey(name: 'publisherId', includeIfNull: false)
  final int? publisherId;
  @JsonKey(name: 'publicationYear', includeIfNull: false)
  final int? publicationYear;
  @JsonKey(name: 'isbn', includeIfNull: false)
  final String? isbn;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'resourceType', includeIfNull: false)
  final String? resourceType;
  @JsonKey(name: 'language', includeIfNull: false)
  final String? language;
  @JsonKey(name: 'pageCount', includeIfNull: false)
  final int? pageCount;
  @JsonKey(name: 'excerpt', includeIfNull: false)
  final String? excerpt;
  @JsonKey(name: 'authorEvaluation', includeIfNull: false)
  final String? authorEvaluation;
  @JsonKey(name: 'readingTime', includeIfNull: false)
  final int? readingTime;
  @JsonKey(name: 'numberOfChapters', includeIfNull: false)
  final int? numberOfChapters;
  @JsonKey(name: 'categoryIds', includeIfNull: false, defaultValue: <int>[])
  final List<int>? categoryIds;
  @JsonKey(name: 'tagIds', includeIfNull: false, defaultValue: <int>[])
  final List<int>? tagIds;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  @JsonKey(name: 'status', includeIfNull: false)
  final bool? status;
  static const fromJsonFactory = _$BookRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookRequest &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)) &&
            (identical(other.publisherId, publisherId) ||
                const DeepCollectionEquality()
                    .equals(other.publisherId, publisherId)) &&
            (identical(other.publicationYear, publicationYear) ||
                const DeepCollectionEquality()
                    .equals(other.publicationYear, publicationYear)) &&
            (identical(other.isbn, isbn) ||
                const DeepCollectionEquality().equals(other.isbn, isbn)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.resourceType, resourceType) ||
                const DeepCollectionEquality()
                    .equals(other.resourceType, resourceType)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.pageCount, pageCount) ||
                const DeepCollectionEquality()
                    .equals(other.pageCount, pageCount)) &&
            (identical(other.excerpt, excerpt) ||
                const DeepCollectionEquality()
                    .equals(other.excerpt, excerpt)) &&
            (identical(other.authorEvaluation, authorEvaluation) ||
                const DeepCollectionEquality()
                    .equals(other.authorEvaluation, authorEvaluation)) &&
            (identical(other.readingTime, readingTime) ||
                const DeepCollectionEquality()
                    .equals(other.readingTime, readingTime)) &&
            (identical(other.numberOfChapters, numberOfChapters) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfChapters, numberOfChapters)) &&
            (identical(other.categoryIds, categoryIds) ||
                const DeepCollectionEquality()
                    .equals(other.categoryIds, categoryIds)) &&
            (identical(other.tagIds, tagIds) ||
                const DeepCollectionEquality().equals(other.tagIds, tagIds)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(authorId) ^
      const DeepCollectionEquality().hash(publisherId) ^
      const DeepCollectionEquality().hash(publicationYear) ^
      const DeepCollectionEquality().hash(isbn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(resourceType) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(pageCount) ^
      const DeepCollectionEquality().hash(excerpt) ^
      const DeepCollectionEquality().hash(authorEvaluation) ^
      const DeepCollectionEquality().hash(readingTime) ^
      const DeepCollectionEquality().hash(numberOfChapters) ^
      const DeepCollectionEquality().hash(categoryIds) ^
      const DeepCollectionEquality().hash(tagIds) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $BookRequestExtension on BookRequest {
  BookRequest copyWith(
      {String? title,
      int? authorId,
      int? publisherId,
      int? publicationYear,
      String? isbn,
      double? price,
      String? description,
      String? resourceType,
      String? language,
      int? pageCount,
      String? excerpt,
      String? authorEvaluation,
      int? readingTime,
      int? numberOfChapters,
      List<int>? categoryIds,
      List<int>? tagIds,
      int? ageAverage,
      bool? status}) {
    return BookRequest(
        title: title ?? this.title,
        authorId: authorId ?? this.authorId,
        publisherId: publisherId ?? this.publisherId,
        publicationYear: publicationYear ?? this.publicationYear,
        isbn: isbn ?? this.isbn,
        price: price ?? this.price,
        description: description ?? this.description,
        resourceType: resourceType ?? this.resourceType,
        language: language ?? this.language,
        pageCount: pageCount ?? this.pageCount,
        excerpt: excerpt ?? this.excerpt,
        authorEvaluation: authorEvaluation ?? this.authorEvaluation,
        readingTime: readingTime ?? this.readingTime,
        numberOfChapters: numberOfChapters ?? this.numberOfChapters,
        categoryIds: categoryIds ?? this.categoryIds,
        tagIds: tagIds ?? this.tagIds,
        ageAverage: ageAverage ?? this.ageAverage,
        status: status ?? this.status);
  }

  BookRequest copyWithWrapped(
      {Wrapped<String?>? title,
      Wrapped<int?>? authorId,
      Wrapped<int?>? publisherId,
      Wrapped<int?>? publicationYear,
      Wrapped<String?>? isbn,
      Wrapped<double?>? price,
      Wrapped<String?>? description,
      Wrapped<String?>? resourceType,
      Wrapped<String?>? language,
      Wrapped<int?>? pageCount,
      Wrapped<String?>? excerpt,
      Wrapped<String?>? authorEvaluation,
      Wrapped<int?>? readingTime,
      Wrapped<int?>? numberOfChapters,
      Wrapped<List<int>?>? categoryIds,
      Wrapped<List<int>?>? tagIds,
      Wrapped<int?>? ageAverage,
      Wrapped<bool?>? status}) {
    return BookRequest(
        title: (title != null ? title.value : this.title),
        authorId: (authorId != null ? authorId.value : this.authorId),
        publisherId:
            (publisherId != null ? publisherId.value : this.publisherId),
        publicationYear: (publicationYear != null
            ? publicationYear.value
            : this.publicationYear),
        isbn: (isbn != null ? isbn.value : this.isbn),
        price: (price != null ? price.value : this.price),
        description:
            (description != null ? description.value : this.description),
        resourceType:
            (resourceType != null ? resourceType.value : this.resourceType),
        language: (language != null ? language.value : this.language),
        pageCount: (pageCount != null ? pageCount.value : this.pageCount),
        excerpt: (excerpt != null ? excerpt.value : this.excerpt),
        authorEvaluation: (authorEvaluation != null
            ? authorEvaluation.value
            : this.authorEvaluation),
        readingTime:
            (readingTime != null ? readingTime.value : this.readingTime),
        numberOfChapters: (numberOfChapters != null
            ? numberOfChapters.value
            : this.numberOfChapters),
        categoryIds:
            (categoryIds != null ? categoryIds.value : this.categoryIds),
        tagIds: (tagIds != null ? tagIds.value : this.tagIds),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage),
        status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class AdminBookUploadFormRequest {
  const AdminBookUploadFormRequest({
    this.fileData,
    this.bookId,
    this.title,
    this.chapterNumber,
    this.format,
    this.isEncrypted,
  });

  factory AdminBookUploadFormRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminBookUploadFormRequestFromJson(json);

  static const toJsonFactory = _$AdminBookUploadFormRequestToJson;
  Map<String, dynamic> toJson() => _$AdminBookUploadFormRequestToJson(this);

  @JsonKey(name: 'fileData', includeIfNull: false)
  final String? fileData;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final String? bookId;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'chapterNumber', includeIfNull: false)
  final int? chapterNumber;
  @JsonKey(name: 'format', includeIfNull: false)
  final String? format;
  @JsonKey(name: 'isEncrypted', includeIfNull: false)
  final String? isEncrypted;
  static const fromJsonFactory = _$AdminBookUploadFormRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdminBookUploadFormRequest &&
            (identical(other.fileData, fileData) ||
                const DeepCollectionEquality()
                    .equals(other.fileData, fileData)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.chapterNumber, chapterNumber) ||
                const DeepCollectionEquality()
                    .equals(other.chapterNumber, chapterNumber)) &&
            (identical(other.format, format) ||
                const DeepCollectionEquality().equals(other.format, format)) &&
            (identical(other.isEncrypted, isEncrypted) ||
                const DeepCollectionEquality()
                    .equals(other.isEncrypted, isEncrypted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(fileData) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(chapterNumber) ^
      const DeepCollectionEquality().hash(format) ^
      const DeepCollectionEquality().hash(isEncrypted) ^
      runtimeType.hashCode;
}

extension $AdminBookUploadFormRequestExtension on AdminBookUploadFormRequest {
  AdminBookUploadFormRequest copyWith(
      {String? fileData,
      String? bookId,
      String? title,
      int? chapterNumber,
      String? format,
      String? isEncrypted}) {
    return AdminBookUploadFormRequest(
        fileData: fileData ?? this.fileData,
        bookId: bookId ?? this.bookId,
        title: title ?? this.title,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        format: format ?? this.format,
        isEncrypted: isEncrypted ?? this.isEncrypted);
  }

  AdminBookUploadFormRequest copyWithWrapped(
      {Wrapped<String?>? fileData,
      Wrapped<String?>? bookId,
      Wrapped<String?>? title,
      Wrapped<int?>? chapterNumber,
      Wrapped<String?>? format,
      Wrapped<String?>? isEncrypted}) {
    return AdminBookUploadFormRequest(
        fileData: (fileData != null ? fileData.value : this.fileData),
        bookId: (bookId != null ? bookId.value : this.bookId),
        title: (title != null ? title.value : this.title),
        chapterNumber:
            (chapterNumber != null ? chapterNumber.value : this.chapterNumber),
        format: (format != null ? format.value : this.format),
        isEncrypted:
            (isEncrypted != null ? isEncrypted.value : this.isEncrypted));
  }
}

@JsonSerializable(explicitToJson: true)
class BookImageFormRequest {
  const BookImageFormRequest({
    this.fileData,
    this.bookId,
  });

  factory BookImageFormRequest.fromJson(Map<String, dynamic> json) =>
      _$BookImageFormRequestFromJson(json);

  static const toJsonFactory = _$BookImageFormRequestToJson;
  Map<String, dynamic> toJson() => _$BookImageFormRequestToJson(this);

  @JsonKey(name: 'fileData', includeIfNull: false)
  final String? fileData;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final String? bookId;
  static const fromJsonFactory = _$BookImageFormRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookImageFormRequest &&
            (identical(other.fileData, fileData) ||
                const DeepCollectionEquality()
                    .equals(other.fileData, fileData)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(fileData) ^
      const DeepCollectionEquality().hash(bookId) ^
      runtimeType.hashCode;
}

extension $BookImageFormRequestExtension on BookImageFormRequest {
  BookImageFormRequest copyWith({String? fileData, String? bookId}) {
    return BookImageFormRequest(
        fileData: fileData ?? this.fileData, bookId: bookId ?? this.bookId);
  }

  BookImageFormRequest copyWithWrapped(
      {Wrapped<String?>? fileData, Wrapped<String?>? bookId}) {
    return BookImageFormRequest(
        fileData: (fileData != null ? fileData.value : this.fileData),
        bookId: (bookId != null ? bookId.value : this.bookId));
  }
}

@JsonSerializable(explicitToJson: true)
class BookComment {
  const BookComment({
    this.id,
    this.userId,
    this.bookId,
    this.commentText,
    this.createdAt,
    this.updatedAt,
    this.deleted,
  });

  factory BookComment.fromJson(Map<String, dynamic> json) =>
      _$BookCommentFromJson(json);

  static const toJsonFactory = _$BookCommentToJson;
  Map<String, dynamic> toJson() => _$BookCommentToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'userId', includeIfNull: false)
  final int? userId;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'commentText', includeIfNull: false)
  final String? commentText;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  static const fromJsonFactory = _$BookCommentFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookComment &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.commentText, commentText) ||
                const DeepCollectionEquality()
                    .equals(other.commentText, commentText)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality().equals(other.deleted, deleted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(commentText) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(deleted) ^
      runtimeType.hashCode;
}

extension $BookCommentExtension on BookComment {
  BookComment copyWith(
      {int? id,
      int? userId,
      int? bookId,
      String? commentText,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? deleted}) {
    return BookComment(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        bookId: bookId ?? this.bookId,
        commentText: commentText ?? this.commentText,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted);
  }

  BookComment copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<int?>? userId,
      Wrapped<int?>? bookId,
      Wrapped<String?>? commentText,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? deleted}) {
    return BookComment(
        id: (id != null ? id.value : this.id),
        userId: (userId != null ? userId.value : this.userId),
        bookId: (bookId != null ? bookId.value : this.bookId),
        commentText:
            (commentText != null ? commentText.value : this.commentText),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        deleted: (deleted != null ? deleted.value : this.deleted));
  }
}

@JsonSerializable(explicitToJson: true)
class BookReview {
  const BookReview({
    this.id,
    this.bookId,
    this.userId,
    this.rating,
    this.reviewText,
    this.createdAt,
    this.updatedAt,
    this.deleted,
    this.userName,
    this.avatarUrl,
  });

  factory BookReview.fromJson(Map<String, dynamic> json) =>
      _$BookReviewFromJson(json);

  static const toJsonFactory = _$BookReviewToJson;
  Map<String, dynamic> toJson() => _$BookReviewToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'userId', includeIfNull: false)
  final int? userId;
  @JsonKey(name: 'rating', includeIfNull: false)
  final int? rating;
  @JsonKey(name: 'reviewText', includeIfNull: false)
  final String? reviewText;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  @JsonKey(name: 'userName', includeIfNull: false)
  final String? userName;
  @JsonKey(name: 'avatarUrl', includeIfNull: false)
  final String? avatarUrl;
  static const fromJsonFactory = _$BookReviewFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookReview &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.reviewText, reviewText) ||
                const DeepCollectionEquality()
                    .equals(other.reviewText, reviewText)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality()
                    .equals(other.deleted, deleted)) &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(reviewText) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(deleted) ^
      const DeepCollectionEquality().hash(userName) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      runtimeType.hashCode;
}

extension $BookReviewExtension on BookReview {
  BookReview copyWith(
      {int? id,
      int? bookId,
      int? userId,
      int? rating,
      String? reviewText,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? deleted,
      String? userName,
      String? avatarUrl}) {
    return BookReview(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        userId: userId ?? this.userId,
        rating: rating ?? this.rating,
        reviewText: reviewText ?? this.reviewText,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted,
        userName: userName ?? this.userName,
        avatarUrl: avatarUrl ?? this.avatarUrl);
  }

  BookReview copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<int?>? bookId,
      Wrapped<int?>? userId,
      Wrapped<int?>? rating,
      Wrapped<String?>? reviewText,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? deleted,
      Wrapped<String?>? userName,
      Wrapped<String?>? avatarUrl}) {
    return BookReview(
        id: (id != null ? id.value : this.id),
        bookId: (bookId != null ? bookId.value : this.bookId),
        userId: (userId != null ? userId.value : this.userId),
        rating: (rating != null ? rating.value : this.rating),
        reviewText: (reviewText != null ? reviewText.value : this.reviewText),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        deleted: (deleted != null ? deleted.value : this.deleted),
        userName: (userName != null ? userName.value : this.userName),
        avatarUrl: (avatarUrl != null ? avatarUrl.value : this.avatarUrl));
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryRequest {
  const CategoryRequest({
    this.name,
  });

  factory CategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryRequestFromJson(json);

  static const toJsonFactory = _$CategoryRequestToJson;
  Map<String, dynamic> toJson() => _$CategoryRequestToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$CategoryRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CategoryRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^ runtimeType.hashCode;
}

extension $CategoryRequestExtension on CategoryRequest {
  CategoryRequest copyWith({String? name}) {
    return CategoryRequest(name: name ?? this.name);
  }

  CategoryRequest copyWithWrapped({Wrapped<String?>? name}) {
    return CategoryRequest(name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class Order {
  const Order({
    this.id,
    this.userId,
    this.totalPrice,
    this.paymentMethod,
    this.orderStatus,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  static const toJsonFactory = _$OrderToJson;
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'userId', includeIfNull: false)
  final int? userId;
  @JsonKey(name: 'totalPrice', includeIfNull: false)
  final double? totalPrice;
  @JsonKey(name: 'paymentMethod', includeIfNull: false)
  final String? paymentMethod;
  @JsonKey(name: 'orderStatus', includeIfNull: false)
  final String? orderStatus;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(
      name: 'orderItems', includeIfNull: false, defaultValue: <OrderItem>[])
  final List<OrderItem>? orderItems;
  static const fromJsonFactory = _$OrderFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Order &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.totalPrice, totalPrice) ||
                const DeepCollectionEquality()
                    .equals(other.totalPrice, totalPrice)) &&
            (identical(other.paymentMethod, paymentMethod) ||
                const DeepCollectionEquality()
                    .equals(other.paymentMethod, paymentMethod)) &&
            (identical(other.orderStatus, orderStatus) ||
                const DeepCollectionEquality()
                    .equals(other.orderStatus, orderStatus)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.orderItems, orderItems) ||
                const DeepCollectionEquality()
                    .equals(other.orderItems, orderItems)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(totalPrice) ^
      const DeepCollectionEquality().hash(paymentMethod) ^
      const DeepCollectionEquality().hash(orderStatus) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(orderItems) ^
      runtimeType.hashCode;
}

extension $OrderExtension on Order {
  Order copyWith(
      {int? id,
      int? userId,
      double? totalPrice,
      String? paymentMethod,
      String? orderStatus,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<OrderItem>? orderItems}) {
    return Order(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        totalPrice: totalPrice ?? this.totalPrice,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        orderStatus: orderStatus ?? this.orderStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        orderItems: orderItems ?? this.orderItems);
  }

  Order copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<int?>? userId,
      Wrapped<double?>? totalPrice,
      Wrapped<String?>? paymentMethod,
      Wrapped<String?>? orderStatus,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<List<OrderItem>?>? orderItems}) {
    return Order(
        id: (id != null ? id.value : this.id),
        userId: (userId != null ? userId.value : this.userId),
        totalPrice: (totalPrice != null ? totalPrice.value : this.totalPrice),
        paymentMethod:
            (paymentMethod != null ? paymentMethod.value : this.paymentMethod),
        orderStatus:
            (orderStatus != null ? orderStatus.value : this.orderStatus),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        orderItems: (orderItems != null ? orderItems.value : this.orderItems));
  }
}

@JsonSerializable(explicitToJson: true)
class OrderItem {
  const OrderItem({
    this.data,
    this.id,
    this.orderId,
    this.bookId,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.deleted,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  static const toJsonFactory = _$OrderItemToJson;
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final Map<String, dynamic>? data;
  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'orderId', includeIfNull: false)
  final int? orderId;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  static const fromJsonFactory = _$OrderItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OrderItem &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality()
                    .equals(other.orderId, orderId)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality().equals(other.deleted, deleted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(deleted) ^
      runtimeType.hashCode;
}

extension $OrderItemExtension on OrderItem {
  OrderItem copyWith(
      {Map<String, dynamic>? data,
      int? id,
      int? orderId,
      int? bookId,
      double? price,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? deleted}) {
    return OrderItem(
        data: data ?? this.data,
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        bookId: bookId ?? this.bookId,
        price: price ?? this.price,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted);
  }

  OrderItem copyWithWrapped(
      {Wrapped<Map<String, dynamic>?>? data,
      Wrapped<int?>? id,
      Wrapped<int?>? orderId,
      Wrapped<int?>? bookId,
      Wrapped<double?>? price,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? deleted}) {
    return OrderItem(
        data: (data != null ? data.value : this.data),
        id: (id != null ? id.value : this.id),
        orderId: (orderId != null ? orderId.value : this.orderId),
        bookId: (bookId != null ? bookId.value : this.bookId),
        price: (price != null ? price.value : this.price),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        deleted: (deleted != null ? deleted.value : this.deleted));
  }
}

@JsonSerializable(explicitToJson: true)
class OrderRequest {
  const OrderRequest({
    this.userId,
    this.totalPrice,
    this.paymentMethod,
    this.orderStatus,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  static const toJsonFactory = _$OrderRequestToJson;
  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);

  @JsonKey(name: 'userId', includeIfNull: false)
  final int? userId;
  @JsonKey(name: 'totalPrice', includeIfNull: false)
  final double? totalPrice;
  @JsonKey(name: 'paymentMethod', includeIfNull: false)
  final String? paymentMethod;
  @JsonKey(name: 'orderStatus', includeIfNull: false)
  final String? orderStatus;
  static const fromJsonFactory = _$OrderRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OrderRequest &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.totalPrice, totalPrice) ||
                const DeepCollectionEquality()
                    .equals(other.totalPrice, totalPrice)) &&
            (identical(other.paymentMethod, paymentMethod) ||
                const DeepCollectionEquality()
                    .equals(other.paymentMethod, paymentMethod)) &&
            (identical(other.orderStatus, orderStatus) ||
                const DeepCollectionEquality()
                    .equals(other.orderStatus, orderStatus)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(totalPrice) ^
      const DeepCollectionEquality().hash(paymentMethod) ^
      const DeepCollectionEquality().hash(orderStatus) ^
      runtimeType.hashCode;
}

extension $OrderRequestExtension on OrderRequest {
  OrderRequest copyWith(
      {int? userId,
      double? totalPrice,
      String? paymentMethod,
      String? orderStatus}) {
    return OrderRequest(
        userId: userId ?? this.userId,
        totalPrice: totalPrice ?? this.totalPrice,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        orderStatus: orderStatus ?? this.orderStatus);
  }

  OrderRequest copyWithWrapped(
      {Wrapped<int?>? userId,
      Wrapped<double?>? totalPrice,
      Wrapped<String?>? paymentMethod,
      Wrapped<String?>? orderStatus}) {
    return OrderRequest(
        userId: (userId != null ? userId.value : this.userId),
        totalPrice: (totalPrice != null ? totalPrice.value : this.totalPrice),
        paymentMethod:
            (paymentMethod != null ? paymentMethod.value : this.paymentMethod),
        orderStatus:
            (orderStatus != null ? orderStatus.value : this.orderStatus));
  }
}

@JsonSerializable(explicitToJson: true)
class PublicBookRequest {
  const PublicBookRequest({
    this.id,
    this.userId,
    this.bookId,
    this.status,
    this.requestedAt,
    this.approvedAt,
    this.data,
  });

  factory PublicBookRequest.fromJson(Map<String, dynamic> json) =>
      _$PublicBookRequestFromJson(json);

  static const toJsonFactory = _$PublicBookRequestToJson;
  Map<String, dynamic> toJson() => _$PublicBookRequestToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'userId', includeIfNull: false)
  final int? userId;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'status', includeIfNull: false)
  final String? status;
  @JsonKey(name: 'requestedAt', includeIfNull: false)
  final DateTime? requestedAt;
  @JsonKey(name: 'approvedAt', includeIfNull: false)
  final DateTime? approvedAt;
  @JsonKey(name: 'data', includeIfNull: false)
  final Map<String, dynamic>? data;
  static const fromJsonFactory = _$PublicBookRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PublicBookRequest &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.requestedAt, requestedAt) ||
                const DeepCollectionEquality()
                    .equals(other.requestedAt, requestedAt)) &&
            (identical(other.approvedAt, approvedAt) ||
                const DeepCollectionEquality()
                    .equals(other.approvedAt, approvedAt)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(requestedAt) ^
      const DeepCollectionEquality().hash(approvedAt) ^
      const DeepCollectionEquality().hash(data) ^
      runtimeType.hashCode;
}

extension $PublicBookRequestExtension on PublicBookRequest {
  PublicBookRequest copyWith(
      {int? id,
      int? userId,
      int? bookId,
      String? status,
      DateTime? requestedAt,
      DateTime? approvedAt,
      Map<String, dynamic>? data}) {
    return PublicBookRequest(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        bookId: bookId ?? this.bookId,
        status: status ?? this.status,
        requestedAt: requestedAt ?? this.requestedAt,
        approvedAt: approvedAt ?? this.approvedAt,
        data: data ?? this.data);
  }

  PublicBookRequest copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<int?>? userId,
      Wrapped<int?>? bookId,
      Wrapped<String?>? status,
      Wrapped<DateTime?>? requestedAt,
      Wrapped<DateTime?>? approvedAt,
      Wrapped<Map<String, dynamic>?>? data}) {
    return PublicBookRequest(
        id: (id != null ? id.value : this.id),
        userId: (userId != null ? userId.value : this.userId),
        bookId: (bookId != null ? bookId.value : this.bookId),
        status: (status != null ? status.value : this.status),
        requestedAt:
            (requestedAt != null ? requestedAt.value : this.requestedAt),
        approvedAt: (approvedAt != null ? approvedAt.value : this.approvedAt),
        data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class PublisherRequest {
  const PublisherRequest({
    this.name,
    this.address,
    this.contactInfo,
  });

  factory PublisherRequest.fromJson(Map<String, dynamic> json) =>
      _$PublisherRequestFromJson(json);

  static const toJsonFactory = _$PublisherRequestToJson;
  Map<String, dynamic> toJson() => _$PublisherRequestToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'address', includeIfNull: false)
  final String? address;
  @JsonKey(name: 'contactInfo', includeIfNull: false)
  final String? contactInfo;
  static const fromJsonFactory = _$PublisherRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PublisherRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.contactInfo, contactInfo) ||
                const DeepCollectionEquality()
                    .equals(other.contactInfo, contactInfo)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(contactInfo) ^
      runtimeType.hashCode;
}

extension $PublisherRequestExtension on PublisherRequest {
  PublisherRequest copyWith(
      {String? name, String? address, String? contactInfo}) {
    return PublisherRequest(
        name: name ?? this.name,
        address: address ?? this.address,
        contactInfo: contactInfo ?? this.contactInfo);
  }

  PublisherRequest copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? address,
      Wrapped<String?>? contactInfo}) {
    return PublisherRequest(
        name: (name != null ? name.value : this.name),
        address: (address != null ? address.value : this.address),
        contactInfo:
            (contactInfo != null ? contactInfo.value : this.contactInfo));
  }
}

@JsonSerializable(explicitToJson: true)
class TagRequest {
  const TagRequest({
    this.tagName,
  });

  factory TagRequest.fromJson(Map<String, dynamic> json) =>
      _$TagRequestFromJson(json);

  static const toJsonFactory = _$TagRequestToJson;
  Map<String, dynamic> toJson() => _$TagRequestToJson(this);

  @JsonKey(name: 'tagName', includeIfNull: false)
  final String? tagName;
  static const fromJsonFactory = _$TagRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TagRequest &&
            (identical(other.tagName, tagName) ||
                const DeepCollectionEquality().equals(other.tagName, tagName)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tagName) ^ runtimeType.hashCode;
}

extension $TagRequestExtension on TagRequest {
  TagRequest copyWith({String? tagName}) {
    return TagRequest(tagName: tagName ?? this.tagName);
  }

  TagRequest copyWithWrapped({Wrapped<String?>? tagName}) {
    return TagRequest(
        tagName: (tagName != null ? tagName.value : this.tagName));
  }
}

@JsonSerializable(explicitToJson: true)
class AdminLoginFormRequest {
  const AdminLoginFormRequest({
    this.phone,
    this.password,
  });

  factory AdminLoginFormRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminLoginFormRequestFromJson(json);

  static const toJsonFactory = _$AdminLoginFormRequestToJson;
  Map<String, dynamic> toJson() => _$AdminLoginFormRequestToJson(this);

  @JsonKey(name: 'phone', includeIfNull: false)
  final String? phone;
  @JsonKey(name: 'password', includeIfNull: false)
  final String? password;
  static const fromJsonFactory = _$AdminLoginFormRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdminLoginFormRequest &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $AdminLoginFormRequestExtension on AdminLoginFormRequest {
  AdminLoginFormRequest copyWith({String? phone, String? password}) {
    return AdminLoginFormRequest(
        phone: phone ?? this.phone, password: password ?? this.password);
  }

  AdminLoginFormRequest copyWithWrapped(
      {Wrapped<String?>? phone, Wrapped<String?>? password}) {
    return AdminLoginFormRequest(
        phone: (phone != null ? phone.value : this.phone),
        password: (password != null ? password.value : this.password));
  }
}

@JsonSerializable(explicitToJson: true)
class VoucherRequest {
  const VoucherRequest({
    this.code,
    this.description,
    this.discountPercentage,
    this.maxDiscountAmount,
    this.startDate,
    this.endDate,
    this.isActive,
  });

  factory VoucherRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherRequestFromJson(json);

  static const toJsonFactory = _$VoucherRequestToJson;
  Map<String, dynamic> toJson() => _$VoucherRequestToJson(this);

  @JsonKey(name: 'code', includeIfNull: false)
  final String? code;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'discountPercentage', includeIfNull: false)
  final double? discountPercentage;
  @JsonKey(name: 'maxDiscountAmount', includeIfNull: false)
  final double? maxDiscountAmount;
  @JsonKey(name: 'startDate', includeIfNull: false)
  final DateTime? startDate;
  @JsonKey(name: 'endDate', includeIfNull: false)
  final DateTime? endDate;
  @JsonKey(name: 'isActive', includeIfNull: false)
  final bool? isActive;
  static const fromJsonFactory = _$VoucherRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VoucherRequest &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.discountPercentage, discountPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.discountPercentage, discountPercentage)) &&
            (identical(other.maxDiscountAmount, maxDiscountAmount) ||
                const DeepCollectionEquality()
                    .equals(other.maxDiscountAmount, maxDiscountAmount)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality()
                    .equals(other.endDate, endDate)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(discountPercentage) ^
      const DeepCollectionEquality().hash(maxDiscountAmount) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(isActive) ^
      runtimeType.hashCode;
}

extension $VoucherRequestExtension on VoucherRequest {
  VoucherRequest copyWith(
      {String? code,
      String? description,
      double? discountPercentage,
      double? maxDiscountAmount,
      DateTime? startDate,
      DateTime? endDate,
      bool? isActive}) {
    return VoucherRequest(
        code: code ?? this.code,
        description: description ?? this.description,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        maxDiscountAmount: maxDiscountAmount ?? this.maxDiscountAmount,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        isActive: isActive ?? this.isActive);
  }

  VoucherRequest copyWithWrapped(
      {Wrapped<String?>? code,
      Wrapped<String?>? description,
      Wrapped<double?>? discountPercentage,
      Wrapped<double?>? maxDiscountAmount,
      Wrapped<DateTime?>? startDate,
      Wrapped<DateTime?>? endDate,
      Wrapped<bool?>? isActive}) {
    return VoucherRequest(
        code: (code != null ? code.value : this.code),
        description:
            (description != null ? description.value : this.description),
        discountPercentage: (discountPercentage != null
            ? discountPercentage.value
            : this.discountPercentage),
        maxDiscountAmount: (maxDiscountAmount != null
            ? maxDiscountAmount.value
            : this.maxDiscountAmount),
        startDate: (startDate != null ? startDate.value : this.startDate),
        endDate: (endDate != null ? endDate.value : this.endDate),
        isActive: (isActive != null ? isActive.value : this.isActive));
  }
}

@JsonSerializable(explicitToJson: true)
class Voucher {
  const Voucher({
    this.id,
    this.code,
    this.description,
    this.discountPercentage,
    this.maxDiscountAmount,
    this.startDate,
    this.endDate,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);

  static const toJsonFactory = _$VoucherToJson;
  Map<String, dynamic> toJson() => _$VoucherToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'code', includeIfNull: false)
  final String? code;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'discountPercentage', includeIfNull: false)
  final double? discountPercentage;
  @JsonKey(name: 'maxDiscountAmount', includeIfNull: false)
  final double? maxDiscountAmount;
  @JsonKey(name: 'startDate', includeIfNull: false)
  final DateTime? startDate;
  @JsonKey(name: 'endDate', includeIfNull: false)
  final DateTime? endDate;
  @JsonKey(name: 'isActive', includeIfNull: false)
  final bool? isActive;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  static const fromJsonFactory = _$VoucherFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Voucher &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.discountPercentage, discountPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.discountPercentage, discountPercentage)) &&
            (identical(other.maxDiscountAmount, maxDiscountAmount) ||
                const DeepCollectionEquality()
                    .equals(other.maxDiscountAmount, maxDiscountAmount)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality()
                    .equals(other.endDate, endDate)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(discountPercentage) ^
      const DeepCollectionEquality().hash(maxDiscountAmount) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $VoucherExtension on Voucher {
  Voucher copyWith(
      {int? id,
      String? code,
      String? description,
      double? discountPercentage,
      double? maxDiscountAmount,
      DateTime? startDate,
      DateTime? endDate,
      bool? isActive,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return Voucher(
        id: id ?? this.id,
        code: code ?? this.code,
        description: description ?? this.description,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        maxDiscountAmount: maxDiscountAmount ?? this.maxDiscountAmount,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Voucher copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? code,
      Wrapped<String?>? description,
      Wrapped<double?>? discountPercentage,
      Wrapped<double?>? maxDiscountAmount,
      Wrapped<DateTime?>? startDate,
      Wrapped<DateTime?>? endDate,
      Wrapped<bool?>? isActive,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt}) {
    return Voucher(
        id: (id != null ? id.value : this.id),
        code: (code != null ? code.value : this.code),
        description:
            (description != null ? description.value : this.description),
        discountPercentage: (discountPercentage != null
            ? discountPercentage.value
            : this.discountPercentage),
        maxDiscountAmount: (maxDiscountAmount != null
            ? maxDiscountAmount.value
            : this.maxDiscountAmount),
        startDate: (startDate != null ? startDate.value : this.startDate),
        endDate: (endDate != null ? endDate.value : this.endDate),
        isActive: (isActive != null ? isActive.value : this.isActive),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt));
  }
}

@JsonSerializable(explicitToJson: true)
class MakeOrderRequest {
  const MakeOrderRequest({
    this.bookIds,
    this.voucherId,
  });

  factory MakeOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$MakeOrderRequestFromJson(json);

  static const toJsonFactory = _$MakeOrderRequestToJson;
  Map<String, dynamic> toJson() => _$MakeOrderRequestToJson(this);

  @JsonKey(name: 'bookIds', includeIfNull: false, defaultValue: <int>[])
  final List<int>? bookIds;
  @JsonKey(name: 'voucherId', includeIfNull: false)
  final int? voucherId;
  static const fromJsonFactory = _$MakeOrderRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MakeOrderRequest &&
            (identical(other.bookIds, bookIds) ||
                const DeepCollectionEquality()
                    .equals(other.bookIds, bookIds)) &&
            (identical(other.voucherId, voucherId) ||
                const DeepCollectionEquality()
                    .equals(other.voucherId, voucherId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bookIds) ^
      const DeepCollectionEquality().hash(voucherId) ^
      runtimeType.hashCode;
}

extension $MakeOrderRequestExtension on MakeOrderRequest {
  MakeOrderRequest copyWith({List<int>? bookIds, int? voucherId}) {
    return MakeOrderRequest(
        bookIds: bookIds ?? this.bookIds,
        voucherId: voucherId ?? this.voucherId);
  }

  MakeOrderRequest copyWithWrapped(
      {Wrapped<List<int>?>? bookIds, Wrapped<int?>? voucherId}) {
    return MakeOrderRequest(
        bookIds: (bookIds != null ? bookIds.value : this.bookIds),
        voucherId: (voucherId != null ? voucherId.value : this.voucherId));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthorAppResponse {
  const AuthorAppResponse({
    this.id,
    this.name,
    this.biography,
    this.avatarUrl,
    this.books,
  });

  factory AuthorAppResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthorAppResponseFromJson(json);

  static const toJsonFactory = _$AuthorAppResponseToJson;
  Map<String, dynamic> toJson() => _$AuthorAppResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'biography', includeIfNull: false)
  final String? biography;
  @JsonKey(name: 'avatarUrl', includeIfNull: false)
  final String? avatarUrl;
  @JsonKey(
      name: 'books',
      includeIfNull: false,
      defaultValue: <RetrieveBookByAuthorIdResponse>[])
  final List<RetrieveBookByAuthorIdResponse>? books;
  static const fromJsonFactory = _$AuthorAppResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthorAppResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.biography, biography) ||
                const DeepCollectionEquality()
                    .equals(other.biography, biography)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)) &&
            (identical(other.books, books) ||
                const DeepCollectionEquality().equals(other.books, books)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(biography) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      const DeepCollectionEquality().hash(books) ^
      runtimeType.hashCode;
}

extension $AuthorAppResponseExtension on AuthorAppResponse {
  AuthorAppResponse copyWith(
      {int? id,
      String? name,
      String? biography,
      String? avatarUrl,
      List<RetrieveBookByAuthorIdResponse>? books}) {
    return AuthorAppResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        biography: biography ?? this.biography,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        books: books ?? this.books);
  }

  AuthorAppResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? name,
      Wrapped<String?>? biography,
      Wrapped<String?>? avatarUrl,
      Wrapped<List<RetrieveBookByAuthorIdResponse>?>? books}) {
    return AuthorAppResponse(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        biography: (biography != null ? biography.value : this.biography),
        avatarUrl: (avatarUrl != null ? avatarUrl.value : this.avatarUrl),
        books: (books != null ? books.value : this.books));
  }
}

@JsonSerializable(explicitToJson: true)
class RetrieveBookByAuthorIdResponse {
  const RetrieveBookByAuthorIdResponse({
    this.id,
    this.title,
    this.publisher,
    this.publicationYear,
    this.isbn,
    this.price,
    this.description,
    this.resourceType,
    this.language,
    this.pageCount,
    this.tags,
    this.imageUrl,
    this.categories,
    this.ageAverage,
  });

  factory RetrieveBookByAuthorIdResponse.fromJson(Map<String, dynamic> json) =>
      _$RetrieveBookByAuthorIdResponseFromJson(json);

  static const toJsonFactory = _$RetrieveBookByAuthorIdResponseToJson;
  Map<String, dynamic> toJson() => _$RetrieveBookByAuthorIdResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'publisher', includeIfNull: false)
  final Publisher? publisher;
  @JsonKey(name: 'publicationYear', includeIfNull: false)
  final int? publicationYear;
  @JsonKey(name: 'isbn', includeIfNull: false)
  final String? isbn;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'resourceType', includeIfNull: false)
  final String? resourceType;
  @JsonKey(name: 'language', includeIfNull: false)
  final String? language;
  @JsonKey(name: 'pageCount', includeIfNull: false)
  final int? pageCount;
  @JsonKey(name: 'tags', includeIfNull: false)
  final String? tags;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'categories', includeIfNull: false)
  final String? categories;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  static const fromJsonFactory = _$RetrieveBookByAuthorIdResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RetrieveBookByAuthorIdResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.publicationYear, publicationYear) ||
                const DeepCollectionEquality()
                    .equals(other.publicationYear, publicationYear)) &&
            (identical(other.isbn, isbn) ||
                const DeepCollectionEquality().equals(other.isbn, isbn)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.resourceType, resourceType) ||
                const DeepCollectionEquality()
                    .equals(other.resourceType, resourceType)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.pageCount, pageCount) ||
                const DeepCollectionEquality()
                    .equals(other.pageCount, pageCount)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(publicationYear) ^
      const DeepCollectionEquality().hash(isbn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(resourceType) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(pageCount) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      runtimeType.hashCode;
}

extension $RetrieveBookByAuthorIdResponseExtension
    on RetrieveBookByAuthorIdResponse {
  RetrieveBookByAuthorIdResponse copyWith(
      {int? id,
      String? title,
      Publisher? publisher,
      int? publicationYear,
      String? isbn,
      double? price,
      String? description,
      String? resourceType,
      String? language,
      int? pageCount,
      String? tags,
      String? imageUrl,
      String? categories,
      int? ageAverage}) {
    return RetrieveBookByAuthorIdResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        publisher: publisher ?? this.publisher,
        publicationYear: publicationYear ?? this.publicationYear,
        isbn: isbn ?? this.isbn,
        price: price ?? this.price,
        description: description ?? this.description,
        resourceType: resourceType ?? this.resourceType,
        language: language ?? this.language,
        pageCount: pageCount ?? this.pageCount,
        tags: tags ?? this.tags,
        imageUrl: imageUrl ?? this.imageUrl,
        categories: categories ?? this.categories,
        ageAverage: ageAverage ?? this.ageAverage);
  }

  RetrieveBookByAuthorIdResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? title,
      Wrapped<Publisher?>? publisher,
      Wrapped<int?>? publicationYear,
      Wrapped<String?>? isbn,
      Wrapped<double?>? price,
      Wrapped<String?>? description,
      Wrapped<String?>? resourceType,
      Wrapped<String?>? language,
      Wrapped<int?>? pageCount,
      Wrapped<String?>? tags,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? categories,
      Wrapped<int?>? ageAverage}) {
    return RetrieveBookByAuthorIdResponse(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        publisher: (publisher != null ? publisher.value : this.publisher),
        publicationYear: (publicationYear != null
            ? publicationYear.value
            : this.publicationYear),
        isbn: (isbn != null ? isbn.value : this.isbn),
        price: (price != null ? price.value : this.price),
        description:
            (description != null ? description.value : this.description),
        resourceType:
            (resourceType != null ? resourceType.value : this.resourceType),
        language: (language != null ? language.value : this.language),
        pageCount: (pageCount != null ? pageCount.value : this.pageCount),
        tags: (tags != null ? tags.value : this.tags),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        categories: (categories != null ? categories.value : this.categories),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage));
  }
}

@JsonSerializable(explicitToJson: true)
class BookAppRequest {
  const BookAppRequest({
    this.title,
    this.authorId,
    this.publisherId,
    this.publicationYear,
    this.isbn,
    this.price,
    this.description,
    this.resourceType,
    this.language,
    this.pageCount,
    this.excerpt,
    this.authorEvaluation,
    this.readingTime,
    this.numberOfChapters,
    this.categoryIds,
    this.tagIds,
    this.ageAverage,
  });

  factory BookAppRequest.fromJson(Map<String, dynamic> json) =>
      _$BookAppRequestFromJson(json);

  static const toJsonFactory = _$BookAppRequestToJson;
  Map<String, dynamic> toJson() => _$BookAppRequestToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'authorId', includeIfNull: false)
  final int? authorId;
  @JsonKey(name: 'publisherId', includeIfNull: false)
  final int? publisherId;
  @JsonKey(name: 'publicationYear', includeIfNull: false)
  final int? publicationYear;
  @JsonKey(name: 'isbn', includeIfNull: false)
  final String? isbn;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'resourceType', includeIfNull: false)
  final String? resourceType;
  @JsonKey(name: 'language', includeIfNull: false)
  final String? language;
  @JsonKey(name: 'pageCount', includeIfNull: false)
  final int? pageCount;
  @JsonKey(name: 'excerpt', includeIfNull: false)
  final String? excerpt;
  @JsonKey(name: 'authorEvaluation', includeIfNull: false)
  final String? authorEvaluation;
  @JsonKey(name: 'readingTime', includeIfNull: false)
  final int? readingTime;
  @JsonKey(name: 'numberOfChapters', includeIfNull: false)
  final int? numberOfChapters;
  @JsonKey(name: 'categoryIds', includeIfNull: false, defaultValue: <int>[])
  final List<int>? categoryIds;
  @JsonKey(name: 'tagIds', includeIfNull: false, defaultValue: <int>[])
  final List<int>? tagIds;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  static const fromJsonFactory = _$BookAppRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookAppRequest &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)) &&
            (identical(other.publisherId, publisherId) ||
                const DeepCollectionEquality()
                    .equals(other.publisherId, publisherId)) &&
            (identical(other.publicationYear, publicationYear) ||
                const DeepCollectionEquality()
                    .equals(other.publicationYear, publicationYear)) &&
            (identical(other.isbn, isbn) ||
                const DeepCollectionEquality().equals(other.isbn, isbn)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.resourceType, resourceType) ||
                const DeepCollectionEquality()
                    .equals(other.resourceType, resourceType)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.pageCount, pageCount) ||
                const DeepCollectionEquality()
                    .equals(other.pageCount, pageCount)) &&
            (identical(other.excerpt, excerpt) ||
                const DeepCollectionEquality()
                    .equals(other.excerpt, excerpt)) &&
            (identical(other.authorEvaluation, authorEvaluation) ||
                const DeepCollectionEquality()
                    .equals(other.authorEvaluation, authorEvaluation)) &&
            (identical(other.readingTime, readingTime) ||
                const DeepCollectionEquality()
                    .equals(other.readingTime, readingTime)) &&
            (identical(other.numberOfChapters, numberOfChapters) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfChapters, numberOfChapters)) &&
            (identical(other.categoryIds, categoryIds) ||
                const DeepCollectionEquality()
                    .equals(other.categoryIds, categoryIds)) &&
            (identical(other.tagIds, tagIds) ||
                const DeepCollectionEquality().equals(other.tagIds, tagIds)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(authorId) ^
      const DeepCollectionEquality().hash(publisherId) ^
      const DeepCollectionEquality().hash(publicationYear) ^
      const DeepCollectionEquality().hash(isbn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(resourceType) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(pageCount) ^
      const DeepCollectionEquality().hash(excerpt) ^
      const DeepCollectionEquality().hash(authorEvaluation) ^
      const DeepCollectionEquality().hash(readingTime) ^
      const DeepCollectionEquality().hash(numberOfChapters) ^
      const DeepCollectionEquality().hash(categoryIds) ^
      const DeepCollectionEquality().hash(tagIds) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      runtimeType.hashCode;
}

extension $BookAppRequestExtension on BookAppRequest {
  BookAppRequest copyWith(
      {String? title,
      int? authorId,
      int? publisherId,
      int? publicationYear,
      String? isbn,
      double? price,
      String? description,
      String? resourceType,
      String? language,
      int? pageCount,
      String? excerpt,
      String? authorEvaluation,
      int? readingTime,
      int? numberOfChapters,
      List<int>? categoryIds,
      List<int>? tagIds,
      int? ageAverage}) {
    return BookAppRequest(
        title: title ?? this.title,
        authorId: authorId ?? this.authorId,
        publisherId: publisherId ?? this.publisherId,
        publicationYear: publicationYear ?? this.publicationYear,
        isbn: isbn ?? this.isbn,
        price: price ?? this.price,
        description: description ?? this.description,
        resourceType: resourceType ?? this.resourceType,
        language: language ?? this.language,
        pageCount: pageCount ?? this.pageCount,
        excerpt: excerpt ?? this.excerpt,
        authorEvaluation: authorEvaluation ?? this.authorEvaluation,
        readingTime: readingTime ?? this.readingTime,
        numberOfChapters: numberOfChapters ?? this.numberOfChapters,
        categoryIds: categoryIds ?? this.categoryIds,
        tagIds: tagIds ?? this.tagIds,
        ageAverage: ageAverage ?? this.ageAverage);
  }

  BookAppRequest copyWithWrapped(
      {Wrapped<String?>? title,
      Wrapped<int?>? authorId,
      Wrapped<int?>? publisherId,
      Wrapped<int?>? publicationYear,
      Wrapped<String?>? isbn,
      Wrapped<double?>? price,
      Wrapped<String?>? description,
      Wrapped<String?>? resourceType,
      Wrapped<String?>? language,
      Wrapped<int?>? pageCount,
      Wrapped<String?>? excerpt,
      Wrapped<String?>? authorEvaluation,
      Wrapped<int?>? readingTime,
      Wrapped<int?>? numberOfChapters,
      Wrapped<List<int>?>? categoryIds,
      Wrapped<List<int>?>? tagIds,
      Wrapped<int?>? ageAverage}) {
    return BookAppRequest(
        title: (title != null ? title.value : this.title),
        authorId: (authorId != null ? authorId.value : this.authorId),
        publisherId:
            (publisherId != null ? publisherId.value : this.publisherId),
        publicationYear: (publicationYear != null
            ? publicationYear.value
            : this.publicationYear),
        isbn: (isbn != null ? isbn.value : this.isbn),
        price: (price != null ? price.value : this.price),
        description:
            (description != null ? description.value : this.description),
        resourceType:
            (resourceType != null ? resourceType.value : this.resourceType),
        language: (language != null ? language.value : this.language),
        pageCount: (pageCount != null ? pageCount.value : this.pageCount),
        excerpt: (excerpt != null ? excerpt.value : this.excerpt),
        authorEvaluation: (authorEvaluation != null
            ? authorEvaluation.value
            : this.authorEvaluation),
        readingTime:
            (readingTime != null ? readingTime.value : this.readingTime),
        numberOfChapters: (numberOfChapters != null
            ? numberOfChapters.value
            : this.numberOfChapters),
        categoryIds:
            (categoryIds != null ? categoryIds.value : this.categoryIds),
        tagIds: (tagIds != null ? tagIds.value : this.tagIds),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage));
  }
}

@JsonSerializable(explicitToJson: true)
class BookChapterGoogleDriveRequest {
  const BookChapterGoogleDriveRequest({
    this.fileId,
    this.accessToken,
    this.bookId,
    this.title,
    this.chapterNumber,
    this.format,
    this.isEncrypted,
  });

  factory BookChapterGoogleDriveRequest.fromJson(Map<String, dynamic> json) =>
      _$BookChapterGoogleDriveRequestFromJson(json);

  static const toJsonFactory = _$BookChapterGoogleDriveRequestToJson;
  Map<String, dynamic> toJson() => _$BookChapterGoogleDriveRequestToJson(this);

  @JsonKey(name: 'fileId', includeIfNull: false)
  final String? fileId;
  @JsonKey(name: 'accessToken', includeIfNull: false)
  final String? accessToken;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'chapterNumber', includeIfNull: false)
  final int? chapterNumber;
  @JsonKey(name: 'format', includeIfNull: false)
  final String? format;
  @JsonKey(name: 'isEncrypted', includeIfNull: false)
  final int? isEncrypted;
  static const fromJsonFactory = _$BookChapterGoogleDriveRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookChapterGoogleDriveRequest &&
            (identical(other.fileId, fileId) ||
                const DeepCollectionEquality().equals(other.fileId, fileId)) &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality()
                    .equals(other.accessToken, accessToken)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.chapterNumber, chapterNumber) ||
                const DeepCollectionEquality()
                    .equals(other.chapterNumber, chapterNumber)) &&
            (identical(other.format, format) ||
                const DeepCollectionEquality().equals(other.format, format)) &&
            (identical(other.isEncrypted, isEncrypted) ||
                const DeepCollectionEquality()
                    .equals(other.isEncrypted, isEncrypted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(fileId) ^
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(chapterNumber) ^
      const DeepCollectionEquality().hash(format) ^
      const DeepCollectionEquality().hash(isEncrypted) ^
      runtimeType.hashCode;
}

extension $BookChapterGoogleDriveRequestExtension
    on BookChapterGoogleDriveRequest {
  BookChapterGoogleDriveRequest copyWith(
      {String? fileId,
      String? accessToken,
      int? bookId,
      String? title,
      int? chapterNumber,
      String? format,
      int? isEncrypted}) {
    return BookChapterGoogleDriveRequest(
        fileId: fileId ?? this.fileId,
        accessToken: accessToken ?? this.accessToken,
        bookId: bookId ?? this.bookId,
        title: title ?? this.title,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        format: format ?? this.format,
        isEncrypted: isEncrypted ?? this.isEncrypted);
  }

  BookChapterGoogleDriveRequest copyWithWrapped(
      {Wrapped<String?>? fileId,
      Wrapped<String?>? accessToken,
      Wrapped<int?>? bookId,
      Wrapped<String?>? title,
      Wrapped<int?>? chapterNumber,
      Wrapped<String?>? format,
      Wrapped<int?>? isEncrypted}) {
    return BookChapterGoogleDriveRequest(
        fileId: (fileId != null ? fileId.value : this.fileId),
        accessToken:
            (accessToken != null ? accessToken.value : this.accessToken),
        bookId: (bookId != null ? bookId.value : this.bookId),
        title: (title != null ? title.value : this.title),
        chapterNumber:
            (chapterNumber != null ? chapterNumber.value : this.chapterNumber),
        format: (format != null ? format.value : this.format),
        isEncrypted:
            (isEncrypted != null ? isEncrypted.value : this.isEncrypted));
  }
}

@JsonSerializable(explicitToJson: true)
class BookCommentRequest {
  const BookCommentRequest({
    this.bookId,
    this.commentText,
  });

  factory BookCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$BookCommentRequestFromJson(json);

  static const toJsonFactory = _$BookCommentRequestToJson;
  Map<String, dynamic> toJson() => _$BookCommentRequestToJson(this);

  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'commentText', includeIfNull: false)
  final String? commentText;
  static const fromJsonFactory = _$BookCommentRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookCommentRequest &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.commentText, commentText) ||
                const DeepCollectionEquality()
                    .equals(other.commentText, commentText)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(commentText) ^
      runtimeType.hashCode;
}

extension $BookCommentRequestExtension on BookCommentRequest {
  BookCommentRequest copyWith({int? bookId, String? commentText}) {
    return BookCommentRequest(
        bookId: bookId ?? this.bookId,
        commentText: commentText ?? this.commentText);
  }

  BookCommentRequest copyWithWrapped(
      {Wrapped<int?>? bookId, Wrapped<String?>? commentText}) {
    return BookCommentRequest(
        bookId: (bookId != null ? bookId.value : this.bookId),
        commentText:
            (commentText != null ? commentText.value : this.commentText));
  }
}

@JsonSerializable(explicitToJson: true)
class BookReviewRequest {
  const BookReviewRequest({
    this.bookId,
    this.rating,
    this.reviewText,
  });

  factory BookReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$BookReviewRequestFromJson(json);

  static const toJsonFactory = _$BookReviewRequestToJson;
  Map<String, dynamic> toJson() => _$BookReviewRequestToJson(this);

  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'rating', includeIfNull: false)
  final int? rating;
  @JsonKey(name: 'reviewText', includeIfNull: false)
  final String? reviewText;
  static const fromJsonFactory = _$BookReviewRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookReviewRequest &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.reviewText, reviewText) ||
                const DeepCollectionEquality()
                    .equals(other.reviewText, reviewText)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(reviewText) ^
      runtimeType.hashCode;
}

extension $BookReviewRequestExtension on BookReviewRequest {
  BookReviewRequest copyWith({int? bookId, int? rating, String? reviewText}) {
    return BookReviewRequest(
        bookId: bookId ?? this.bookId,
        rating: rating ?? this.rating,
        reviewText: reviewText ?? this.reviewText);
  }

  BookReviewRequest copyWithWrapped(
      {Wrapped<int?>? bookId,
      Wrapped<int?>? rating,
      Wrapped<String?>? reviewText}) {
    return BookReviewRequest(
        bookId: (bookId != null ? bookId.value : this.bookId),
        rating: (rating != null ? rating.value : this.rating),
        reviewText: (reviewText != null ? reviewText.value : this.reviewText));
  }
}

@JsonSerializable(explicitToJson: true)
class BookmarkAppRequest {
  const BookmarkAppRequest({
    this.bookId,
    this.chapterId,
    this.title,
    this.position,
    this.isBook,
  });

  factory BookmarkAppRequest.fromJson(Map<String, dynamic> json) =>
      _$BookmarkAppRequestFromJson(json);

  static const toJsonFactory = _$BookmarkAppRequestToJson;
  Map<String, dynamic> toJson() => _$BookmarkAppRequestToJson(this);

  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'chapterId', includeIfNull: false)
  final int? chapterId;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'position', includeIfNull: false)
  final int? position;
  @JsonKey(name: 'isBook', includeIfNull: false)
  final bool? isBook;
  static const fromJsonFactory = _$BookmarkAppRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookmarkAppRequest &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.chapterId, chapterId) ||
                const DeepCollectionEquality()
                    .equals(other.chapterId, chapterId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)) &&
            (identical(other.isBook, isBook) ||
                const DeepCollectionEquality().equals(other.isBook, isBook)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(chapterId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(position) ^
      const DeepCollectionEquality().hash(isBook) ^
      runtimeType.hashCode;
}

extension $BookmarkAppRequestExtension on BookmarkAppRequest {
  BookmarkAppRequest copyWith(
      {int? bookId,
      int? chapterId,
      String? title,
      int? position,
      bool? isBook}) {
    return BookmarkAppRequest(
        bookId: bookId ?? this.bookId,
        chapterId: chapterId ?? this.chapterId,
        title: title ?? this.title,
        position: position ?? this.position,
        isBook: isBook ?? this.isBook);
  }

  BookmarkAppRequest copyWithWrapped(
      {Wrapped<int?>? bookId,
      Wrapped<int?>? chapterId,
      Wrapped<String?>? title,
      Wrapped<int?>? position,
      Wrapped<bool?>? isBook}) {
    return BookmarkAppRequest(
        bookId: (bookId != null ? bookId.value : this.bookId),
        chapterId: (chapterId != null ? chapterId.value : this.chapterId),
        title: (title != null ? title.value : this.title),
        position: (position != null ? position.value : this.position),
        isBook: (isBook != null ? isBook.value : this.isBook));
  }
}

@JsonSerializable(explicitToJson: true)
class PaginatedResult {
  const PaginatedResult({
    this.items,
    this.totalCount,
    this.page,
    this.limit,
  });

  factory PaginatedResult.fromJson(Map<String, dynamic> json) =>
      _$PaginatedResultFromJson(json);

  static const toJsonFactory = _$PaginatedResultToJson;
  Map<String, dynamic> toJson() => _$PaginatedResultToJson(this);

  @JsonKey(name: 'items', includeIfNull: false, defaultValue: <Object>[])
  final List<Object>? items;
  @JsonKey(name: 'totalCount', includeIfNull: false)
  final int? totalCount;
  @JsonKey(name: 'page', includeIfNull: false)
  final int? page;
  @JsonKey(name: 'limit', includeIfNull: false)
  final int? limit;
  static const fromJsonFactory = _$PaginatedResultFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaginatedResult &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.totalCount, totalCount) ||
                const DeepCollectionEquality()
                    .equals(other.totalCount, totalCount)) &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(totalCount) ^
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(limit) ^
      runtimeType.hashCode;
}

extension $PaginatedResultExtension on PaginatedResult {
  PaginatedResult copyWith(
      {List<Object>? items, int? totalCount, int? page, int? limit}) {
    return PaginatedResult(
        items: items ?? this.items,
        totalCount: totalCount ?? this.totalCount,
        page: page ?? this.page,
        limit: limit ?? this.limit);
  }

  PaginatedResult copyWithWrapped(
      {Wrapped<List<Object>?>? items,
      Wrapped<int?>? totalCount,
      Wrapped<int?>? page,
      Wrapped<int?>? limit}) {
    return PaginatedResult(
        items: (items != null ? items.value : this.items),
        totalCount: (totalCount != null ? totalCount.value : this.totalCount),
        page: (page != null ? page.value : this.page),
        limit: (limit != null ? limit.value : this.limit));
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryAppResponse {
  const CategoryAppResponse({
    this.id,
    this.name,
    this.books,
  });

  factory CategoryAppResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryAppResponseFromJson(json);

  static const toJsonFactory = _$CategoryAppResponseToJson;
  Map<String, dynamic> toJson() => _$CategoryAppResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(
      name: 'books',
      includeIfNull: false,
      defaultValue: <RetrieveBookByCategoryIdResponse>[])
  final List<RetrieveBookByCategoryIdResponse>? books;
  static const fromJsonFactory = _$CategoryAppResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CategoryAppResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.books, books) ||
                const DeepCollectionEquality().equals(other.books, books)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(books) ^
      runtimeType.hashCode;
}

extension $CategoryAppResponseExtension on CategoryAppResponse {
  CategoryAppResponse copyWith(
      {int? id, String? name, List<RetrieveBookByCategoryIdResponse>? books}) {
    return CategoryAppResponse(
        id: id ?? this.id, name: name ?? this.name, books: books ?? this.books);
  }

  CategoryAppResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? name,
      Wrapped<List<RetrieveBookByCategoryIdResponse>?>? books}) {
    return CategoryAppResponse(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        books: (books != null ? books.value : this.books));
  }
}

@JsonSerializable(explicitToJson: true)
class RetrieveBookByCategoryIdResponse {
  const RetrieveBookByCategoryIdResponse({
    this.id,
    this.title,
    this.author,
    this.publisher,
    this.publicationYear,
    this.isbn,
    this.price,
    this.description,
    this.resourceType,
    this.language,
    this.pageCount,
    this.tags,
    this.imageUrl,
    this.categories,
    this.ageAverage,
  });

  factory RetrieveBookByCategoryIdResponse.fromJson(
          Map<String, dynamic> json) =>
      _$RetrieveBookByCategoryIdResponseFromJson(json);

  static const toJsonFactory = _$RetrieveBookByCategoryIdResponseToJson;
  Map<String, dynamic> toJson() =>
      _$RetrieveBookByCategoryIdResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'author', includeIfNull: false)
  final Author? author;
  @JsonKey(name: 'publisher', includeIfNull: false)
  final Publisher? publisher;
  @JsonKey(name: 'publicationYear', includeIfNull: false)
  final int? publicationYear;
  @JsonKey(name: 'isbn', includeIfNull: false)
  final String? isbn;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'resourceType', includeIfNull: false)
  final String? resourceType;
  @JsonKey(name: 'language', includeIfNull: false)
  final String? language;
  @JsonKey(name: 'pageCount', includeIfNull: false)
  final int? pageCount;
  @JsonKey(name: 'tags', includeIfNull: false)
  final String? tags;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'categories', includeIfNull: false)
  final String? categories;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  static const fromJsonFactory = _$RetrieveBookByCategoryIdResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RetrieveBookByCategoryIdResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.publicationYear, publicationYear) ||
                const DeepCollectionEquality()
                    .equals(other.publicationYear, publicationYear)) &&
            (identical(other.isbn, isbn) ||
                const DeepCollectionEquality().equals(other.isbn, isbn)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.resourceType, resourceType) ||
                const DeepCollectionEquality()
                    .equals(other.resourceType, resourceType)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.pageCount, pageCount) ||
                const DeepCollectionEquality()
                    .equals(other.pageCount, pageCount)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(publicationYear) ^
      const DeepCollectionEquality().hash(isbn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(resourceType) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(pageCount) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      runtimeType.hashCode;
}

extension $RetrieveBookByCategoryIdResponseExtension
    on RetrieveBookByCategoryIdResponse {
  RetrieveBookByCategoryIdResponse copyWith(
      {int? id,
      String? title,
      Author? author,
      Publisher? publisher,
      int? publicationYear,
      String? isbn,
      double? price,
      String? description,
      String? resourceType,
      String? language,
      int? pageCount,
      String? tags,
      String? imageUrl,
      String? categories,
      int? ageAverage}) {
    return RetrieveBookByCategoryIdResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        publisher: publisher ?? this.publisher,
        publicationYear: publicationYear ?? this.publicationYear,
        isbn: isbn ?? this.isbn,
        price: price ?? this.price,
        description: description ?? this.description,
        resourceType: resourceType ?? this.resourceType,
        language: language ?? this.language,
        pageCount: pageCount ?? this.pageCount,
        tags: tags ?? this.tags,
        imageUrl: imageUrl ?? this.imageUrl,
        categories: categories ?? this.categories,
        ageAverage: ageAverage ?? this.ageAverage);
  }

  RetrieveBookByCategoryIdResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? title,
      Wrapped<Author?>? author,
      Wrapped<Publisher?>? publisher,
      Wrapped<int?>? publicationYear,
      Wrapped<String?>? isbn,
      Wrapped<double?>? price,
      Wrapped<String?>? description,
      Wrapped<String?>? resourceType,
      Wrapped<String?>? language,
      Wrapped<int?>? pageCount,
      Wrapped<String?>? tags,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? categories,
      Wrapped<int?>? ageAverage}) {
    return RetrieveBookByCategoryIdResponse(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        author: (author != null ? author.value : this.author),
        publisher: (publisher != null ? publisher.value : this.publisher),
        publicationYear: (publicationYear != null
            ? publicationYear.value
            : this.publicationYear),
        isbn: (isbn != null ? isbn.value : this.isbn),
        price: (price != null ? price.value : this.price),
        description:
            (description != null ? description.value : this.description),
        resourceType:
            (resourceType != null ? resourceType.value : this.resourceType),
        language: (language != null ? language.value : this.language),
        pageCount: (pageCount != null ? pageCount.value : this.pageCount),
        tags: (tags != null ? tags.value : this.tags),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        categories: (categories != null ? categories.value : this.categories),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage));
  }
}

@JsonSerializable(explicitToJson: true)
class FileUploadFormRequest {
  const FileUploadFormRequest({
    this.fileData,
    this.fileName,
    this.fileType,
  });

  factory FileUploadFormRequest.fromJson(Map<String, dynamic> json) =>
      _$FileUploadFormRequestFromJson(json);

  static const toJsonFactory = _$FileUploadFormRequestToJson;
  Map<String, dynamic> toJson() => _$FileUploadFormRequestToJson(this);

  @JsonKey(name: 'fileData', includeIfNull: false)
  final String? fileData;
  @JsonKey(name: 'fileName', includeIfNull: false)
  final String? fileName;
  @JsonKey(name: 'fileType', includeIfNull: false)
  final String? fileType;
  static const fromJsonFactory = _$FileUploadFormRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FileUploadFormRequest &&
            (identical(other.fileData, fileData) ||
                const DeepCollectionEquality()
                    .equals(other.fileData, fileData)) &&
            (identical(other.fileName, fileName) ||
                const DeepCollectionEquality()
                    .equals(other.fileName, fileName)) &&
            (identical(other.fileType, fileType) ||
                const DeepCollectionEquality()
                    .equals(other.fileType, fileType)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(fileData) ^
      const DeepCollectionEquality().hash(fileName) ^
      const DeepCollectionEquality().hash(fileType) ^
      runtimeType.hashCode;
}

extension $FileUploadFormRequestExtension on FileUploadFormRequest {
  FileUploadFormRequest copyWith(
      {String? fileData, String? fileName, String? fileType}) {
    return FileUploadFormRequest(
        fileData: fileData ?? this.fileData,
        fileName: fileName ?? this.fileName,
        fileType: fileType ?? this.fileType);
  }

  FileUploadFormRequest copyWithWrapped(
      {Wrapped<String?>? fileData,
      Wrapped<String?>? fileName,
      Wrapped<String?>? fileType}) {
    return FileUploadFormRequest(
        fileData: (fileData != null ? fileData.value : this.fileData),
        fileName: (fileName != null ? fileName.value : this.fileName),
        fileType: (fileType != null ? fileType.value : this.fileType));
  }
}

@JsonSerializable(explicitToJson: true)
class BookReadingResponse {
  const BookReadingResponse({
    this.progressId,
    this.userId,
    this.isCompleted,
    this.currentChapter,
    this.totalChapters,
    this.currentPage,
    this.totalPage,
    this.lastReadAt,
    this.bookId,
    this.title,
    this.ageAverage,
    this.authorId,
    this.authorName,
    this.publisherId,
    this.publisherName,
    this.price,
    this.createdAt,
    this.imageUrl,
  });

  factory BookReadingResponse.fromJson(Map<String, dynamic> json) =>
      _$BookReadingResponseFromJson(json);

  static const toJsonFactory = _$BookReadingResponseToJson;
  Map<String, dynamic> toJson() => _$BookReadingResponseToJson(this);

  @JsonKey(name: 'progressId', includeIfNull: false)
  final int? progressId;
  @JsonKey(name: 'userId', includeIfNull: false)
  final int? userId;
  @JsonKey(name: 'isCompleted', includeIfNull: false)
  final bool? isCompleted;
  @JsonKey(name: 'currentChapter', includeIfNull: false)
  final int? currentChapter;
  @JsonKey(name: 'totalChapters', includeIfNull: false)
  final int? totalChapters;
  @JsonKey(name: 'currentPage', includeIfNull: false)
  final int? currentPage;
  @JsonKey(name: 'totalPage', includeIfNull: false)
  final int? totalPage;
  @JsonKey(name: 'lastReadAt', includeIfNull: false)
  final DateTime? lastReadAt;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final double? ageAverage;
  @JsonKey(name: 'authorId', includeIfNull: false)
  final int? authorId;
  @JsonKey(name: 'authorName', includeIfNull: false)
  final String? authorName;
  @JsonKey(name: 'publisherId', includeIfNull: false)
  final int? publisherId;
  @JsonKey(name: 'publisherName', includeIfNull: false)
  final String? publisherName;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  static const fromJsonFactory = _$BookReadingResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookReadingResponse &&
            (identical(other.progressId, progressId) ||
                const DeepCollectionEquality()
                    .equals(other.progressId, progressId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.isCompleted, isCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.isCompleted, isCompleted)) &&
            (identical(other.currentChapter, currentChapter) ||
                const DeepCollectionEquality()
                    .equals(other.currentChapter, currentChapter)) &&
            (identical(other.totalChapters, totalChapters) ||
                const DeepCollectionEquality()
                    .equals(other.totalChapters, totalChapters)) &&
            (identical(other.currentPage, currentPage) ||
                const DeepCollectionEquality()
                    .equals(other.currentPage, currentPage)) &&
            (identical(other.totalPage, totalPage) ||
                const DeepCollectionEquality()
                    .equals(other.totalPage, totalPage)) &&
            (identical(other.lastReadAt, lastReadAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastReadAt, lastReadAt)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)) &&
            (identical(other.authorName, authorName) ||
                const DeepCollectionEquality()
                    .equals(other.authorName, authorName)) &&
            (identical(other.publisherId, publisherId) ||
                const DeepCollectionEquality()
                    .equals(other.publisherId, publisherId)) &&
            (identical(other.publisherName, publisherName) ||
                const DeepCollectionEquality()
                    .equals(other.publisherName, publisherName)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(progressId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(isCompleted) ^
      const DeepCollectionEquality().hash(currentChapter) ^
      const DeepCollectionEquality().hash(totalChapters) ^
      const DeepCollectionEquality().hash(currentPage) ^
      const DeepCollectionEquality().hash(totalPage) ^
      const DeepCollectionEquality().hash(lastReadAt) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      const DeepCollectionEquality().hash(authorId) ^
      const DeepCollectionEquality().hash(authorName) ^
      const DeepCollectionEquality().hash(publisherId) ^
      const DeepCollectionEquality().hash(publisherName) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      runtimeType.hashCode;
}

extension $BookReadingResponseExtension on BookReadingResponse {
  BookReadingResponse copyWith(
      {int? progressId,
      int? userId,
      bool? isCompleted,
      int? currentChapter,
      int? totalChapters,
      int? currentPage,
      int? totalPage,
      DateTime? lastReadAt,
      int? bookId,
      String? title,
      double? ageAverage,
      int? authorId,
      String? authorName,
      int? publisherId,
      String? publisherName,
      double? price,
      DateTime? createdAt,
      String? imageUrl}) {
    return BookReadingResponse(
        progressId: progressId ?? this.progressId,
        userId: userId ?? this.userId,
        isCompleted: isCompleted ?? this.isCompleted,
        currentChapter: currentChapter ?? this.currentChapter,
        totalChapters: totalChapters ?? this.totalChapters,
        currentPage: currentPage ?? this.currentPage,
        totalPage: totalPage ?? this.totalPage,
        lastReadAt: lastReadAt ?? this.lastReadAt,
        bookId: bookId ?? this.bookId,
        title: title ?? this.title,
        ageAverage: ageAverage ?? this.ageAverage,
        authorId: authorId ?? this.authorId,
        authorName: authorName ?? this.authorName,
        publisherId: publisherId ?? this.publisherId,
        publisherName: publisherName ?? this.publisherName,
        price: price ?? this.price,
        createdAt: createdAt ?? this.createdAt,
        imageUrl: imageUrl ?? this.imageUrl);
  }

  BookReadingResponse copyWithWrapped(
      {Wrapped<int?>? progressId,
      Wrapped<int?>? userId,
      Wrapped<bool?>? isCompleted,
      Wrapped<int?>? currentChapter,
      Wrapped<int?>? totalChapters,
      Wrapped<int?>? currentPage,
      Wrapped<int?>? totalPage,
      Wrapped<DateTime?>? lastReadAt,
      Wrapped<int?>? bookId,
      Wrapped<String?>? title,
      Wrapped<double?>? ageAverage,
      Wrapped<int?>? authorId,
      Wrapped<String?>? authorName,
      Wrapped<int?>? publisherId,
      Wrapped<String?>? publisherName,
      Wrapped<double?>? price,
      Wrapped<DateTime?>? createdAt,
      Wrapped<String?>? imageUrl}) {
    return BookReadingResponse(
        progressId: (progressId != null ? progressId.value : this.progressId),
        userId: (userId != null ? userId.value : this.userId),
        isCompleted:
            (isCompleted != null ? isCompleted.value : this.isCompleted),
        currentChapter: (currentChapter != null
            ? currentChapter.value
            : this.currentChapter),
        totalChapters:
            (totalChapters != null ? totalChapters.value : this.totalChapters),
        currentPage:
            (currentPage != null ? currentPage.value : this.currentPage),
        totalPage: (totalPage != null ? totalPage.value : this.totalPage),
        lastReadAt: (lastReadAt != null ? lastReadAt.value : this.lastReadAt),
        bookId: (bookId != null ? bookId.value : this.bookId),
        title: (title != null ? title.value : this.title),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage),
        authorId: (authorId != null ? authorId.value : this.authorId),
        authorName: (authorName != null ? authorName.value : this.authorName),
        publisherId:
            (publisherId != null ? publisherId.value : this.publisherId),
        publisherName:
            (publisherName != null ? publisherName.value : this.publisherName),
        price: (price != null ? price.value : this.price),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl));
  }
}

@JsonSerializable(explicitToJson: true)
class BookBestRatedResponse {
  const BookBestRatedResponse({
    this.id,
    this.title,
    this.author,
    this.publisher,
    this.price,
    this.imageUrl,
    this.averageRating,
    this.totalReviews,
    this.categories,
    this.ageAverage,
  });

  factory BookBestRatedResponse.fromJson(Map<String, dynamic> json) =>
      _$BookBestRatedResponseFromJson(json);

  static const toJsonFactory = _$BookBestRatedResponseToJson;
  Map<String, dynamic> toJson() => _$BookBestRatedResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'author', includeIfNull: false)
  final Author? author;
  @JsonKey(name: 'publisher', includeIfNull: false)
  final Publisher? publisher;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'averageRating', includeIfNull: false)
  final double? averageRating;
  @JsonKey(name: 'totalReviews', includeIfNull: false)
  final int? totalReviews;
  @JsonKey(name: 'categories', includeIfNull: false)
  final String? categories;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  static const fromJsonFactory = _$BookBestRatedResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookBestRatedResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.averageRating, averageRating) ||
                const DeepCollectionEquality()
                    .equals(other.averageRating, averageRating)) &&
            (identical(other.totalReviews, totalReviews) ||
                const DeepCollectionEquality()
                    .equals(other.totalReviews, totalReviews)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(averageRating) ^
      const DeepCollectionEquality().hash(totalReviews) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      runtimeType.hashCode;
}

extension $BookBestRatedResponseExtension on BookBestRatedResponse {
  BookBestRatedResponse copyWith(
      {int? id,
      String? title,
      Author? author,
      Publisher? publisher,
      double? price,
      String? imageUrl,
      double? averageRating,
      int? totalReviews,
      String? categories,
      int? ageAverage}) {
    return BookBestRatedResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        publisher: publisher ?? this.publisher,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        averageRating: averageRating ?? this.averageRating,
        totalReviews: totalReviews ?? this.totalReviews,
        categories: categories ?? this.categories,
        ageAverage: ageAverage ?? this.ageAverage);
  }

  BookBestRatedResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? title,
      Wrapped<Author?>? author,
      Wrapped<Publisher?>? publisher,
      Wrapped<double?>? price,
      Wrapped<String?>? imageUrl,
      Wrapped<double?>? averageRating,
      Wrapped<int?>? totalReviews,
      Wrapped<String?>? categories,
      Wrapped<int?>? ageAverage}) {
    return BookBestRatedResponse(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        author: (author != null ? author.value : this.author),
        publisher: (publisher != null ? publisher.value : this.publisher),
        price: (price != null ? price.value : this.price),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        averageRating:
            (averageRating != null ? averageRating.value : this.averageRating),
        totalReviews:
            (totalReviews != null ? totalReviews.value : this.totalReviews),
        categories: (categories != null ? categories.value : this.categories),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage));
  }
}

@JsonSerializable(explicitToJson: true)
class DiscountedBookResponse {
  const DiscountedBookResponse({
    this.id,
    this.title,
    this.discountPercentage,
    this.author,
    this.publisher,
    this.price,
    this.imageUrl,
    this.categories,
    this.ageAverage,
  });

  factory DiscountedBookResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscountedBookResponseFromJson(json);

  static const toJsonFactory = _$DiscountedBookResponseToJson;
  Map<String, dynamic> toJson() => _$DiscountedBookResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'discountPercentage', includeIfNull: false)
  final double? discountPercentage;
  @JsonKey(name: 'author', includeIfNull: false)
  final Author? author;
  @JsonKey(name: 'publisher', includeIfNull: false)
  final Publisher? publisher;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'categories', includeIfNull: false)
  final String? categories;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  static const fromJsonFactory = _$DiscountedBookResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscountedBookResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.discountPercentage, discountPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.discountPercentage, discountPercentage)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(discountPercentage) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      runtimeType.hashCode;
}

extension $DiscountedBookResponseExtension on DiscountedBookResponse {
  DiscountedBookResponse copyWith(
      {int? id,
      String? title,
      double? discountPercentage,
      Author? author,
      Publisher? publisher,
      double? price,
      String? imageUrl,
      String? categories,
      int? ageAverage}) {
    return DiscountedBookResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        author: author ?? this.author,
        publisher: publisher ?? this.publisher,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        categories: categories ?? this.categories,
        ageAverage: ageAverage ?? this.ageAverage);
  }

  DiscountedBookResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? title,
      Wrapped<double?>? discountPercentage,
      Wrapped<Author?>? author,
      Wrapped<Publisher?>? publisher,
      Wrapped<double?>? price,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? categories,
      Wrapped<int?>? ageAverage}) {
    return DiscountedBookResponse(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        discountPercentage: (discountPercentage != null
            ? discountPercentage.value
            : this.discountPercentage),
        author: (author != null ? author.value : this.author),
        publisher: (publisher != null ? publisher.value : this.publisher),
        price: (price != null ? price.value : this.price),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        categories: (categories != null ? categories.value : this.categories),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage));
  }
}

@JsonSerializable(explicitToJson: true)
class DynamicContent {
  const DynamicContent({
    this.id,
    this.contentType,
    this.title,
    this.content,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deleted,
  });

  factory DynamicContent.fromJson(Map<String, dynamic> json) =>
      _$DynamicContentFromJson(json);

  static const toJsonFactory = _$DynamicContentToJson;
  Map<String, dynamic> toJson() => _$DynamicContentToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'contentType', includeIfNull: false)
  final String? contentType;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'content', includeIfNull: false)
  final String? content;
  @JsonKey(name: 'isActive', includeIfNull: false)
  final bool? isActive;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  static const fromJsonFactory = _$DynamicContentFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DynamicContent &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.contentType, contentType) ||
                const DeepCollectionEquality()
                    .equals(other.contentType, contentType)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality().equals(other.deleted, deleted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(contentType) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(deleted) ^
      runtimeType.hashCode;
}

extension $DynamicContentExtension on DynamicContent {
  DynamicContent copyWith(
      {int? id,
      String? contentType,
      String? title,
      String? content,
      bool? isActive,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? deleted}) {
    return DynamicContent(
        id: id ?? this.id,
        contentType: contentType ?? this.contentType,
        title: title ?? this.title,
        content: content ?? this.content,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted);
  }

  DynamicContent copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? contentType,
      Wrapped<String?>? title,
      Wrapped<String?>? content,
      Wrapped<bool?>? isActive,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? deleted}) {
    return DynamicContent(
        id: (id != null ? id.value : this.id),
        contentType:
            (contentType != null ? contentType.value : this.contentType),
        title: (title != null ? title.value : this.title),
        content: (content != null ? content.value : this.content),
        isActive: (isActive != null ? isActive.value : this.isActive),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        deleted: (deleted != null ? deleted.value : this.deleted));
  }
}

@JsonSerializable(explicitToJson: true)
class BookMostOrderedResponse {
  const BookMostOrderedResponse({
    this.id,
    this.title,
    this.author,
    this.publisher,
    this.publicationYear,
    this.isbn,
    this.price,
    this.description,
    this.resourceType,
    this.language,
    this.pageCount,
    this.tags,
    this.imageUrl,
    this.categories,
    this.ageAverage,
  });

  factory BookMostOrderedResponse.fromJson(Map<String, dynamic> json) =>
      _$BookMostOrderedResponseFromJson(json);

  static const toJsonFactory = _$BookMostOrderedResponseToJson;
  Map<String, dynamic> toJson() => _$BookMostOrderedResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'author', includeIfNull: false)
  final Author? author;
  @JsonKey(name: 'publisher', includeIfNull: false)
  final Publisher? publisher;
  @JsonKey(name: 'publicationYear', includeIfNull: false)
  final int? publicationYear;
  @JsonKey(name: 'isbn', includeIfNull: false)
  final String? isbn;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'resourceType', includeIfNull: false)
  final String? resourceType;
  @JsonKey(name: 'language', includeIfNull: false)
  final String? language;
  @JsonKey(name: 'pageCount', includeIfNull: false)
  final int? pageCount;
  @JsonKey(name: 'tags', includeIfNull: false)
  final String? tags;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'categories', includeIfNull: false)
  final String? categories;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  static const fromJsonFactory = _$BookMostOrderedResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookMostOrderedResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.publicationYear, publicationYear) ||
                const DeepCollectionEquality()
                    .equals(other.publicationYear, publicationYear)) &&
            (identical(other.isbn, isbn) ||
                const DeepCollectionEquality().equals(other.isbn, isbn)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.resourceType, resourceType) ||
                const DeepCollectionEquality()
                    .equals(other.resourceType, resourceType)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.pageCount, pageCount) ||
                const DeepCollectionEquality()
                    .equals(other.pageCount, pageCount)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(publicationYear) ^
      const DeepCollectionEquality().hash(isbn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(resourceType) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(pageCount) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      runtimeType.hashCode;
}

extension $BookMostOrderedResponseExtension on BookMostOrderedResponse {
  BookMostOrderedResponse copyWith(
      {int? id,
      String? title,
      Author? author,
      Publisher? publisher,
      int? publicationYear,
      String? isbn,
      double? price,
      String? description,
      String? resourceType,
      String? language,
      int? pageCount,
      String? tags,
      String? imageUrl,
      String? categories,
      int? ageAverage}) {
    return BookMostOrderedResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        publisher: publisher ?? this.publisher,
        publicationYear: publicationYear ?? this.publicationYear,
        isbn: isbn ?? this.isbn,
        price: price ?? this.price,
        description: description ?? this.description,
        resourceType: resourceType ?? this.resourceType,
        language: language ?? this.language,
        pageCount: pageCount ?? this.pageCount,
        tags: tags ?? this.tags,
        imageUrl: imageUrl ?? this.imageUrl,
        categories: categories ?? this.categories,
        ageAverage: ageAverage ?? this.ageAverage);
  }

  BookMostOrderedResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? title,
      Wrapped<Author?>? author,
      Wrapped<Publisher?>? publisher,
      Wrapped<int?>? publicationYear,
      Wrapped<String?>? isbn,
      Wrapped<double?>? price,
      Wrapped<String?>? description,
      Wrapped<String?>? resourceType,
      Wrapped<String?>? language,
      Wrapped<int?>? pageCount,
      Wrapped<String?>? tags,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? categories,
      Wrapped<int?>? ageAverage}) {
    return BookMostOrderedResponse(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        author: (author != null ? author.value : this.author),
        publisher: (publisher != null ? publisher.value : this.publisher),
        publicationYear: (publicationYear != null
            ? publicationYear.value
            : this.publicationYear),
        isbn: (isbn != null ? isbn.value : this.isbn),
        price: (price != null ? price.value : this.price),
        description:
            (description != null ? description.value : this.description),
        resourceType:
            (resourceType != null ? resourceType.value : this.resourceType),
        language: (language != null ? language.value : this.language),
        pageCount: (pageCount != null ? pageCount.value : this.pageCount),
        tags: (tags != null ? tags.value : this.tags),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        categories: (categories != null ? categories.value : this.categories),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage));
  }
}

@JsonSerializable(explicitToJson: true)
class BookMostPopularResponse {
  const BookMostPopularResponse({
    this.id,
    this.title,
    this.totalViews,
    this.imageUrl,
    this.author,
    this.publisher,
    this.price,
    this.categories,
    this.ageAverage,
  });

  factory BookMostPopularResponse.fromJson(Map<String, dynamic> json) =>
      _$BookMostPopularResponseFromJson(json);

  static const toJsonFactory = _$BookMostPopularResponseToJson;
  Map<String, dynamic> toJson() => _$BookMostPopularResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'totalViews', includeIfNull: false)
  final int? totalViews;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'author', includeIfNull: false)
  final Author? author;
  @JsonKey(name: 'publisher', includeIfNull: false)
  final Publisher? publisher;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'categories', includeIfNull: false)
  final String? categories;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  static const fromJsonFactory = _$BookMostPopularResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookMostPopularResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.totalViews, totalViews) ||
                const DeepCollectionEquality()
                    .equals(other.totalViews, totalViews)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(totalViews) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      runtimeType.hashCode;
}

extension $BookMostPopularResponseExtension on BookMostPopularResponse {
  BookMostPopularResponse copyWith(
      {int? id,
      String? title,
      int? totalViews,
      String? imageUrl,
      Author? author,
      Publisher? publisher,
      double? price,
      String? categories,
      int? ageAverage}) {
    return BookMostPopularResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        totalViews: totalViews ?? this.totalViews,
        imageUrl: imageUrl ?? this.imageUrl,
        author: author ?? this.author,
        publisher: publisher ?? this.publisher,
        price: price ?? this.price,
        categories: categories ?? this.categories,
        ageAverage: ageAverage ?? this.ageAverage);
  }

  BookMostPopularResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? title,
      Wrapped<int?>? totalViews,
      Wrapped<String?>? imageUrl,
      Wrapped<Author?>? author,
      Wrapped<Publisher?>? publisher,
      Wrapped<double?>? price,
      Wrapped<String?>? categories,
      Wrapped<int?>? ageAverage}) {
    return BookMostPopularResponse(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        totalViews: (totalViews != null ? totalViews.value : this.totalViews),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        author: (author != null ? author.value : this.author),
        publisher: (publisher != null ? publisher.value : this.publisher),
        price: (price != null ? price.value : this.price),
        categories: (categories != null ? categories.value : this.categories),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage));
  }
}

@JsonSerializable(explicitToJson: true)
class NewBookResponse {
  const NewBookResponse({
    this.id,
    this.title,
    this.createdAt,
    this.author,
    this.publisher,
    this.price,
    this.imageUrl,
    this.categories,
    this.ageAverage,
  });

  factory NewBookResponse.fromJson(Map<String, dynamic> json) =>
      _$NewBookResponseFromJson(json);

  static const toJsonFactory = _$NewBookResponseToJson;
  Map<String, dynamic> toJson() => _$NewBookResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'author', includeIfNull: false)
  final Author? author;
  @JsonKey(name: 'publisher', includeIfNull: false)
  final Publisher? publisher;
  @JsonKey(name: 'price', includeIfNull: false)
  final double? price;
  @JsonKey(name: 'imageUrl', includeIfNull: false)
  final String? imageUrl;
  @JsonKey(name: 'categories', includeIfNull: false)
  final String? categories;
  @JsonKey(name: 'ageAverage', includeIfNull: false)
  final int? ageAverage;
  static const fromJsonFactory = _$NewBookResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NewBookResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.ageAverage, ageAverage) ||
                const DeepCollectionEquality()
                    .equals(other.ageAverage, ageAverage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(ageAverage) ^
      runtimeType.hashCode;
}

extension $NewBookResponseExtension on NewBookResponse {
  NewBookResponse copyWith(
      {int? id,
      String? title,
      DateTime? createdAt,
      Author? author,
      Publisher? publisher,
      double? price,
      String? imageUrl,
      String? categories,
      int? ageAverage}) {
    return NewBookResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        author: author ?? this.author,
        publisher: publisher ?? this.publisher,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        categories: categories ?? this.categories,
        ageAverage: ageAverage ?? this.ageAverage);
  }

  NewBookResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? title,
      Wrapped<DateTime?>? createdAt,
      Wrapped<Author?>? author,
      Wrapped<Publisher?>? publisher,
      Wrapped<double?>? price,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? categories,
      Wrapped<int?>? ageAverage}) {
    return NewBookResponse(
        id: (id != null ? id.value : this.id),
        title: (title != null ? title.value : this.title),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        author: (author != null ? author.value : this.author),
        publisher: (publisher != null ? publisher.value : this.publisher),
        price: (price != null ? price.value : this.price),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        categories: (categories != null ? categories.value : this.categories),
        ageAverage: (ageAverage != null ? ageAverage.value : this.ageAverage));
  }
}

@JsonSerializable(explicitToJson: true)
class BookAdvancedSearchRequest {
  const BookAdvancedSearchRequest({
    this.searchText,
    this.sortType,
    this.starNumbers,
    this.resourceTypes,
    this.sortPriceType,
    this.authorNames,
    this.state,
    this.categories,
    this.fromPrice,
    this.toPrice,
    this.publisherNames,
    this.fromPublishYear,
    this.toPublishYear,
    this.languages,
    this.priority,
  });

  factory BookAdvancedSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$BookAdvancedSearchRequestFromJson(json);

  static const toJsonFactory = _$BookAdvancedSearchRequestToJson;
  Map<String, dynamic> toJson() => _$BookAdvancedSearchRequestToJson(this);

  @JsonKey(name: 'searchText', includeIfNull: false)
  final String? searchText;
  @JsonKey(name: 'sortType', includeIfNull: false)
  final String? sortType;
  @JsonKey(name: 'starNumbers', includeIfNull: false, defaultValue: <int>[])
  final List<int>? starNumbers;
  @JsonKey(
      name: 'resourceTypes', includeIfNull: false, defaultValue: <String>[])
  final List<String>? resourceTypes;
  @JsonKey(name: 'sortPriceType', includeIfNull: false)
  final String? sortPriceType;
  @JsonKey(name: 'authorNames', includeIfNull: false, defaultValue: <String>[])
  final List<String>? authorNames;
  @JsonKey(name: 'state', includeIfNull: false)
  final String? state;
  @JsonKey(name: 'categories', includeIfNull: false, defaultValue: <String>[])
  final List<String>? categories;
  @JsonKey(name: 'fromPrice', includeIfNull: false)
  final double? fromPrice;
  @JsonKey(name: 'toPrice', includeIfNull: false)
  final double? toPrice;
  @JsonKey(
      name: 'publisherNames', includeIfNull: false, defaultValue: <String>[])
  final List<String>? publisherNames;
  @JsonKey(name: 'fromPublishYear', includeIfNull: false)
  final int? fromPublishYear;
  @JsonKey(name: 'toPublishYear', includeIfNull: false)
  final int? toPublishYear;
  @JsonKey(name: 'languages', includeIfNull: false, defaultValue: <String>[])
  final List<String>? languages;
  @JsonKey(name: 'priority', includeIfNull: false, defaultValue: <int>[])
  final List<int>? priority;
  static const fromJsonFactory = _$BookAdvancedSearchRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookAdvancedSearchRequest &&
            (identical(other.searchText, searchText) ||
                const DeepCollectionEquality()
                    .equals(other.searchText, searchText)) &&
            (identical(other.sortType, sortType) ||
                const DeepCollectionEquality()
                    .equals(other.sortType, sortType)) &&
            (identical(other.starNumbers, starNumbers) ||
                const DeepCollectionEquality()
                    .equals(other.starNumbers, starNumbers)) &&
            (identical(other.resourceTypes, resourceTypes) ||
                const DeepCollectionEquality()
                    .equals(other.resourceTypes, resourceTypes)) &&
            (identical(other.sortPriceType, sortPriceType) ||
                const DeepCollectionEquality()
                    .equals(other.sortPriceType, sortPriceType)) &&
            (identical(other.authorNames, authorNames) ||
                const DeepCollectionEquality()
                    .equals(other.authorNames, authorNames)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.fromPrice, fromPrice) ||
                const DeepCollectionEquality()
                    .equals(other.fromPrice, fromPrice)) &&
            (identical(other.toPrice, toPrice) ||
                const DeepCollectionEquality()
                    .equals(other.toPrice, toPrice)) &&
            (identical(other.publisherNames, publisherNames) ||
                const DeepCollectionEquality()
                    .equals(other.publisherNames, publisherNames)) &&
            (identical(other.fromPublishYear, fromPublishYear) ||
                const DeepCollectionEquality()
                    .equals(other.fromPublishYear, fromPublishYear)) &&
            (identical(other.toPublishYear, toPublishYear) ||
                const DeepCollectionEquality()
                    .equals(other.toPublishYear, toPublishYear)) &&
            (identical(other.languages, languages) ||
                const DeepCollectionEquality()
                    .equals(other.languages, languages)) &&
            (identical(other.priority, priority) ||
                const DeepCollectionEquality()
                    .equals(other.priority, priority)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(searchText) ^
      const DeepCollectionEquality().hash(sortType) ^
      const DeepCollectionEquality().hash(starNumbers) ^
      const DeepCollectionEquality().hash(resourceTypes) ^
      const DeepCollectionEquality().hash(sortPriceType) ^
      const DeepCollectionEquality().hash(authorNames) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(fromPrice) ^
      const DeepCollectionEquality().hash(toPrice) ^
      const DeepCollectionEquality().hash(publisherNames) ^
      const DeepCollectionEquality().hash(fromPublishYear) ^
      const DeepCollectionEquality().hash(toPublishYear) ^
      const DeepCollectionEquality().hash(languages) ^
      const DeepCollectionEquality().hash(priority) ^
      runtimeType.hashCode;
}

extension $BookAdvancedSearchRequestExtension on BookAdvancedSearchRequest {
  BookAdvancedSearchRequest copyWith(
      {String? searchText,
      String? sortType,
      List<int>? starNumbers,
      List<String>? resourceTypes,
      String? sortPriceType,
      List<String>? authorNames,
      String? state,
      List<String>? categories,
      double? fromPrice,
      double? toPrice,
      List<String>? publisherNames,
      int? fromPublishYear,
      int? toPublishYear,
      List<String>? languages,
      List<int>? priority}) {
    return BookAdvancedSearchRequest(
        searchText: searchText ?? this.searchText,
        sortType: sortType ?? this.sortType,
        starNumbers: starNumbers ?? this.starNumbers,
        resourceTypes: resourceTypes ?? this.resourceTypes,
        sortPriceType: sortPriceType ?? this.sortPriceType,
        authorNames: authorNames ?? this.authorNames,
        state: state ?? this.state,
        categories: categories ?? this.categories,
        fromPrice: fromPrice ?? this.fromPrice,
        toPrice: toPrice ?? this.toPrice,
        publisherNames: publisherNames ?? this.publisherNames,
        fromPublishYear: fromPublishYear ?? this.fromPublishYear,
        toPublishYear: toPublishYear ?? this.toPublishYear,
        languages: languages ?? this.languages,
        priority: priority ?? this.priority);
  }

  BookAdvancedSearchRequest copyWithWrapped(
      {Wrapped<String?>? searchText,
      Wrapped<String?>? sortType,
      Wrapped<List<int>?>? starNumbers,
      Wrapped<List<String>?>? resourceTypes,
      Wrapped<String?>? sortPriceType,
      Wrapped<List<String>?>? authorNames,
      Wrapped<String?>? state,
      Wrapped<List<String>?>? categories,
      Wrapped<double?>? fromPrice,
      Wrapped<double?>? toPrice,
      Wrapped<List<String>?>? publisherNames,
      Wrapped<int?>? fromPublishYear,
      Wrapped<int?>? toPublishYear,
      Wrapped<List<String>?>? languages,
      Wrapped<List<int>?>? priority}) {
    return BookAdvancedSearchRequest(
        searchText: (searchText != null ? searchText.value : this.searchText),
        sortType: (sortType != null ? sortType.value : this.sortType),
        starNumbers:
            (starNumbers != null ? starNumbers.value : this.starNumbers),
        resourceTypes:
            (resourceTypes != null ? resourceTypes.value : this.resourceTypes),
        sortPriceType:
            (sortPriceType != null ? sortPriceType.value : this.sortPriceType),
        authorNames:
            (authorNames != null ? authorNames.value : this.authorNames),
        state: (state != null ? state.value : this.state),
        categories: (categories != null ? categories.value : this.categories),
        fromPrice: (fromPrice != null ? fromPrice.value : this.fromPrice),
        toPrice: (toPrice != null ? toPrice.value : this.toPrice),
        publisherNames: (publisherNames != null
            ? publisherNames.value
            : this.publisherNames),
        fromPublishYear: (fromPublishYear != null
            ? fromPublishYear.value
            : this.fromPublishYear),
        toPublishYear:
            (toPublishYear != null ? toPublishYear.value : this.toPublishYear),
        languages: (languages != null ? languages.value : this.languages),
        priority: (priority != null ? priority.value : this.priority));
  }
}

@JsonSerializable(explicitToJson: true)
class UserReadingProgressAppRequest {
  const UserReadingProgressAppRequest({
    this.bookId,
    this.currentChapter,
    this.totalChapters,
    this.currentPage,
    this.totalPage,
  });

  factory UserReadingProgressAppRequest.fromJson(Map<String, dynamic> json) =>
      _$UserReadingProgressAppRequestFromJson(json);

  static const toJsonFactory = _$UserReadingProgressAppRequestToJson;
  Map<String, dynamic> toJson() => _$UserReadingProgressAppRequestToJson(this);

  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'currentChapter', includeIfNull: false)
  final int? currentChapter;
  @JsonKey(name: 'totalChapters', includeIfNull: false)
  final int? totalChapters;
  @JsonKey(name: 'currentPage', includeIfNull: false)
  final int? currentPage;
  @JsonKey(name: 'totalPage', includeIfNull: false)
  final int? totalPage;
  static const fromJsonFactory = _$UserReadingProgressAppRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserReadingProgressAppRequest &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.currentChapter, currentChapter) ||
                const DeepCollectionEquality()
                    .equals(other.currentChapter, currentChapter)) &&
            (identical(other.totalChapters, totalChapters) ||
                const DeepCollectionEquality()
                    .equals(other.totalChapters, totalChapters)) &&
            (identical(other.currentPage, currentPage) ||
                const DeepCollectionEquality()
                    .equals(other.currentPage, currentPage)) &&
            (identical(other.totalPage, totalPage) ||
                const DeepCollectionEquality()
                    .equals(other.totalPage, totalPage)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(currentChapter) ^
      const DeepCollectionEquality().hash(totalChapters) ^
      const DeepCollectionEquality().hash(currentPage) ^
      const DeepCollectionEquality().hash(totalPage) ^
      runtimeType.hashCode;
}

extension $UserReadingProgressAppRequestExtension
    on UserReadingProgressAppRequest {
  UserReadingProgressAppRequest copyWith(
      {int? bookId,
      int? currentChapter,
      int? totalChapters,
      int? currentPage,
      int? totalPage}) {
    return UserReadingProgressAppRequest(
        bookId: bookId ?? this.bookId,
        currentChapter: currentChapter ?? this.currentChapter,
        totalChapters: totalChapters ?? this.totalChapters,
        currentPage: currentPage ?? this.currentPage,
        totalPage: totalPage ?? this.totalPage);
  }

  UserReadingProgressAppRequest copyWithWrapped(
      {Wrapped<int?>? bookId,
      Wrapped<int?>? currentChapter,
      Wrapped<int?>? totalChapters,
      Wrapped<int?>? currentPage,
      Wrapped<int?>? totalPage}) {
    return UserReadingProgressAppRequest(
        bookId: (bookId != null ? bookId.value : this.bookId),
        currentChapter: (currentChapter != null
            ? currentChapter.value
            : this.currentChapter),
        totalChapters:
            (totalChapters != null ? totalChapters.value : this.totalChapters),
        currentPage:
            (currentPage != null ? currentPage.value : this.currentPage),
        totalPage: (totalPage != null ? totalPage.value : this.totalPage));
  }
}

@JsonSerializable(explicitToJson: true)
class UserReadingProgress {
  const UserReadingProgress({
    this.id,
    this.userId,
    this.bookId,
    this.isCompleted,
    this.currentChapter,
    this.totalChapters,
    this.currentPage,
    this.totalPage,
    this.lastReadAt,
  });

  factory UserReadingProgress.fromJson(Map<String, dynamic> json) =>
      _$UserReadingProgressFromJson(json);

  static const toJsonFactory = _$UserReadingProgressToJson;
  Map<String, dynamic> toJson() => _$UserReadingProgressToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'userId', includeIfNull: false)
  final int? userId;
  @JsonKey(name: 'bookId', includeIfNull: false)
  final int? bookId;
  @JsonKey(name: 'isCompleted', includeIfNull: false)
  final bool? isCompleted;
  @JsonKey(name: 'currentChapter', includeIfNull: false)
  final int? currentChapter;
  @JsonKey(name: 'totalChapters', includeIfNull: false)
  final int? totalChapters;
  @JsonKey(name: 'currentPage', includeIfNull: false)
  final int? currentPage;
  @JsonKey(name: 'totalPage', includeIfNull: false)
  final int? totalPage;
  @JsonKey(name: 'lastReadAt', includeIfNull: false)
  final DateTime? lastReadAt;
  static const fromJsonFactory = _$UserReadingProgressFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserReadingProgress &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.isCompleted, isCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.isCompleted, isCompleted)) &&
            (identical(other.currentChapter, currentChapter) ||
                const DeepCollectionEquality()
                    .equals(other.currentChapter, currentChapter)) &&
            (identical(other.totalChapters, totalChapters) ||
                const DeepCollectionEquality()
                    .equals(other.totalChapters, totalChapters)) &&
            (identical(other.currentPage, currentPage) ||
                const DeepCollectionEquality()
                    .equals(other.currentPage, currentPage)) &&
            (identical(other.totalPage, totalPage) ||
                const DeepCollectionEquality()
                    .equals(other.totalPage, totalPage)) &&
            (identical(other.lastReadAt, lastReadAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastReadAt, lastReadAt)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(isCompleted) ^
      const DeepCollectionEquality().hash(currentChapter) ^
      const DeepCollectionEquality().hash(totalChapters) ^
      const DeepCollectionEquality().hash(currentPage) ^
      const DeepCollectionEquality().hash(totalPage) ^
      const DeepCollectionEquality().hash(lastReadAt) ^
      runtimeType.hashCode;
}

extension $UserReadingProgressExtension on UserReadingProgress {
  UserReadingProgress copyWith(
      {int? id,
      int? userId,
      int? bookId,
      bool? isCompleted,
      int? currentChapter,
      int? totalChapters,
      int? currentPage,
      int? totalPage,
      DateTime? lastReadAt}) {
    return UserReadingProgress(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        bookId: bookId ?? this.bookId,
        isCompleted: isCompleted ?? this.isCompleted,
        currentChapter: currentChapter ?? this.currentChapter,
        totalChapters: totalChapters ?? this.totalChapters,
        currentPage: currentPage ?? this.currentPage,
        totalPage: totalPage ?? this.totalPage,
        lastReadAt: lastReadAt ?? this.lastReadAt);
  }

  UserReadingProgress copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<int?>? userId,
      Wrapped<int?>? bookId,
      Wrapped<bool?>? isCompleted,
      Wrapped<int?>? currentChapter,
      Wrapped<int?>? totalChapters,
      Wrapped<int?>? currentPage,
      Wrapped<int?>? totalPage,
      Wrapped<DateTime?>? lastReadAt}) {
    return UserReadingProgress(
        id: (id != null ? id.value : this.id),
        userId: (userId != null ? userId.value : this.userId),
        bookId: (bookId != null ? bookId.value : this.bookId),
        isCompleted:
            (isCompleted != null ? isCompleted.value : this.isCompleted),
        currentChapter: (currentChapter != null
            ? currentChapter.value
            : this.currentChapter),
        totalChapters:
            (totalChapters != null ? totalChapters.value : this.totalChapters),
        currentPage:
            (currentPage != null ? currentPage.value : this.currentPage),
        totalPage: (totalPage != null ? totalPage.value : this.totalPage),
        lastReadAt: (lastReadAt != null ? lastReadAt.value : this.lastReadAt));
  }
}

@JsonSerializable(explicitToJson: true)
class VoucherAppResponse {
  const VoucherAppResponse({
    this.id,
    this.code,
    this.description,
    this.discountPercentage,
    this.maxDiscountAmount,
    this.startDate,
    this.endDate,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deleted,
    this.isUsedByUser,
  });

  factory VoucherAppResponse.fromJson(Map<String, dynamic> json) =>
      _$VoucherAppResponseFromJson(json);

  static const toJsonFactory = _$VoucherAppResponseToJson;
  Map<String, dynamic> toJson() => _$VoucherAppResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'code', includeIfNull: false)
  final String? code;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'discountPercentage', includeIfNull: false)
  final double? discountPercentage;
  @JsonKey(name: 'maxDiscountAmount', includeIfNull: false)
  final double? maxDiscountAmount;
  @JsonKey(name: 'startDate', includeIfNull: false)
  final DateTime? startDate;
  @JsonKey(name: 'endDate', includeIfNull: false)
  final DateTime? endDate;
  @JsonKey(name: 'isActive', includeIfNull: false)
  final bool? isActive;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted', includeIfNull: false)
  final bool? deleted;
  @JsonKey(name: 'isUsedByUser', includeIfNull: false)
  final bool? isUsedByUser;
  static const fromJsonFactory = _$VoucherAppResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VoucherAppResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.discountPercentage, discountPercentage) ||
                const DeepCollectionEquality()
                    .equals(other.discountPercentage, discountPercentage)) &&
            (identical(other.maxDiscountAmount, maxDiscountAmount) ||
                const DeepCollectionEquality()
                    .equals(other.maxDiscountAmount, maxDiscountAmount)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality()
                    .equals(other.startDate, startDate)) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality()
                    .equals(other.endDate, endDate)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.deleted, deleted) ||
                const DeepCollectionEquality()
                    .equals(other.deleted, deleted)) &&
            (identical(other.isUsedByUser, isUsedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.isUsedByUser, isUsedByUser)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(discountPercentage) ^
      const DeepCollectionEquality().hash(maxDiscountAmount) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(deleted) ^
      const DeepCollectionEquality().hash(isUsedByUser) ^
      runtimeType.hashCode;
}

extension $VoucherAppResponseExtension on VoucherAppResponse {
  VoucherAppResponse copyWith(
      {int? id,
      String? code,
      String? description,
      double? discountPercentage,
      double? maxDiscountAmount,
      DateTime? startDate,
      DateTime? endDate,
      bool? isActive,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? deleted,
      bool? isUsedByUser}) {
    return VoucherAppResponse(
        id: id ?? this.id,
        code: code ?? this.code,
        description: description ?? this.description,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        maxDiscountAmount: maxDiscountAmount ?? this.maxDiscountAmount,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted,
        isUsedByUser: isUsedByUser ?? this.isUsedByUser);
  }

  VoucherAppResponse copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? code,
      Wrapped<String?>? description,
      Wrapped<double?>? discountPercentage,
      Wrapped<double?>? maxDiscountAmount,
      Wrapped<DateTime?>? startDate,
      Wrapped<DateTime?>? endDate,
      Wrapped<bool?>? isActive,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<bool?>? deleted,
      Wrapped<bool?>? isUsedByUser}) {
    return VoucherAppResponse(
        id: (id != null ? id.value : this.id),
        code: (code != null ? code.value : this.code),
        description:
            (description != null ? description.value : this.description),
        discountPercentage: (discountPercentage != null
            ? discountPercentage.value
            : this.discountPercentage),
        maxDiscountAmount: (maxDiscountAmount != null
            ? maxDiscountAmount.value
            : this.maxDiscountAmount),
        startDate: (startDate != null ? startDate.value : this.startDate),
        endDate: (endDate != null ? endDate.value : this.endDate),
        isActive: (isActive != null ? isActive.value : this.isActive),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        deleted: (deleted != null ? deleted.value : this.deleted),
        isUsedByUser:
            (isUsedByUser != null ? isUsedByUser.value : this.isUsedByUser));
  }
}

@JsonSerializable(explicitToJson: true)
class InputPart$Headers {
  const InputPart$Headers({
    this.empty,
  });

  factory InputPart$Headers.fromJson(Map<String, dynamic> json) =>
      _$InputPart$HeadersFromJson(json);

  static const toJsonFactory = _$InputPart$HeadersToJson;
  Map<String, dynamic> toJson() => _$InputPart$HeadersToJson(this);

  @JsonKey(name: 'empty', includeIfNull: false)
  final bool? empty;
  static const fromJsonFactory = _$InputPart$HeadersFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is InputPart$Headers &&
            (identical(other.empty, empty) ||
                const DeepCollectionEquality().equals(other.empty, empty)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(empty) ^ runtimeType.hashCode;
}

extension $InputPart$HeadersExtension on InputPart$Headers {
  InputPart$Headers copyWith({bool? empty}) {
    return InputPart$Headers(empty: empty ?? this.empty);
  }

  InputPart$Headers copyWithWrapped({Wrapped<bool?>? empty}) {
    return InputPart$Headers(empty: (empty != null ? empty.value : this.empty));
  }
}

String? publicBookRequestResponseStatusNullableToJson(
    enums.PublicBookRequestResponseStatus? publicBookRequestResponseStatus) {
  return publicBookRequestResponseStatus?.value;
}

String? publicBookRequestResponseStatusToJson(
    enums.PublicBookRequestResponseStatus publicBookRequestResponseStatus) {
  return publicBookRequestResponseStatus.value;
}

enums.PublicBookRequestResponseStatus publicBookRequestResponseStatusFromJson(
  Object? publicBookRequestResponseStatus, [
  enums.PublicBookRequestResponseStatus? defaultValue,
]) {
  return enums.PublicBookRequestResponseStatus.values.firstWhereOrNull(
          (e) => e.value == publicBookRequestResponseStatus) ??
      defaultValue ??
      enums.PublicBookRequestResponseStatus.swaggerGeneratedUnknown;
}

enums.PublicBookRequestResponseStatus?
    publicBookRequestResponseStatusNullableFromJson(
  Object? publicBookRequestResponseStatus, [
  enums.PublicBookRequestResponseStatus? defaultValue,
]) {
  if (publicBookRequestResponseStatus == null) {
    return null;
  }
  return enums.PublicBookRequestResponseStatus.values.firstWhereOrNull(
          (e) => e.value == publicBookRequestResponseStatus) ??
      defaultValue;
}

String publicBookRequestResponseStatusExplodedListToJson(
    List<enums.PublicBookRequestResponseStatus>?
        publicBookRequestResponseStatus) {
  return publicBookRequestResponseStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> publicBookRequestResponseStatusListToJson(
    List<enums.PublicBookRequestResponseStatus>?
        publicBookRequestResponseStatus) {
  if (publicBookRequestResponseStatus == null) {
    return [];
  }

  return publicBookRequestResponseStatus.map((e) => e.value!).toList();
}

List<enums.PublicBookRequestResponseStatus>
    publicBookRequestResponseStatusListFromJson(
  List? publicBookRequestResponseStatus, [
  List<enums.PublicBookRequestResponseStatus>? defaultValue,
]) {
  if (publicBookRequestResponseStatus == null) {
    return defaultValue ?? [];
  }

  return publicBookRequestResponseStatus
      .map((e) => publicBookRequestResponseStatusFromJson(e.toString()))
      .toList();
}

List<enums.PublicBookRequestResponseStatus>?
    publicBookRequestResponseStatusNullableListFromJson(
  List? publicBookRequestResponseStatus, [
  List<enums.PublicBookRequestResponseStatus>? defaultValue,
]) {
  if (publicBookRequestResponseStatus == null) {
    return defaultValue;
  }

  return publicBookRequestResponseStatus
      .map((e) => publicBookRequestResponseStatusFromJson(e.toString()))
      .toList();
}

String? apiAdminPublicBookIdStatusPostStatusNullableToJson(
    enums.ApiAdminPublicBookIdStatusPostStatus?
        apiAdminPublicBookIdStatusPostStatus) {
  return apiAdminPublicBookIdStatusPostStatus?.value;
}

String? apiAdminPublicBookIdStatusPostStatusToJson(
    enums.ApiAdminPublicBookIdStatusPostStatus
        apiAdminPublicBookIdStatusPostStatus) {
  return apiAdminPublicBookIdStatusPostStatus.value;
}

enums.ApiAdminPublicBookIdStatusPostStatus
    apiAdminPublicBookIdStatusPostStatusFromJson(
  Object? apiAdminPublicBookIdStatusPostStatus, [
  enums.ApiAdminPublicBookIdStatusPostStatus? defaultValue,
]) {
  return enums.ApiAdminPublicBookIdStatusPostStatus.values.firstWhereOrNull(
          (e) => e.value == apiAdminPublicBookIdStatusPostStatus) ??
      defaultValue ??
      enums.ApiAdminPublicBookIdStatusPostStatus.swaggerGeneratedUnknown;
}

enums.ApiAdminPublicBookIdStatusPostStatus?
    apiAdminPublicBookIdStatusPostStatusNullableFromJson(
  Object? apiAdminPublicBookIdStatusPostStatus, [
  enums.ApiAdminPublicBookIdStatusPostStatus? defaultValue,
]) {
  if (apiAdminPublicBookIdStatusPostStatus == null) {
    return null;
  }
  return enums.ApiAdminPublicBookIdStatusPostStatus.values.firstWhereOrNull(
          (e) => e.value == apiAdminPublicBookIdStatusPostStatus) ??
      defaultValue;
}

String apiAdminPublicBookIdStatusPostStatusExplodedListToJson(
    List<enums.ApiAdminPublicBookIdStatusPostStatus>?
        apiAdminPublicBookIdStatusPostStatus) {
  return apiAdminPublicBookIdStatusPostStatus?.map((e) => e.value!).join(',') ??
      '';
}

List<String> apiAdminPublicBookIdStatusPostStatusListToJson(
    List<enums.ApiAdminPublicBookIdStatusPostStatus>?
        apiAdminPublicBookIdStatusPostStatus) {
  if (apiAdminPublicBookIdStatusPostStatus == null) {
    return [];
  }

  return apiAdminPublicBookIdStatusPostStatus.map((e) => e.value!).toList();
}

List<enums.ApiAdminPublicBookIdStatusPostStatus>
    apiAdminPublicBookIdStatusPostStatusListFromJson(
  List? apiAdminPublicBookIdStatusPostStatus, [
  List<enums.ApiAdminPublicBookIdStatusPostStatus>? defaultValue,
]) {
  if (apiAdminPublicBookIdStatusPostStatus == null) {
    return defaultValue ?? [];
  }

  return apiAdminPublicBookIdStatusPostStatus
      .map((e) => apiAdminPublicBookIdStatusPostStatusFromJson(e.toString()))
      .toList();
}

List<enums.ApiAdminPublicBookIdStatusPostStatus>?
    apiAdminPublicBookIdStatusPostStatusNullableListFromJson(
  List? apiAdminPublicBookIdStatusPostStatus, [
  List<enums.ApiAdminPublicBookIdStatusPostStatus>? defaultValue,
]) {
  if (apiAdminPublicBookIdStatusPostStatus == null) {
    return defaultValue;
  }

  return apiAdminPublicBookIdStatusPostStatus
      .map((e) => apiAdminPublicBookIdStatusPostStatusFromJson(e.toString()))
      .toList();
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
