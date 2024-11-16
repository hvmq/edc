
import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;

import '../../../generated_code/openapi.models.swagger.dart';
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class CreateBookIDRequestResponse {
  final int? bookId;

  CreateBookIDRequestResponse({
    this.bookId,
  });

  factory CreateBookIDRequestResponse.fromJson(Map<String, dynamic> json) {
    return CreateBookIDRequestResponse(
      bookId: json['id'],
    );
  }
}

class CreateBookIDApiRepository extends OpenApiRepository<int> {
  CreateBookIDApiRepository()
      : super(DefaultJsonDecoder<int>((json) => int.parse(json.toString())));

  Future<get_response.Response<CreateBookIDRequestResponse>>
      create_book_id() async {
    final chopper_response.Response<int> chopperResult =
        await openapi.apiAppBooksCreateIdPost();

    final CreateBookIDRequestResponse response = CreateBookIDRequestResponse(
      bookId: chopperResult.body,
    );

    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }
}

class BaseResponse {
  final String? message;
  final int? status;

  BaseResponse({
    this.message,
    this.status,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      message: json['message'],
      status: json['status'],
    );
  }
}

class PublicBookApiRepository extends OpenApiRepository<BaseResponse> {
  PublicBookApiRepository()
      : super(DefaultJsonDecoder<BaseResponse>(
            (json) => BaseResponse.fromJson(json)));

  Future<get_response.Response<BaseResponse>> public_book_request(
      BookAppRequest bookAppRequest, int? bookId) async {
    // Instantiate CreateBookIDApiRepository to get the book ID
    CreateBookIDApiRepository createBookIDApiRepository =
        CreateBookIDApiRepository();

    // // Await the result of create_book_id()
    // final get_response.Response<CreateBookIDRequestResponse>
    //     createBookIDResponse = await createBookIDApiRepository.create_book_id();

    // // Ensure book ID is retrieved successfully
    // if (createBookIDResponse.body?.bookId == null) {
    //   throw Exception('Failed to create book ID');
    // }

    // final int bookId = createBookIDResponse.body!.bookId!;

    // Make the API call to publish the book with the created bookId
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBooksIdPut(
      body: bookAppRequest,
      id: bookId, // Pass the bookId received from the create_book_id call
    );

    if (chopperResult.body == null) {
      throw Exception('Failed to publish book');
    }else if (chopperResult.statusCode != 200) {
      throw Exception('Failed to publish book: ${chopperResult.error}');
    }

    // Cast chopperResult.body to BaseResponse and wrap it in get_response.Response
    final BaseResponse response =
        BaseResponse.fromJson(chopperResult.body as Map<String, dynamic>);

    // Return the correctly typed response
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }
}

class UploadChapterApiRepository extends OpenApiRepository<BookChapterResponse> {
  UploadChapterApiRepository()
      : super(DefaultJsonDecoder<BookChapterResponse>(
            (json) => BookChapterResponse.fromJson(json)));

  Future<get_response.Response<BookChapterResponse>> upload_chapter_file(
      AdminBookUploadFormRequest formRequest) async {
    // Make the API call to publish the book with the created bookId
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBooksUploadChapterPost(
      body: formRequest,
    );

    // Cast chopperResult.body to BaseResponse and wrap it in get_response.Response
    final BookChapterResponse response =
        BookChapterResponse.fromJson(chopperResult.body as Map<String, dynamic>);

    // Return the correctly typed response
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }
}

class BookChapterResponse {
  final int id;
  final int bookId;
  final String title;
  final int chapterNumber;
  final String resourceLink;
  final String format;
  final bool isEncrypted;

  // Constructor
  BookChapterResponse({
    required this.id,
    required this.bookId,
    required this.title,
    required this.chapterNumber,
    required this.resourceLink,
    required this.format,
    required this.isEncrypted,
  });

  // Factory method to create an instance from JSON
  factory BookChapterResponse.fromJson(Map<String, dynamic> json) {
    return BookChapterResponse(
      id: json['id'] ?? 0,
      bookId: json['bookId'] ?? 0,
      title: json['title'] ?? '',
      chapterNumber: json['chapterNumber'] ?? 0,
      resourceLink: json['resourceLink'] ?? '',
      format: json['format'] ?? '',
      isEncrypted: json['isEncrypted'] ?? false,
    );
  }

  // Method to convert an instance to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'title': title,
      'chapterNumber': chapterNumber,
      'resourceLink': resourceLink,
      'format': format,
      'isEncrypted': isEncrypted,
    };
  }
}

class UploadImageApiRepository extends OpenApiRepository<BookImage> {
  UploadImageApiRepository()
      : super(
            DefaultJsonDecoder<BookImage>((json) => BookImage.fromJson(json)));

  Future<get_response.Response<BookImage>> upload_image(
      BookImageFormRequest bookImageRequest) async {

    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBooksUploadImagePost(body: bookImageRequest);

    // Cast chopperResult.body to BaseResponse and wrap it in get_response.Response
    if (chopperResult.body == null) {
      throw Exception('Failed to upload image');
    }
    final BookImage response =
        BookImage.fromJson(chopperResult.body as Map<String, dynamic>);

    // Return the correctly typed response
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }
}

class UploadBookApiRepository extends OpenApiRepository<Book> {
  UploadBookApiRepository()
      : super(DefaultJsonDecoder<Book>((json) => Book.fromJson(json)));

  Future<get_response.Response<Book>> upload_book(
      int? id, BookAppRequest? bookAppRequest) async {

    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBooksIdPut(body: bookAppRequest, id: id);

    if (chopperResult.body == null) {
      throw Exception('Failed to upload book: ${chopperResult.error}');
    }else if (chopperResult.statusCode != 200) {
      throw Exception('Failed to upload book: ${chopperResult.error}');
    }
    // Cast chopperResult.body to BaseResponse and wrap it in get_response.Response
    final BookUploadResponse response =
        BookUploadResponse.fromJson(chopperResult.body as Map<String, dynamic>);

    // Return the correctly typed response
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response.toBook(),
    );
  }
}

class RegisterPublicBookApiRepository extends OpenApiRepository<BaseResponse> {
  RegisterPublicBookApiRepository()
      : super(DefaultJsonDecoder<BaseResponse>(
            (json) => BaseResponse.fromJson(json)));

  Future<get_response.Response<BaseResponse>> register() async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBooksRegisterPublicPost();

    print(chopperResult.body);
    print(chopperResult.statusCode);
    print(chopperResult.error);

    if (chopperResult.body == null) {
      throw Exception('Failed to register public book');
    } 

    if (chopperResult.body is String){
      BaseResponse response = BaseResponse(
        message: chopperResult.body,
        status: chopperResult.statusCode,
      );
      // Return the correctly typed response
      return get_response.Response(
        statusCode: chopperResult.base.statusCode,
        headers: chopperResult.base.headers,
        body: response,
      );
    }else {
      final BaseResponse response =
          BaseResponse.fromJson(chopperResult.body as Map<String, dynamic>);

      // Return the correctly typed response
      return get_response.Response(
        statusCode: chopperResult.base.statusCode,
        headers: chopperResult.base.headers,
        body: response,
      );
    }
  }
}

class GetUserInfoApiRepository extends OpenApiRepository<UserData> {
  GetUserInfoApiRepository()
      : super(DefaultJsonDecoder<UserData>((json) => UserData.fromJson(json)));

  Future<get_response.Response<UserData>> get_info() async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppUserInfoPost();

    // Cast chopperResult.body to BaseResponse and wrap it in get_response.Response
    final UserData response =
        UserData.fromJson(chopperResult.body as Map<String, dynamic>);

    // Return the correctly typed response
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }
}

class UserData {
  final int id;
  final String beId;
  final String role;
  final String email;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool deleted;
  final bool isActive;
  final bool isAllowPublicBook;
  final double balance;

  UserData({
    required this.id,
    required this.beId,
    required this.role,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
    required this.isActive,
    required this.isAllowPublicBook,
    required this.balance,
  });

  // Factory method to parse from JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      beId: json['beId'],
      role: json['role'],
      email: json['email'],
      phone: json['phone'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deleted: json['deleted'],
      isActive: json['isActive'],
      isAllowPublicBook: json['isAllowPublicBook'],
      balance: json['balance'],
    );
  }

  // Convert to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'beId': beId,
      'role': role,
      'email': email,
      'phone': phone,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deleted': deleted,
      'isActive': isActive,
      'isAllowPublicBook': isAllowPublicBook,
      'balance': balance,
    };
  }
}

class PublicBookRequestInfoApiRepository extends OpenApiRepository<UserData> {
  PublicBookRequestInfoApiRepository()
      : super(DefaultJsonDecoder<UserData>((json) => UserData.fromJson(json)));

  Future<get_response.Response<UserData>> get_info() async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBooksRegisterPublicStatusGet();

  print(chopperResult.body);
  print(chopperResult.statusCode);
    // Return the correctly typed response
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: null,
    );
  }
}

class BookUploadResponse {
  int? id;
  String? title;
  AuthorResponse? author;
  Publisher? publisher;
  int? publicationYear;
  String? isbn;
  double? price;
  String? description;
  String? resourceType;
  String? language;
  int? pageCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? deleted;
  List<Category> category;
  String? createdBy;
  String? updatedBy;
  String? excerpt;
  String? authorEvaluation;
  List<BookImage> images;
  int? readingTime;
  int? numberOfChapters;
  String? uploadedBy;
  List<TagModel> tags;
  PublicBookRequestResponse? publicBookRequestResponse;
  int? ageAverage;
  int? status;
  List<BookChapter>? chapters;
  BookReviewResponse? bookReviewResponse;

  BookUploadResponse({
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
    this.category = const [],
    this.createdBy,
    this.updatedBy,
    this.excerpt,
    this.authorEvaluation,
    this.images = const [],
    this.readingTime,
    this.numberOfChapters,
    this.uploadedBy,
    this.tags = const [],
    this.publicBookRequestResponse,
    this.ageAverage,
    this.status,
    this.chapters = const [],
    this.bookReviewResponse,
  });

  factory BookUploadResponse.fromJson(Map<String, dynamic> json) => BookUploadResponse(
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
        status: json['status'] as int?,
        chapters: (json['chapters'] as List<dynamic>?)
                ?.map((e) => BookChapter.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        bookReviewResponse: json['bookReviewResponse'] == null
            ? null
            : BookReviewResponse.fromJson(
                json['bookReviewResponse'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author?.toJson(),
        'publisher': publisher?.toJson(),
        'publicationYear': publicationYear,
        'isbn': isbn,
        'price': price,
        'description': description,
        'resourceType': resourceType,
        'language': language,
        'pageCount': pageCount,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'deleted': deleted,
        'category': category.map((e) => e.toJson()).toList(),
        'createdBy': createdBy,
        'updatedBy': updatedBy,
        'excerpt': excerpt,
        'authorEvaluation': authorEvaluation,
        'images': images.map((e) => e.toJson()).toList(),
        'readingTime': readingTime,
        'numberOfChapters': numberOfChapters,
        'uploadedBy': uploadedBy,
        'tags': tags.map((e) => e.toJson()).toList(),
        'publicBookRequestResponse': publicBookRequestResponse?.toJson(),
        'ageAverage': ageAverage,
        'status': status,
        'chapters': chapters!.map((e) => e.toJson()).toList(),
        'bookReviewResponse': bookReviewResponse?.toJson(),
      };

      Book toBook() {
    return Book(
      id: id,
      title: title,
      author: author,
      publisher: publisher,
      publicationYear: publicationYear,
      isbn: isbn,
      price: price,
      description: description,
      resourceType: resourceType,
      language: language,
      pageCount: pageCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deleted: deleted,
      category: category,
      createdBy: createdBy,
      updatedBy: updatedBy,
      excerpt: excerpt,
      authorEvaluation: authorEvaluation,
      images: images,
      readingTime: readingTime,
      numberOfChapters: numberOfChapters,
      uploadedBy: uploadedBy,
      tags: tags,
      publicBookRequestResponse: publicBookRequestResponse,
      ageAverage: ageAverage,
      status: status == 1, // Converting int status to bool for the Book class
      chapters: chapters,
      bookReviewResponse: bookReviewResponse,
    );
  }
}


class PublicABookRequestApiRepository extends OpenApiRepository<BaseResponse> {
  PublicABookRequestApiRepository()
      : super(DefaultJsonDecoder<BaseResponse>((json) => BaseResponse.fromJson(json)));

  Future<get_response.Response<BaseResponse>> pubic_a_book(int? bookId) async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppBooksPublicBookGet(bookId: bookId);

    // Cast chopperResult.body to BaseResponse and wrap it in get_response.Response
    final BaseResponse response =
        BaseResponse.fromJson(chopperResult.body as Map<String, dynamic>);

    // Return the correctly typed response
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }
}