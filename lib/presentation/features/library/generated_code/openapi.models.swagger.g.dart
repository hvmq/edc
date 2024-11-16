// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentModeration _$ContentModerationFromJson(Map<String, dynamic> json) =>
    ContentModeration(
      id: (json['id'] as num?)?.toInt(),
      bookId: (json['bookId'] as num?)?.toInt(),
      status: json['status'] as String?,
      moderatedBy: (json['moderatedBy'] as num?)?.toInt(),
      comments: json['comments'] as String?,
      moderatedAt: json['moderatedAt'] == null
          ? null
          : DateTime.parse(json['moderatedAt'] as String),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ContentModerationToJson(ContentModeration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('status', instance.status);
  writeNotNull('moderatedBy', instance.moderatedBy);
  writeNotNull('comments', instance.comments);
  writeNotNull('moderatedAt', instance.moderatedAt?.toIso8601String());
  writeNotNull('data', instance.data);
  return val;
}

ContentModerationRequest _$ContentModerationRequestFromJson(
        Map<String, dynamic> json) =>
    ContentModerationRequest(
      bookId: (json['bookId'] as num?)?.toInt(),
      comments: json['comments'] as String?,
    );

Map<String, dynamic> _$ContentModerationRequestToJson(
    ContentModerationRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookId', instance.bookId);
  writeNotNull('comments', instance.comments);
  return val;
}

AdminFileUploadFormRequest _$AdminFileUploadFormRequestFromJson(
        Map<String, dynamic> json) =>
    AdminFileUploadFormRequest(
      fileData: json['fileData'] as String?,
      classify: json['classify'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AdminFileUploadFormRequestToJson(
    AdminFileUploadFormRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fileData', instance.fileData);
  writeNotNull('classify', instance.classify);
  writeNotNull('id', instance.id);
  return val;
}

InputPart _$InputPartFromJson(Map<String, dynamic> json) => InputPart(
      contentTypeFromMessage: json['contentTypeFromMessage'] as bool?,
      bodyAsString: json['bodyAsString'] as String?,
      mediaType: json['mediaType'] == null
          ? null
          : MediaType.fromJson(json['mediaType'] as Map<String, dynamic>),
      body: json['body'],
      fileName: json['fileName'] as String?,
      headers: json['headers'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$InputPartToJson(InputPart instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contentTypeFromMessage', instance.contentTypeFromMessage);
  writeNotNull('bodyAsString', instance.bodyAsString);
  writeNotNull('mediaType', instance.mediaType?.toJson());
  writeNotNull('body', instance.body);
  writeNotNull('fileName', instance.fileName);
  writeNotNull('headers', instance.headers);
  return val;
}

MediaType _$MediaTypeFromJson(Map<String, dynamic> json) => MediaType(
      type: json['type'] as String?,
      subtype: json['subtype'] as String?,
      parameters: json['parameters'] as Map<String, dynamic>?,
      wildcardType: json['wildcardType'] as bool?,
      wildcardSubtype: json['wildcardSubtype'] as bool?,
    );

Map<String, dynamic> _$MediaTypeToJson(MediaType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('subtype', instance.subtype);
  writeNotNull('parameters', instance.parameters);
  writeNotNull('wildcardType', instance.wildcardType);
  writeNotNull('wildcardSubtype', instance.wildcardSubtype);
  return val;
}

MultipartFormDataInput _$MultipartFormDataInputFromJson(
        Map<String, dynamic> json) =>
    MultipartFormDataInput(
      formDataMap: json['formDataMap'] as Map<String, dynamic>?,
      preamble: json['preamble'] as String?,
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => InputPart.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MultipartFormDataInputToJson(
    MultipartFormDataInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('formDataMap', instance.formDataMap);
  writeNotNull('preamble', instance.preamble);
  writeNotNull('parts', instance.parts?.map((e) => e.toJson()).toList());
  return val;
}

MultivaluedMapStringString _$MultivaluedMapStringStringFromJson(
        Map<String, dynamic> json) =>
    MultivaluedMapStringString(
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$MultivaluedMapStringStringToJson(
    MultivaluedMapStringString instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('empty', instance.empty);
  return val;
}

FilterRequest _$FilterRequestFromJson(Map<String, dynamic> json) =>
    FilterRequest(
      filters: json['filters'] == null
          ? null
          : Filters.fromJson(json['filters'] as Map<String, dynamic>),
      sorts: json['sorts'] == null
          ? null
          : Sorts.fromJson(json['sorts'] as Map<String, dynamic>),
      limit: (json['limit'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FilterRequestToJson(FilterRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('filters', instance.filters?.toJson());
  writeNotNull('sorts', instance.sorts?.toJson());
  writeNotNull('limit', instance.limit);
  writeNotNull('page', instance.page);
  return val;
}

FilterRule _$FilterRuleFromJson(Map<String, dynamic> json) => FilterRule(
      field: json['field'] as String?,
      $operator: json['operator'] as String?,
      $value: json['value'] as String?,
    );

Map<String, dynamic> _$FilterRuleToJson(FilterRule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('field', instance.field);
  writeNotNull('operator', instance.$operator);
  writeNotNull('value', instance.$value);
  return val;
}

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
      condition: json['condition'] as String?,
      rules: (json['rules'] as List<dynamic>?)
              ?.map((e) => FilterRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FiltersToJson(Filters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('condition', instance.condition);
  writeNotNull('rules', instance.rules?.map((e) => e.toJson()).toList());
  return val;
}

SortRule _$SortRuleFromJson(Map<String, dynamic> json) => SortRule(
      field: json['field'] as String?,
      ascending: json['ascending'] as bool?,
    );

Map<String, dynamic> _$SortRuleToJson(SortRule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('field', instance.field);
  writeNotNull('ascending', instance.ascending);
  return val;
}

Sorts _$SortsFromJson(Map<String, dynamic> json) => Sorts(
      rules: (json['rules'] as List<dynamic>?)
              ?.map((e) => SortRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SortsToJson(Sorts instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rules', instance.rules?.map((e) => e.toJson()).toList());
  return val;
}

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      biography: json['biography'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('biography', instance.biography);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('deleted', instance.deleted);
  writeNotNull('avatarUrl', instance.avatarUrl);
  return val;
}

AuthorRequest _$AuthorRequestFromJson(Map<String, dynamic> json) =>
    AuthorRequest(
      name: json['name'] as String?,
      biography: json['biography'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$AuthorRequestToJson(AuthorRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('biography', instance.biography);
  writeNotNull('avatarUrl', instance.avatarUrl);
  return val;
}

AuthorImageFormRequest _$AuthorImageFormRequestFromJson(
        Map<String, dynamic> json) =>
    AuthorImageFormRequest(
      fileData: json['fileData'] as String?,
      authorId: json['authorId'] as String?,
    );

Map<String, dynamic> _$AuthorImageFormRequestToJson(
    AuthorImageFormRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fileData', instance.fileData);
  writeNotNull('authorId', instance.authorId);
  return val;
}

AuthorResponse _$AuthorResponseFromJson(Map<String, dynamic> json) =>
    AuthorResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AuthorResponseToJson(AuthorResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  return val;
}

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      author: json['author'] == null
          ? null
          : AuthorResponse.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      publicationYear: (json['publicationYear'] as num?)?.toInt(),
      isbn: json['isbn'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      resourceType: json['resourceType'] as String?,
      language: json['language'] as String?,
      pageCount: (json['pageCount'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool?,
      category: (json['category'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      excerpt: json['excerpt'] as String?,
      authorEvaluation: json['authorEvaluation'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => BookImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      readingTime: (json['readingTime'] as num?)?.toInt(),
      numberOfChapters: (json['numberOfChapters'] as num?)?.toInt(),
      uploadedBy: json['uploadedBy'] as String?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      publicBookRequestResponse: json['publicBookRequestResponse'] == null
          ? null
          : PublicBookRequestResponse.fromJson(
              json['publicBookRequestResponse'] as Map<String, dynamic>),
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
      status: json['status'] as bool?,
      chapters: (json['chapters'] as List<dynamic>?)
              ?.map((e) => BookChapter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      bookReviewResponse: json['bookReviewResponse'] == null
          ? null
          : BookReviewResponse.fromJson(
              json['bookReviewResponse'] as Map<String, dynamic>),
      isPurchased: (json['isPurchased'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookToJson(Book instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('author', instance.author?.toJson());
  writeNotNull('publisher', instance.publisher?.toJson());
  writeNotNull('publicationYear', instance.publicationYear);
  writeNotNull('isbn', instance.isbn);
  writeNotNull('price', instance.price);
  writeNotNull('description', instance.description);
  writeNotNull('resourceType', instance.resourceType);
  writeNotNull('language', instance.language);
  writeNotNull('pageCount', instance.pageCount);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('deleted', instance.deleted);
  writeNotNull('category', instance.category?.map((e) => e.toJson()).toList());
  writeNotNull('createdBy', instance.createdBy);
  writeNotNull('updatedBy', instance.updatedBy);
  writeNotNull('excerpt', instance.excerpt);
  writeNotNull('authorEvaluation', instance.authorEvaluation);
  writeNotNull('images', instance.images?.map((e) => e.toJson()).toList());
  writeNotNull('readingTime', instance.readingTime);
  writeNotNull('numberOfChapters', instance.numberOfChapters);
  writeNotNull('uploadedBy', instance.uploadedBy);
  writeNotNull('tags', instance.tags?.map((e) => e.toJson()).toList());
  writeNotNull('publicBookRequestResponse',
      instance.publicBookRequestResponse?.toJson());
  writeNotNull('ageAverage', instance.ageAverage);
  writeNotNull('status', instance.status);
  writeNotNull('chapters', instance.chapters?.map((e) => e.toJson()).toList());
  writeNotNull('bookReviewResponse', instance.bookReviewResponse?.toJson());
  writeNotNull('isPurchased', instance.isPurchased);
  return val;
}

BookChapter _$BookChapterFromJson(Map<String, dynamic> json) => BookChapter(
      id: (json['id'] as num?)?.toInt(),
      bookId: (json['bookId'] as num?)?.toInt(),
      title: json['title'] as String?,
      chapterNumber: (json['chapterNumber'] as num?)?.toInt(),
      resourceLink: json['resourceLink'] as String?,
      type: json['type'] as String?,
      format: json['format'] as String?,
      isEncrypted: json['isEncrypted'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BookChapterToJson(BookChapter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('title', instance.title);
  writeNotNull('chapterNumber', instance.chapterNumber);
  writeNotNull('resourceLink', instance.resourceLink);
  writeNotNull('type', instance.type);
  writeNotNull('format', instance.format);
  writeNotNull('isEncrypted', instance.isEncrypted);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  return val;
}

BookImage _$BookImageFromJson(Map<String, dynamic> json) => BookImage(
      id: (json['id'] as num?)?.toInt(),
      bookId: (json['bookId'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      caption: json['caption'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      priority: (json['priority'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$BookImageToJson(BookImage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('caption', instance.caption);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('priority', instance.priority);
  writeNotNull('deleted', instance.deleted);
  return val;
}

BookReviewResponse _$BookReviewResponseFromJson(Map<String, dynamic> json) =>
    BookReviewResponse(
      numberOfReviews: (json['numberOfReviews'] as num?)?.toInt(),
      averageRating: (json['averageRating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BookReviewResponseToJson(BookReviewResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('numberOfReviews', instance.numberOfReviews);
  writeNotNull('averageRating', instance.averageRating);
  return val;
}

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('deleted', instance.deleted);
  return val;
}

PublicBookRequestResponse _$PublicBookRequestResponseFromJson(
        Map<String, dynamic> json) =>
    PublicBookRequestResponse(
      status: publicBookRequestResponseStatusNullableFromJson(json['status']),
      uploadedRole: json['uploadedRole'] as String?,
    );

Map<String, dynamic> _$PublicBookRequestResponseToJson(
    PublicBookRequestResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'status', publicBookRequestResponseStatusNullableToJson(instance.status));
  writeNotNull('uploadedRole', instance.uploadedRole);
  return val;
}

Publisher _$PublisherFromJson(Map<String, dynamic> json) => Publisher(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      address: json['address'] as String?,
      contactInfo: json['contactInfo'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PublisherToJson(Publisher instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('address', instance.address);
  writeNotNull('contactInfo', instance.contactInfo);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  return val;
}

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
      id: (json['id'] as num?)?.toInt(),
      tagName: json['tagName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$TagModelToJson(TagModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('tagName', instance.tagName);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('deleted', instance.deleted);
  return val;
}

BookRequest _$BookRequestFromJson(Map<String, dynamic> json) => BookRequest(
      title: json['title'] as String?,
      authorId: (json['authorId'] as num?)?.toInt(),
      publisherId: (json['publisherId'] as num?)?.toInt(),
      publicationYear: (json['publicationYear'] as num?)?.toInt(),
      isbn: json['isbn'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      resourceType: json['resourceType'] as String?,
      language: json['language'] as String?,
      pageCount: (json['pageCount'] as num?)?.toInt(),
      excerpt: json['excerpt'] as String?,
      authorEvaluation: json['authorEvaluation'] as String?,
      readingTime: (json['readingTime'] as num?)?.toInt(),
      numberOfChapters: (json['numberOfChapters'] as num?)?.toInt(),
      categoryIds: (json['categoryIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      tagIds: (json['tagIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$BookRequestToJson(BookRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('authorId', instance.authorId);
  writeNotNull('publisherId', instance.publisherId);
  writeNotNull('publicationYear', instance.publicationYear);
  writeNotNull('isbn', instance.isbn);
  writeNotNull('price', instance.price);
  writeNotNull('description', instance.description);
  writeNotNull('resourceType', instance.resourceType);
  writeNotNull('language', instance.language);
  writeNotNull('pageCount', instance.pageCount);
  writeNotNull('excerpt', instance.excerpt);
  writeNotNull('authorEvaluation', instance.authorEvaluation);
  writeNotNull('readingTime', instance.readingTime);
  writeNotNull('numberOfChapters', instance.numberOfChapters);
  writeNotNull('categoryIds', instance.categoryIds);
  writeNotNull('tagIds', instance.tagIds);
  writeNotNull('ageAverage', instance.ageAverage);
  writeNotNull('status', instance.status);
  return val;
}

AdminBookUploadFormRequest _$AdminBookUploadFormRequestFromJson(
        Map<String, dynamic> json) =>
    AdminBookUploadFormRequest(
      fileData: json['fileData'] as String?,
      bookId: json['bookId'] as String?,
      title: json['title'] as String?,
      chapterNumber: (json['chapterNumber'] as num?)?.toInt(),
      format: json['format'] as String?,
      isEncrypted: json['isEncrypted'] as String?,
    );

Map<String, dynamic> _$AdminBookUploadFormRequestToJson(
    AdminBookUploadFormRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fileData', instance.fileData);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('title', instance.title);
  writeNotNull('chapterNumber', instance.chapterNumber);
  writeNotNull('format', instance.format);
  writeNotNull('isEncrypted', instance.isEncrypted);
  return val;
}

BookImageFormRequest _$BookImageFormRequestFromJson(
        Map<String, dynamic> json) =>
    BookImageFormRequest(
      fileData: json['fileData'] as String?,
      bookId: json['bookId'] as String?,
    );

Map<String, dynamic> _$BookImageFormRequestToJson(
    BookImageFormRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fileData', instance.fileData);
  writeNotNull('bookId', instance.bookId);
  return val;
}

BookComment _$BookCommentFromJson(Map<String, dynamic> json) => BookComment(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      bookId: (json['bookId'] as num?)?.toInt(),
      commentText: json['commentText'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$BookCommentToJson(BookComment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('commentText', instance.commentText);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('deleted', instance.deleted);
  return val;
}

BookReview _$BookReviewFromJson(Map<String, dynamic> json) => BookReview(
      id: (json['id'] as num?)?.toInt(),
      bookId: (json['bookId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
      reviewText: json['reviewText'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool?,
      userName: json['userName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$BookReviewToJson(BookReview instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('userId', instance.userId);
  writeNotNull('rating', instance.rating);
  writeNotNull('reviewText', instance.reviewText);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('deleted', instance.deleted);
  writeNotNull('userName', instance.userName);
  writeNotNull('avatarUrl', instance.avatarUrl);
  return val;
}

CategoryRequest _$CategoryRequestFromJson(Map<String, dynamic> json) =>
    CategoryRequest(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CategoryRequestToJson(CategoryRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  return val;
}

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      paymentMethod: json['paymentMethod'] as String?,
      orderStatus: json['orderStatus'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      orderItems: (json['orderItems'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('totalPrice', instance.totalPrice);
  writeNotNull('paymentMethod', instance.paymentMethod);
  writeNotNull('orderStatus', instance.orderStatus);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull(
      'orderItems', instance.orderItems?.map((e) => e.toJson()).toList());
  return val;
}

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      data: json['data'] as Map<String, dynamic>?,
      id: (json['id'] as num?)?.toInt(),
      orderId: (json['orderId'] as num?)?.toInt(),
      bookId: (json['bookId'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  writeNotNull('id', instance.id);
  writeNotNull('orderId', instance.orderId);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('price', instance.price);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('deleted', instance.deleted);
  return val;
}

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      userId: (json['userId'] as num?)?.toInt(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      paymentMethod: json['paymentMethod'] as String?,
      orderStatus: json['orderStatus'] as String?,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('totalPrice', instance.totalPrice);
  writeNotNull('paymentMethod', instance.paymentMethod);
  writeNotNull('orderStatus', instance.orderStatus);
  return val;
}

PublicBookRequest _$PublicBookRequestFromJson(Map<String, dynamic> json) =>
    PublicBookRequest(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      bookId: (json['bookId'] as num?)?.toInt(),
      status: json['status'] as String?,
      requestedAt: json['requestedAt'] == null
          ? null
          : DateTime.parse(json['requestedAt'] as String),
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PublicBookRequestToJson(PublicBookRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('status', instance.status);
  writeNotNull('requestedAt', instance.requestedAt?.toIso8601String());
  writeNotNull('approvedAt', instance.approvedAt?.toIso8601String());
  writeNotNull('data', instance.data);
  return val;
}

PublisherRequest _$PublisherRequestFromJson(Map<String, dynamic> json) =>
    PublisherRequest(
      name: json['name'] as String?,
      address: json['address'] as String?,
      contactInfo: json['contactInfo'] as String?,
    );

Map<String, dynamic> _$PublisherRequestToJson(PublisherRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('address', instance.address);
  writeNotNull('contactInfo', instance.contactInfo);
  return val;
}

TagRequest _$TagRequestFromJson(Map<String, dynamic> json) => TagRequest(
      tagName: json['tagName'] as String?,
    );

Map<String, dynamic> _$TagRequestToJson(TagRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tagName', instance.tagName);
  return val;
}

AdminLoginFormRequest _$AdminLoginFormRequestFromJson(
        Map<String, dynamic> json) =>
    AdminLoginFormRequest(
      phone: json['phone'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AdminLoginFormRequestToJson(
    AdminLoginFormRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('phone', instance.phone);
  writeNotNull('password', instance.password);
  return val;
}

VoucherRequest _$VoucherRequestFromJson(Map<String, dynamic> json) =>
    VoucherRequest(
      code: json['code'] as String?,
      description: json['description'] as String?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      maxDiscountAmount: (json['maxDiscountAmount'] as num?)?.toDouble(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$VoucherRequestToJson(VoucherRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('description', instance.description);
  writeNotNull('discountPercentage', instance.discountPercentage);
  writeNotNull('maxDiscountAmount', instance.maxDiscountAmount);
  writeNotNull('startDate', instance.startDate?.toIso8601String());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('isActive', instance.isActive);
  return val;
}

Voucher _$VoucherFromJson(Map<String, dynamic> json) => Voucher(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      description: json['description'] as String?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      maxDiscountAmount: (json['maxDiscountAmount'] as num?)?.toDouble(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$VoucherToJson(Voucher instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('code', instance.code);
  writeNotNull('description', instance.description);
  writeNotNull('discountPercentage', instance.discountPercentage);
  writeNotNull('maxDiscountAmount', instance.maxDiscountAmount);
  writeNotNull('startDate', instance.startDate?.toIso8601String());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('isActive', instance.isActive);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  return val;
}

MakeOrderRequest _$MakeOrderRequestFromJson(Map<String, dynamic> json) =>
    MakeOrderRequest(
      bookIds: (json['bookIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      voucherId: (json['voucherId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MakeOrderRequestToJson(MakeOrderRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookIds', instance.bookIds);
  writeNotNull('voucherId', instance.voucherId);
  return val;
}

AuthorAppResponse _$AuthorAppResponseFromJson(Map<String, dynamic> json) =>
    AuthorAppResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      biography: json['biography'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      books: (json['books'] as List<dynamic>?)
              ?.map((e) => RetrieveBookByAuthorIdResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AuthorAppResponseToJson(AuthorAppResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('biography', instance.biography);
  writeNotNull('avatarUrl', instance.avatarUrl);
  writeNotNull('books', instance.books?.map((e) => e.toJson()).toList());
  return val;
}

RetrieveBookByAuthorIdResponse _$RetrieveBookByAuthorIdResponseFromJson(
        Map<String, dynamic> json) =>
    RetrieveBookByAuthorIdResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      publicationYear: (json['publicationYear'] as num?)?.toInt(),
      isbn: json['isbn'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      resourceType: json['resourceType'] as String?,
      language: json['language'] as String?,
      pageCount: (json['pageCount'] as num?)?.toInt(),
      tags: json['tags'] as String?,
      imageUrl: json['imageUrl'] as String?,
      categories: json['categories'] as String?,
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RetrieveBookByAuthorIdResponseToJson(
    RetrieveBookByAuthorIdResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('publisher', instance.publisher?.toJson());
  writeNotNull('publicationYear', instance.publicationYear);
  writeNotNull('isbn', instance.isbn);
  writeNotNull('price', instance.price);
  writeNotNull('description', instance.description);
  writeNotNull('resourceType', instance.resourceType);
  writeNotNull('language', instance.language);
  writeNotNull('pageCount', instance.pageCount);
  writeNotNull('tags', instance.tags);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('categories', instance.categories);
  writeNotNull('ageAverage', instance.ageAverage);
  return val;
}

BookAppRequest _$BookAppRequestFromJson(Map<String, dynamic> json) =>
    BookAppRequest(
      title: json['title'] as String?,
      authorId: (json['authorId'] as num?)?.toInt(),
      publisherId: (json['publisherId'] as num?)?.toInt(),
      publicationYear: (json['publicationYear'] as num?)?.toInt(),
      isbn: json['isbn'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      resourceType: json['resourceType'] as String?,
      language: json['language'] as String?,
      pageCount: (json['pageCount'] as num?)?.toInt(),
      excerpt: json['excerpt'] as String?,
      authorEvaluation: json['authorEvaluation'] as String?,
      readingTime: (json['readingTime'] as num?)?.toInt(),
      numberOfChapters: (json['numberOfChapters'] as num?)?.toInt(),
      categoryIds: (json['categoryIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      tagIds: (json['tagIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookAppRequestToJson(BookAppRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('authorId', instance.authorId);
  writeNotNull('publisherId', instance.publisherId);
  writeNotNull('publicationYear', instance.publicationYear);
  writeNotNull('isbn', instance.isbn);
  writeNotNull('price', instance.price);
  writeNotNull('description', instance.description);
  writeNotNull('resourceType', instance.resourceType);
  writeNotNull('language', instance.language);
  writeNotNull('pageCount', instance.pageCount);
  writeNotNull('excerpt', instance.excerpt);
  writeNotNull('authorEvaluation', instance.authorEvaluation);
  writeNotNull('readingTime', instance.readingTime);
  writeNotNull('numberOfChapters', instance.numberOfChapters);
  writeNotNull('categoryIds', instance.categoryIds);
  writeNotNull('tagIds', instance.tagIds);
  writeNotNull('ageAverage', instance.ageAverage);
  return val;
}

BookChapterGoogleDriveRequest _$BookChapterGoogleDriveRequestFromJson(
        Map<String, dynamic> json) =>
    BookChapterGoogleDriveRequest(
      fileId: json['fileId'] as String?,
      accessToken: json['accessToken'] as String?,
      bookId: (json['bookId'] as num?)?.toInt(),
      title: json['title'] as String?,
      chapterNumber: (json['chapterNumber'] as num?)?.toInt(),
      format: json['format'] as String?,
      isEncrypted: (json['isEncrypted'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookChapterGoogleDriveRequestToJson(
    BookChapterGoogleDriveRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fileId', instance.fileId);
  writeNotNull('accessToken', instance.accessToken);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('title', instance.title);
  writeNotNull('chapterNumber', instance.chapterNumber);
  writeNotNull('format', instance.format);
  writeNotNull('isEncrypted', instance.isEncrypted);
  return val;
}

BookCommentRequest _$BookCommentRequestFromJson(Map<String, dynamic> json) =>
    BookCommentRequest(
      bookId: (json['bookId'] as num?)?.toInt(),
      commentText: json['commentText'] as String?,
    );

Map<String, dynamic> _$BookCommentRequestToJson(BookCommentRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookId', instance.bookId);
  writeNotNull('commentText', instance.commentText);
  return val;
}

BookReviewRequest _$BookReviewRequestFromJson(Map<String, dynamic> json) =>
    BookReviewRequest(
      bookId: (json['bookId'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
      reviewText: json['reviewText'] as String?,
    );

Map<String, dynamic> _$BookReviewRequestToJson(BookReviewRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookId', instance.bookId);
  writeNotNull('rating', instance.rating);
  writeNotNull('reviewText', instance.reviewText);
  return val;
}

BookmarkAppRequest _$BookmarkAppRequestFromJson(Map<String, dynamic> json) =>
    BookmarkAppRequest(
      bookId: (json['bookId'] as num?)?.toInt(),
      chapterId: (json['chapterId'] as num?)?.toInt(),
      title: json['title'] as String?,
      position: (json['position'] as num?)?.toInt(),
      isBook: json['isBook'] as bool?,
    );

Map<String, dynamic> _$BookmarkAppRequestToJson(BookmarkAppRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookId', instance.bookId);
  writeNotNull('chapterId', instance.chapterId);
  writeNotNull('title', instance.title);
  writeNotNull('position', instance.position);
  writeNotNull('isBook', instance.isBook);
  return val;
}

PaginatedResult _$PaginatedResultFromJson(Map<String, dynamic> json) =>
    PaginatedResult(
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as Object).toList() ??
              [],
      totalCount: (json['totalCount'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginatedResultToJson(PaginatedResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('items', instance.items);
  writeNotNull('totalCount', instance.totalCount);
  writeNotNull('page', instance.page);
  writeNotNull('limit', instance.limit);
  return val;
}

CategoryAppResponse _$CategoryAppResponseFromJson(Map<String, dynamic> json) =>
    CategoryAppResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      books: (json['books'] as List<dynamic>?)
              ?.map((e) => RetrieveBookByCategoryIdResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CategoryAppResponseToJson(CategoryAppResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('books', instance.books?.map((e) => e.toJson()).toList());
  return val;
}

RetrieveBookByCategoryIdResponse _$RetrieveBookByCategoryIdResponseFromJson(
        Map<String, dynamic> json) =>
    RetrieveBookByCategoryIdResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      publicationYear: (json['publicationYear'] as num?)?.toInt(),
      isbn: json['isbn'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      resourceType: json['resourceType'] as String?,
      language: json['language'] as String?,
      pageCount: (json['pageCount'] as num?)?.toInt(),
      tags: json['tags'] as String?,
      imageUrl: json['imageUrl'] as String?,
      categories: json['categories'] as String?,
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RetrieveBookByCategoryIdResponseToJson(
    RetrieveBookByCategoryIdResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('author', instance.author?.toJson());
  writeNotNull('publisher', instance.publisher?.toJson());
  writeNotNull('publicationYear', instance.publicationYear);
  writeNotNull('isbn', instance.isbn);
  writeNotNull('price', instance.price);
  writeNotNull('description', instance.description);
  writeNotNull('resourceType', instance.resourceType);
  writeNotNull('language', instance.language);
  writeNotNull('pageCount', instance.pageCount);
  writeNotNull('tags', instance.tags);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('categories', instance.categories);
  writeNotNull('ageAverage', instance.ageAverage);
  return val;
}

FileUploadFormRequest _$FileUploadFormRequestFromJson(
        Map<String, dynamic> json) =>
    FileUploadFormRequest(
      fileData: json['fileData'] as String?,
      fileName: json['fileName'] as String?,
      fileType: json['fileType'] as String?,
    );

Map<String, dynamic> _$FileUploadFormRequestToJson(
    FileUploadFormRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fileData', instance.fileData);
  writeNotNull('fileName', instance.fileName);
  writeNotNull('fileType', instance.fileType);
  return val;
}

BookReadingResponse _$BookReadingResponseFromJson(Map<String, dynamic> json) =>
    BookReadingResponse(
      progressId: (json['progressId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      isCompleted: json['isCompleted'] as bool?,
      currentChapter: (json['currentChapter'] as num?)?.toInt(),
      totalChapters: (json['totalChapters'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      totalPage: (json['totalPage'] as num?)?.toInt(),
      lastReadAt: json['lastReadAt'] == null
          ? null
          : DateTime.parse(json['lastReadAt'] as String),
      bookId: (json['bookId'] as num?)?.toInt(),
      title: json['title'] as String?,
      ageAverage: (json['ageAverage'] as num?)?.toDouble(),
      authorId: (json['authorId'] as num?)?.toInt(),
      authorName: json['authorName'] as String?,
      publisherId: (json['publisherId'] as num?)?.toInt(),
      publisherName: json['publisherName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$BookReadingResponseToJson(BookReadingResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('progressId', instance.progressId);
  writeNotNull('userId', instance.userId);
  writeNotNull('isCompleted', instance.isCompleted);
  writeNotNull('currentChapter', instance.currentChapter);
  writeNotNull('totalChapters', instance.totalChapters);
  writeNotNull('currentPage', instance.currentPage);
  writeNotNull('totalPage', instance.totalPage);
  writeNotNull('lastReadAt', instance.lastReadAt?.toIso8601String());
  writeNotNull('bookId', instance.bookId);
  writeNotNull('title', instance.title);
  writeNotNull('ageAverage', instance.ageAverage);
  writeNotNull('authorId', instance.authorId);
  writeNotNull('authorName', instance.authorName);
  writeNotNull('publisherId', instance.publisherId);
  writeNotNull('publisherName', instance.publisherName);
  writeNotNull('price', instance.price);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('imageUrl', instance.imageUrl);
  return val;
}

BookBestRatedResponse _$BookBestRatedResponseFromJson(
        Map<String, dynamic> json) =>
    BookBestRatedResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      totalReviews: (json['totalReviews'] as num?)?.toInt(),
      categories: json['categories'] as String?,
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookBestRatedResponseToJson(
    BookBestRatedResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('author', instance.author?.toJson());
  writeNotNull('publisher', instance.publisher?.toJson());
  writeNotNull('price', instance.price);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('averageRating', instance.averageRating);
  writeNotNull('totalReviews', instance.totalReviews);
  writeNotNull('categories', instance.categories);
  writeNotNull('ageAverage', instance.ageAverage);
  return val;
}

DiscountedBookResponse _$DiscountedBookResponseFromJson(
        Map<String, dynamic> json) =>
    DiscountedBookResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      categories: json['categories'] as String?,
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DiscountedBookResponseToJson(
    DiscountedBookResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('discountPercentage', instance.discountPercentage);
  writeNotNull('author', instance.author?.toJson());
  writeNotNull('publisher', instance.publisher?.toJson());
  writeNotNull('price', instance.price);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('categories', instance.categories);
  writeNotNull('ageAverage', instance.ageAverage);
  return val;
}

DynamicContent _$DynamicContentFromJson(Map<String, dynamic> json) =>
    DynamicContent(
      id: (json['id'] as num?)?.toInt(),
      contentType: json['contentType'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$DynamicContentToJson(DynamicContent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('contentType', instance.contentType);
  writeNotNull('title', instance.title);
  writeNotNull('content', instance.content);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('deleted', instance.deleted);
  return val;
}

BookMostOrderedResponse _$BookMostOrderedResponseFromJson(
        Map<String, dynamic> json) =>
    BookMostOrderedResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      publicationYear: (json['publicationYear'] as num?)?.toInt(),
      isbn: json['isbn'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      resourceType: json['resourceType'] as String?,
      language: json['language'] as String?,
      pageCount: (json['pageCount'] as num?)?.toInt(),
      tags: json['tags'] as String?,
      imageUrl: json['imageUrl'] as String?,
      categories: json['categories'] as String?,
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookMostOrderedResponseToJson(
    BookMostOrderedResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('author', instance.author?.toJson());
  writeNotNull('publisher', instance.publisher?.toJson());
  writeNotNull('publicationYear', instance.publicationYear);
  writeNotNull('isbn', instance.isbn);
  writeNotNull('price', instance.price);
  writeNotNull('description', instance.description);
  writeNotNull('resourceType', instance.resourceType);
  writeNotNull('language', instance.language);
  writeNotNull('pageCount', instance.pageCount);
  writeNotNull('tags', instance.tags);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('categories', instance.categories);
  writeNotNull('ageAverage', instance.ageAverage);
  return val;
}

BookMostPopularResponse _$BookMostPopularResponseFromJson(
        Map<String, dynamic> json) =>
    BookMostPopularResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      totalViews: (json['totalViews'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
      categories: json['categories'] as String?,
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookMostPopularResponseToJson(
    BookMostPopularResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('totalViews', instance.totalViews);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('author', instance.author?.toJson());
  writeNotNull('publisher', instance.publisher?.toJson());
  writeNotNull('price', instance.price);
  writeNotNull('categories', instance.categories);
  writeNotNull('ageAverage', instance.ageAverage);
  return val;
}

NewBookResponse _$NewBookResponseFromJson(Map<String, dynamic> json) =>
    NewBookResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      categories: json['categories'] as String?,
      ageAverage: (json['ageAverage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NewBookResponseToJson(NewBookResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('author', instance.author?.toJson());
  writeNotNull('publisher', instance.publisher?.toJson());
  writeNotNull('price', instance.price);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('categories', instance.categories);
  writeNotNull('ageAverage', instance.ageAverage);
  return val;
}

BookAdvancedSearchRequest _$BookAdvancedSearchRequestFromJson(
        Map<String, dynamic> json) =>
    BookAdvancedSearchRequest(
      searchText: json['searchText'] as String?,
      sortType: json['sortType'] as String?,
      starNumbers: (json['starNumbers'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      resourceTypes: (json['resourceTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sortPriceType: json['sortPriceType'] as String?,
      authorNames: (json['authorNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      state: json['state'] as String?,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      fromPrice: (json['fromPrice'] as num?)?.toDouble(),
      toPrice: (json['toPrice'] as num?)?.toDouble(),
      publisherNames: (json['publisherNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      fromPublishYear: (json['fromPublishYear'] as num?)?.toInt(),
      toPublishYear: (json['toPublishYear'] as num?)?.toInt(),
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      priority: (json['priority'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
    );

Map<String, dynamic> _$BookAdvancedSearchRequestToJson(
    BookAdvancedSearchRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('searchText', instance.searchText);
  writeNotNull('sortType', instance.sortType);
  writeNotNull('starNumbers', instance.starNumbers);
  writeNotNull('resourceTypes', instance.resourceTypes);
  writeNotNull('sortPriceType', instance.sortPriceType);
  writeNotNull('authorNames', instance.authorNames);
  writeNotNull('state', instance.state);
  writeNotNull('categories', instance.categories);
  writeNotNull('fromPrice', instance.fromPrice);
  writeNotNull('toPrice', instance.toPrice);
  writeNotNull('publisherNames', instance.publisherNames);
  writeNotNull('fromPublishYear', instance.fromPublishYear);
  writeNotNull('toPublishYear', instance.toPublishYear);
  writeNotNull('languages', instance.languages);
  writeNotNull('priority', instance.priority);
  return val;
}

UserReadingProgressAppRequest _$UserReadingProgressAppRequestFromJson(
        Map<String, dynamic> json) =>
    UserReadingProgressAppRequest(
      bookId: (json['bookId'] as num?)?.toInt(),
      currentChapter: (json['currentChapter'] as num?)?.toInt(),
      totalChapters: (json['totalChapters'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      totalPage: (json['totalPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserReadingProgressAppRequestToJson(
    UserReadingProgressAppRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookId', instance.bookId);
  writeNotNull('currentChapter', instance.currentChapter);
  writeNotNull('totalChapters', instance.totalChapters);
  writeNotNull('currentPage', instance.currentPage);
  writeNotNull('totalPage', instance.totalPage);
  return val;
}

UserReadingProgress _$UserReadingProgressFromJson(Map<String, dynamic> json) =>
    UserReadingProgress(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      bookId: (json['bookId'] as num?)?.toInt(),
      isCompleted: json['isCompleted'] as bool?,
      currentChapter: (json['currentChapter'] as num?)?.toInt(),
      totalChapters: (json['totalChapters'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      totalPage: (json['totalPage'] as num?)?.toInt(),
      lastReadAt: json['lastReadAt'] == null
          ? null
          : DateTime.parse(json['lastReadAt'] as String),
    );

Map<String, dynamic> _$UserReadingProgressToJson(UserReadingProgress instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('bookId', instance.bookId);
  writeNotNull('isCompleted', instance.isCompleted);
  writeNotNull('currentChapter', instance.currentChapter);
  writeNotNull('totalChapters', instance.totalChapters);
  writeNotNull('currentPage', instance.currentPage);
  writeNotNull('totalPage', instance.totalPage);
  writeNotNull('lastReadAt', instance.lastReadAt?.toIso8601String());
  return val;
}

VoucherAppResponse _$VoucherAppResponseFromJson(Map<String, dynamic> json) =>
    VoucherAppResponse(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      description: json['description'] as String?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      maxDiscountAmount: (json['maxDiscountAmount'] as num?)?.toDouble(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deleted: json['deleted'] as bool?,
      isUsedByUser: json['isUsedByUser'] as bool?,
    );

Map<String, dynamic> _$VoucherAppResponseToJson(VoucherAppResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('code', instance.code);
  writeNotNull('description', instance.description);
  writeNotNull('discountPercentage', instance.discountPercentage);
  writeNotNull('maxDiscountAmount', instance.maxDiscountAmount);
  writeNotNull('startDate', instance.startDate?.toIso8601String());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('isActive', instance.isActive);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('deleted', instance.deleted);
  writeNotNull('isUsedByUser', instance.isUsedByUser);
  return val;
}

InputPart$Headers _$InputPart$HeadersFromJson(Map<String, dynamic> json) =>
    InputPart$Headers(
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$InputPart$HeadersToJson(InputPart$Headers instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('empty', instance.empty);
  return val;
}
