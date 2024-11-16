// ignore_for_file: type=lint


import 'openapi.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart' as chopper;
import 'openapi.enums.swagger.dart' as enums;
export 'openapi.enums.swagger.dart';
export 'openapi.models.swagger.dart';

part 'openapi.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Openapi extends ChopperService {
  static Openapi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Openapi(client);
    }

    final newClient = ChopperClient(
        services: [_$Openapi()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$Openapi(newClient);
  }

  ///Get all Book Report with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<ContentModeration>>> apiAdminBookReportGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        ContentModeration, () => ContentModeration.fromJsonFactory);

    return _apiAdminBookReportGet(page: page, limit: limit);
  }

  ///Get all Book Report with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/book/report')
  Future<chopper.Response<List<ContentModeration>>> _apiAdminBookReportGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Book Report by ID
  ///@param id ID of the Book Report to retrieve
  Future<chopper.Response<ContentModeration>> apiAdminBookReportIdGet(
      {required int? id}) {
    generatedMapping.putIfAbsent(
        ContentModeration, () => ContentModeration.fromJsonFactory);

    return _apiAdminBookReportIdGet(id: id);
  }

  ///Get Book Report by ID
  ///@param id ID of the Book Report to retrieve
  @Get(path: '/api/admin/book/report/{id}')
  Future<chopper.Response<ContentModeration>> _apiAdminBookReportIdGet(
      {@Path('id') required int? id});

  ///Update Book Report
  ///@param id ID of the Book Report to update
  Future<chopper.Response> apiAdminBookReportIdPut({
    required int? id,
    required ContentModerationRequest? body,
  }) {
    return _apiAdminBookReportIdPut(id: id, body: body);
  }

  ///Update Book Report
  ///@param id ID of the Book Report to update
  @Put(
    path: '/api/admin/book/report/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminBookReportIdPut({
    @Path('id') required int? id,
    @Body() required ContentModerationRequest? body,
  });

  ///Delete a file
  ///@param filename
  Future<chopper.Response> apiAdminFileDeleteFilenameDelete(
      {required String? filename}) {
    return _apiAdminFileDeleteFilenameDelete(filename: filename);
  }

  ///Delete a file
  ///@param filename
  @Delete(path: '/api/admin/file/delete/{filename}')
  Future<chopper.Response> _apiAdminFileDeleteFilenameDelete(
      {@Path('filename') required String? filename});

  ///Download a file
  ///@param filename
  Future<chopper.Response> apiAdminFileDownloadFilenameGet(
      {required String? filename}) {
    return _apiAdminFileDownloadFilenameGet(filename: filename);
  }

  ///Download a file
  ///@param filename
  @Get(path: '/api/admin/file/download/{filename}')
  Future<chopper.Response> _apiAdminFileDownloadFilenameGet(
      {@Path('filename') required String? filename});

  ///Upload a file
  Future<chopper.Response> apiAdminFileUploadPost(
      {required AdminFileUploadFormRequest body}) {
    return _apiAdminFileUploadPost(body: body);
  }

  ///Upload a file
  @Post(
    path: '/api/admin/file/upload',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response> _apiAdminFileUploadPost(
      {@Part() required AdminFileUploadFormRequest body});

  ///View an image file
  ///@param filename
  Future<chopper.Response> apiAdminFileViewFilenameGet(
      {required String? filename}) {
    return _apiAdminFileViewFilenameGet(filename: filename);
  }

  ///View an image file
  ///@param filename
  @Get(path: '/api/admin/file/view/{filename}')
  Future<chopper.Response> _apiAdminFileViewFilenameGet(
      {@Path('filename') required String? filename});

  ///
  Future<chopper.Response<int>> apiAdminAuthorsCreateIdPost() {
    return _apiAdminAuthorsCreateIdPost();
  }

  ///
  @Post(
    path: '/api/admin/authors/createId',
    optionalBody: true,
  )
  Future<chopper.Response<int>> _apiAdminAuthorsCreateIdPost();

  ///Filter and Sort Authors
  Future<chopper.Response<List<Author>>> apiAdminAuthorsFilterPost(
      {required FilterRequest? body}) {
    generatedMapping.putIfAbsent(Author, () => Author.fromJsonFactory);

    return _apiAdminAuthorsFilterPost(body: body);
  }

  ///Filter and Sort Authors
  @Post(
    path: '/api/admin/authors/filter',
    optionalBody: true,
  )
  Future<chopper.Response<List<Author>>> _apiAdminAuthorsFilterPost(
      {@Body() required FilterRequest? body});

  ///Get all authors with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Author>>> apiAdminAuthorsGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Author, () => Author.fromJsonFactory);

    return _apiAdminAuthorsGet(page: page, limit: limit);
  }

  ///Get all authors with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/authors')
  Future<chopper.Response<List<Author>>> _apiAdminAuthorsGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Author by ID
  ///@param id ID of the author to retrieve
  Future<chopper.Response<Author>> apiAdminAuthorsIdGet({required int? id}) {
    generatedMapping.putIfAbsent(Author, () => Author.fromJsonFactory);

    return _apiAdminAuthorsIdGet(id: id);
  }

  ///Get Author by ID
  ///@param id ID of the author to retrieve
  @Get(path: '/api/admin/authors/{id}')
  Future<chopper.Response<Author>> _apiAdminAuthorsIdGet(
      {@Path('id') required int? id});

  ///Update Author
  ///@param id ID of the author to update
  Future<chopper.Response> apiAdminAuthorsIdPut({
    required int? id,
    required AuthorRequest? body,
  }) {
    return _apiAdminAuthorsIdPut(id: id, body: body);
  }

  ///Update Author
  ///@param id ID of the author to update
  @Put(
    path: '/api/admin/authors/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminAuthorsIdPut({
    @Path('id') required int? id,
    @Body() required AuthorRequest? body,
  });

  ///Soft Delete Author
  ///@param id ID of the author to delete
  Future<chopper.Response> apiAdminAuthorsIdDelete({required int? id}) {
    return _apiAdminAuthorsIdDelete(id: id);
  }

  ///Soft Delete Author
  ///@param id ID of the author to delete
  @Delete(path: '/api/admin/authors/{id}')
  Future<chopper.Response> _apiAdminAuthorsIdDelete(
      {@Path('id') required int? id});

  ///Upload image
  Future<chopper.Response> apiAdminAuthorsUploadImagePost(
      {required AuthorImageFormRequest body}) {
    return _apiAdminAuthorsUploadImagePost(body: body);
  }

  ///Upload image
  @Post(
    path: '/api/admin/authors/uploadImage',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response> _apiAdminAuthorsUploadImagePost(
      {@Part() required AuthorImageFormRequest body});

  ///
  Future<chopper.Response<int>> apiAdminBooksCreateIdPost() {
    return _apiAdminBooksCreateIdPost();
  }

  ///
  @Post(
    path: '/api/admin/books/createId',
    optionalBody: true,
  )
  Future<chopper.Response<int>> _apiAdminBooksCreateIdPost();

  ///Delete Chapter
  ///@param id ID of the chapter to delete
  ///@param bookId ID of book
  Future<chopper.Response> apiAdminBooksDeleteChapterIdBookIdDelete({
    required int? id,
    required int? bookId,
  }) {
    return _apiAdminBooksDeleteChapterIdBookIdDelete(id: id, bookId: bookId);
  }

  ///Delete Chapter
  ///@param id ID of the chapter to delete
  ///@param bookId ID of book
  @Delete(path: '/api/admin/books/deleteChapter/{id}/{bookId}')
  Future<chopper.Response> _apiAdminBooksDeleteChapterIdBookIdDelete({
    @Path('id') required int? id,
    @Path('bookId') required int? bookId,
  });

  ///Delete Image
  ///@param id ID of the image to delete
  Future<chopper.Response> apiAdminBooksDeleteImageIdDelete(
      {required int? id}) {
    return _apiAdminBooksDeleteImageIdDelete(id: id);
  }

  ///Delete Image
  ///@param id ID of the image to delete
  @Delete(path: '/api/admin/books/deleteImage/{id}')
  Future<chopper.Response> _apiAdminBooksDeleteImageIdDelete(
      {@Path('id') required int? id});

  ///Filter and Sort Books
  Future<chopper.Response<List<Book>>> apiAdminBooksFilterPost(
      {required FilterRequest? body}) {
    generatedMapping.putIfAbsent(Book, () => Book.fromJsonFactory);

    return _apiAdminBooksFilterPost(body: body);
  }

  ///Filter and Sort Books
  @Post(
    path: '/api/admin/books/filter',
    optionalBody: true,
  )
  Future<chopper.Response<List<Book>>> _apiAdminBooksFilterPost(
      {@Body() required FilterRequest? body});

  ///Get all books with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Book>>> apiAdminBooksGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Book, () => Book.fromJsonFactory);

    return _apiAdminBooksGet(page: page, limit: limit);
  }

  ///Get all books with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/books')
  Future<chopper.Response<List<Book>>> _apiAdminBooksGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Book by ID
  ///@param id ID of the book to retrieve
  Future<chopper.Response<Book>> apiAdminBooksIdGet({required int? id}) {
    generatedMapping.putIfAbsent(Book, () => Book.fromJsonFactory);

    return _apiAdminBooksIdGet(id: id);
  }

  ///Get Book by ID
  ///@param id ID of the book to retrieve
  @Get(path: '/api/admin/books/{id}')
  Future<chopper.Response<Book>> _apiAdminBooksIdGet(
      {@Path('id') required int? id});

  ///Update Book
  ///@param id ID of the book to update
  Future<chopper.Response> apiAdminBooksIdPut({
    required int? id,
    required BookRequest? body,
  }) {
    return _apiAdminBooksIdPut(id: id, body: body);
  }

  ///Update Book
  ///@param id ID of the book to update
  @Put(
    path: '/api/admin/books/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminBooksIdPut({
    @Path('id') required int? id,
    @Body() required BookRequest? body,
  });

  ///Soft Delete Book
  ///@param id ID of the book to delete
  Future<chopper.Response> apiAdminBooksIdDelete({required int? id}) {
    return _apiAdminBooksIdDelete(id: id);
  }

  ///Soft Delete Book
  ///@param id ID of the book to delete
  @Delete(path: '/api/admin/books/{id}')
  Future<chopper.Response> _apiAdminBooksIdDelete(
      {@Path('id') required int? id});

  ///Upload book file
  Future<chopper.Response> apiAdminBooksUploadChapterPost(
      {required AdminBookUploadFormRequest body}) {
    return _apiAdminBooksUploadChapterPost(body: body);
  }

  ///Upload book file
  @Post(
    path: '/api/admin/books/uploadChapter',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response> _apiAdminBooksUploadChapterPost(
      {@Part() required AdminBookUploadFormRequest body});

  ///Upload image
  Future<chopper.Response> apiAdminBooksUploadImagePost(
      {required BookImageFormRequest body}) {
    return _apiAdminBooksUploadImagePost(body: body);
  }

  ///Upload image
  @Post(
    path: '/api/admin/books/uploadImage',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response> _apiAdminBooksUploadImagePost(
      {@Part() required BookImageFormRequest body});

  ///Filter and Sort BookComments
  Future<chopper.Response<List<BookComment>>> apiAdminBookCommentsFilterPost(
      {required FilterRequest? body}) {
    generatedMapping.putIfAbsent(
        BookComment, () => BookComment.fromJsonFactory);

    return _apiAdminBookCommentsFilterPost(body: body);
  }

  ///Filter and Sort BookComments
  @Post(
    path: '/api/admin/bookComments/filter',
    optionalBody: true,
  )
  Future<chopper.Response<List<BookComment>>> _apiAdminBookCommentsFilterPost(
      {@Body() required FilterRequest? body});

  ///Get all bookComments with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<BookComment>>> apiAdminBookCommentsGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        BookComment, () => BookComment.fromJsonFactory);

    return _apiAdminBookCommentsGet(page: page, limit: limit);
  }

  ///Get all bookComments with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/bookComments')
  Future<chopper.Response<List<BookComment>>> _apiAdminBookCommentsGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get BookComment by ID
  ///@param id ID of the author to retrieve
  Future<chopper.Response<BookComment>> apiAdminBookCommentsIdGet(
      {required int? id}) {
    generatedMapping.putIfAbsent(
        BookComment, () => BookComment.fromJsonFactory);

    return _apiAdminBookCommentsIdGet(id: id);
  }

  ///Get BookComment by ID
  ///@param id ID of the author to retrieve
  @Get(path: '/api/admin/bookComments/{id}')
  Future<chopper.Response<BookComment>> _apiAdminBookCommentsIdGet(
      {@Path('id') required int? id});

  ///Soft Delete BookComment
  ///@param id ID of the author to delete
  Future<chopper.Response> apiAdminBookCommentsIdDelete({required int? id}) {
    return _apiAdminBookCommentsIdDelete(id: id);
  }

  ///Soft Delete BookComment
  ///@param id ID of the author to delete
  @Delete(path: '/api/admin/bookComments/{id}')
  Future<chopper.Response> _apiAdminBookCommentsIdDelete(
      {@Path('id') required int? id});

  ///Filter and Sort BookReviews
  Future<chopper.Response<List<BookReview>>> apiAdminBookRatingFilterPost(
      {required FilterRequest? body}) {
    generatedMapping.putIfAbsent(BookReview, () => BookReview.fromJsonFactory);

    return _apiAdminBookRatingFilterPost(body: body);
  }

  ///Filter and Sort BookReviews
  @Post(
    path: '/api/admin/bookRating/filter',
    optionalBody: true,
  )
  Future<chopper.Response<List<BookReview>>> _apiAdminBookRatingFilterPost(
      {@Body() required FilterRequest? body});

  ///Get all bookReviews with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<BookReview>>> apiAdminBookRatingGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(BookReview, () => BookReview.fromJsonFactory);

    return _apiAdminBookRatingGet(page: page, limit: limit);
  }

  ///Get all bookReviews with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/bookRating')
  Future<chopper.Response<List<BookReview>>> _apiAdminBookRatingGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get BookReview by ID
  ///@param id ID of the bookReview to retrieve
  Future<chopper.Response<BookReview>> apiAdminBookRatingIdGet(
      {required int? id}) {
    generatedMapping.putIfAbsent(BookReview, () => BookReview.fromJsonFactory);

    return _apiAdminBookRatingIdGet(id: id);
  }

  ///Get BookReview by ID
  ///@param id ID of the bookReview to retrieve
  @Get(path: '/api/admin/bookRating/{id}')
  Future<chopper.Response<BookReview>> _apiAdminBookRatingIdGet(
      {@Path('id') required int? id});

  ///Soft Delete BookReview
  ///@param id ID of the bookReview to delete
  Future<chopper.Response> apiAdminBookRatingIdDelete({required int? id}) {
    return _apiAdminBookRatingIdDelete(id: id);
  }

  ///Soft Delete BookReview
  ///@param id ID of the bookReview to delete
  @Delete(path: '/api/admin/bookRating/{id}')
  Future<chopper.Response> _apiAdminBookRatingIdDelete(
      {@Path('id') required int? id});

  ///Get all categories with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Category>>> apiAdminCategoriesGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Category, () => Category.fromJsonFactory);

    return _apiAdminCategoriesGet(page: page, limit: limit);
  }

  ///Get all categories with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/categories')
  Future<chopper.Response<List<Category>>> _apiAdminCategoriesGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Add Category
  Future<chopper.Response> apiAdminCategoriesPost(
      {required CategoryRequest? body}) {
    return _apiAdminCategoriesPost(body: body);
  }

  ///Add Category
  @Post(
    path: '/api/admin/categories',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminCategoriesPost(
      {@Body() required CategoryRequest? body});

  ///Filter and Sort Categories
  Future<chopper.Response<List<Category>>> apiAdminCategoriesFilterPost(
      {required FilterRequest? body}) {
    generatedMapping.putIfAbsent(Category, () => Category.fromJsonFactory);

    return _apiAdminCategoriesFilterPost(body: body);
  }

  ///Filter and Sort Categories
  @Post(
    path: '/api/admin/categories/filter',
    optionalBody: true,
  )
  Future<chopper.Response<List<Category>>> _apiAdminCategoriesFilterPost(
      {@Body() required FilterRequest? body});

  ///Get Category by ID
  ///@param id ID of the category to retrieve
  Future<chopper.Response<Category>> apiAdminCategoriesIdGet(
      {required int? id}) {
    generatedMapping.putIfAbsent(Category, () => Category.fromJsonFactory);

    return _apiAdminCategoriesIdGet(id: id);
  }

  ///Get Category by ID
  ///@param id ID of the category to retrieve
  @Get(path: '/api/admin/categories/{id}')
  Future<chopper.Response<Category>> _apiAdminCategoriesIdGet(
      {@Path('id') required int? id});

  ///Update Category
  ///@param id ID of the category to update
  Future<chopper.Response> apiAdminCategoriesIdPut({
    required int? id,
    required CategoryRequest? body,
  }) {
    return _apiAdminCategoriesIdPut(id: id, body: body);
  }

  ///Update Category
  ///@param id ID of the category to update
  @Put(
    path: '/api/admin/categories/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminCategoriesIdPut({
    @Path('id') required int? id,
    @Body() required CategoryRequest? body,
  });

  ///Soft Delete Category
  ///@param id ID of the category to delete
  Future<chopper.Response> apiAdminCategoriesIdDelete({required int? id}) {
    return _apiAdminCategoriesIdDelete(id: id);
  }

  ///Soft Delete Category
  ///@param id ID of the category to delete
  @Delete(path: '/api/admin/categories/{id}')
  Future<chopper.Response> _apiAdminCategoriesIdDelete(
      {@Path('id') required int? id});

  ///Filter and Sort Orders
  Future<chopper.Response<List<Order>>> apiAdminOrdersFilterPost(
      {required FilterRequest? body}) {
    generatedMapping.putIfAbsent(Order, () => Order.fromJsonFactory);

    return _apiAdminOrdersFilterPost(body: body);
  }

  ///Filter and Sort Orders
  @Post(
    path: '/api/admin/orders/filter',
    optionalBody: true,
  )
  Future<chopper.Response<List<Order>>> _apiAdminOrdersFilterPost(
      {@Body() required FilterRequest? body});

  ///Get all authors with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Order>>> apiAdminOrdersGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Order, () => Order.fromJsonFactory);

    return _apiAdminOrdersGet(page: page, limit: limit);
  }

  ///Get all authors with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/orders')
  Future<chopper.Response<List<Order>>> _apiAdminOrdersGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Order by ID
  ///@param id ID of the order to retrieve
  Future<chopper.Response<Order>> apiAdminOrdersIdGet({required int? id}) {
    generatedMapping.putIfAbsent(Order, () => Order.fromJsonFactory);

    return _apiAdminOrdersIdGet(id: id);
  }

  ///Get Order by ID
  ///@param id ID of the order to retrieve
  @Get(path: '/api/admin/orders/{id}')
  Future<chopper.Response<Order>> _apiAdminOrdersIdGet(
      {@Path('id') required int? id});

  ///Update Order
  ///@param id ID of the order to update
  Future<chopper.Response> apiAdminOrdersIdPut({
    required int? id,
    required OrderRequest? body,
  }) {
    return _apiAdminOrdersIdPut(id: id, body: body);
  }

  ///Update Order
  ///@param id ID of the order to update
  @Put(
    path: '/api/admin/orders/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminOrdersIdPut({
    @Path('id') required int? id,
    @Body() required OrderRequest? body,
  });

  ///Soft Delete Order
  ///@param id ID of the order to delete
  Future<chopper.Response> apiAdminOrdersIdDelete({required int? id}) {
    return _apiAdminOrdersIdDelete(id: id);
  }

  ///Soft Delete Order
  ///@param id ID of the order to delete
  @Delete(path: '/api/admin/orders/{id}')
  Future<chopper.Response> _apiAdminOrdersIdDelete(
      {@Path('id') required int? id});

  ///Change status of register public book
  ///@param id
  ///@param status Value of status: Rejected, Approved
  Future<chopper.Response>
      apiAdminPublicBookRegisterPublicBookChangeStatusPost({
    int? id,
    String? status,
  }) {
    return _apiAdminPublicBookRegisterPublicBookChangeStatusPost(
        id: id, status: status);
  }

  ///Change status of register public book
  ///@param id
  ///@param status Value of status: Rejected, Approved
  @Post(
    path: '/api/admin/publicBook/registerPublicBook/changeStatus',
    optionalBody: true,
  )
  Future<chopper.Response>
      _apiAdminPublicBookRegisterPublicBookChangeStatusPost({
    @Query('id') int? id,
    @Query('status') String? status,
  });

  ///Check public book request status
  ///@param id
  Future<chopper.Response> apiAdminPublicBookCheckPublicBookRequestStatusGet(
      {int? id}) {
    return _apiAdminPublicBookCheckPublicBookRequestStatusGet(id: id);
  }

  ///Check public book request status
  ///@param id
  @Get(path: '/api/admin/publicBook/checkPublicBookRequestStatus')
  Future<chopper.Response> _apiAdminPublicBookCheckPublicBookRequestStatusGet(
      {@Query('id') int? id});

  ///Get all Public Book Request with pagination
  ///@param page
  ///@param limit
  ///@param status Value of Status: Pending, Reject ,All
  Future<chopper.Response<List<PublicBookRequest>>> apiAdminPublicBookGet({
    int? page,
    int? limit,
    String? status,
  }) {
    generatedMapping.putIfAbsent(
        PublicBookRequest, () => PublicBookRequest.fromJsonFactory);

    return _apiAdminPublicBookGet(page: page, limit: limit, status: status);
  }

  ///Get all Public Book Request with pagination
  ///@param page
  ///@param limit
  ///@param status Value of Status: Pending, Reject ,All
  @Get(path: '/api/admin/publicBook')
  Future<chopper.Response<List<PublicBookRequest>>> _apiAdminPublicBookGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('status') String? status,
  });

  ///Get Public Book Request by ID
  ///@param id ID of the Public Book Request to retrieve
  Future<chopper.Response<PublicBookRequest>> apiAdminPublicBookIdGet(
      {required int? id}) {
    generatedMapping.putIfAbsent(
        PublicBookRequest, () => PublicBookRequest.fromJsonFactory);

    return _apiAdminPublicBookIdGet(id: id);
  }

  ///Get Public Book Request by ID
  ///@param id ID of the Public Book Request to retrieve
  @Get(path: '/api/admin/publicBook/{id}')
  Future<chopper.Response<PublicBookRequest>> _apiAdminPublicBookIdGet(
      {@Path('id') required int? id});

  ///List register public book
  ///@param page
  ///@param limit
  ///@param status Value of Status: Pending, All
  Future<chopper.Response> apiAdminPublicBookListRegisterPublicBookGet({
    int? page,
    int? limit,
    String? status,
  }) {
    return _apiAdminPublicBookListRegisterPublicBookGet(
        page: page, limit: limit, status: status);
  }

  ///List register public book
  ///@param page
  ///@param limit
  ///@param status Value of Status: Pending, All
  @Get(path: '/api/admin/publicBook/listRegisterPublicBook')
  Future<chopper.Response> _apiAdminPublicBookListRegisterPublicBookGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('status') String? status,
  });

  ///Update Public Book Request Status
  ///@param id ID of the Public Book Request to update
  ///@param status New status for the Public Book Request. Allowed values are PUBLIC, UNPUBLIC, REJECT, WAITING, NEW.
  Future<chopper.Response> apiAdminPublicBookIdStatusPost({
    required int? id,
    required enums.ApiAdminPublicBookIdStatusPostStatus? status,
  }) {
    return _apiAdminPublicBookIdStatusPost(
        id: id, status: status?.value?.toString());
  }

  ///Update Public Book Request Status
  ///@param id ID of the Public Book Request to update
  ///@param status New status for the Public Book Request. Allowed values are PUBLIC, UNPUBLIC, REJECT, WAITING, NEW.
  @Post(
    path: '/api/admin/publicBook/{id}/status',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminPublicBookIdStatusPost({
    @Path('id') required int? id,
    @Query('status') required String? status,
  });

  ///Get all publishers with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Publisher>>> apiAdminPublisherGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Publisher, () => Publisher.fromJsonFactory);

    return _apiAdminPublisherGet(page: page, limit: limit);
  }

  ///Get all publishers with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/publisher')
  Future<chopper.Response<List<Publisher>>> _apiAdminPublisherGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Add Publisher
  Future<chopper.Response> apiAdminPublisherPost(
      {required PublisherRequest? body}) {
    return _apiAdminPublisherPost(body: body);
  }

  ///Add Publisher
  @Post(
    path: '/api/admin/publisher',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminPublisherPost(
      {@Body() required PublisherRequest? body});

  ///Filter and Sort Publishers
  Future<chopper.Response<List<Publisher>>> apiAdminPublisherFilterPost(
      {required FilterRequest? body}) {
    generatedMapping.putIfAbsent(Publisher, () => Publisher.fromJsonFactory);

    return _apiAdminPublisherFilterPost(body: body);
  }

  ///Filter and Sort Publishers
  @Post(
    path: '/api/admin/publisher/filter',
    optionalBody: true,
  )
  Future<chopper.Response<List<Publisher>>> _apiAdminPublisherFilterPost(
      {@Body() required FilterRequest? body});

  ///Get Publisher by ID
  ///@param id ID of the publisher to retrieve
  Future<chopper.Response<Publisher>> apiAdminPublisherIdGet(
      {required int? id}) {
    generatedMapping.putIfAbsent(Publisher, () => Publisher.fromJsonFactory);

    return _apiAdminPublisherIdGet(id: id);
  }

  ///Get Publisher by ID
  ///@param id ID of the publisher to retrieve
  @Get(path: '/api/admin/publisher/{id}')
  Future<chopper.Response<Publisher>> _apiAdminPublisherIdGet(
      {@Path('id') required int? id});

  ///Update Publisher
  ///@param id ID of the publisher to update
  Future<chopper.Response> apiAdminPublisherIdPut({
    required int? id,
    required PublisherRequest? body,
  }) {
    return _apiAdminPublisherIdPut(id: id, body: body);
  }

  ///Update Publisher
  ///@param id ID of the publisher to update
  @Put(
    path: '/api/admin/publisher/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminPublisherIdPut({
    @Path('id') required int? id,
    @Body() required PublisherRequest? body,
  });

  ///Soft Delete Publisher
  ///@param id ID of the publisher to delete
  Future<chopper.Response> apiAdminPublisherIdDelete({required int? id}) {
    return _apiAdminPublisherIdDelete(id: id);
  }

  ///Soft Delete Publisher
  ///@param id ID of the publisher to delete
  @Delete(path: '/api/admin/publisher/{id}')
  Future<chopper.Response> _apiAdminPublisherIdDelete(
      {@Path('id') required int? id});

  ///Get all tags with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<TagModel>>> apiAdminTagsGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(TagModel, () => TagModel.fromJsonFactory);

    return _apiAdminTagsGet(page: page, limit: limit);
  }

  ///Get all tags with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/tags')
  Future<chopper.Response<List<TagModel>>> _apiAdminTagsGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Add Tag
  Future<chopper.Response> apiAdminTagsPost({required TagRequest? body}) {
    return _apiAdminTagsPost(body: body);
  }

  ///Add Tag
  @Post(
    path: '/api/admin/tags',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminTagsPost(
      {@Body() required TagRequest? body});

  ///Filter and Sort Tags
  Future<chopper.Response<List<TagModel>>> apiAdminTagsFilterPost(
      {required FilterRequest? body}) {
    generatedMapping.putIfAbsent(TagModel, () => TagModel.fromJsonFactory);

    return _apiAdminTagsFilterPost(body: body);
  }

  ///Filter and Sort Tags
  @Post(
    path: '/api/admin/tags/filter',
    optionalBody: true,
  )
  Future<chopper.Response<List<TagModel>>> _apiAdminTagsFilterPost(
      {@Body() required FilterRequest? body});

  ///Get Tag by ID
  ///@param id ID of the tag to retrieve
  Future<chopper.Response<TagModel>> apiAdminTagsIdGet({required int? id}) {
    generatedMapping.putIfAbsent(TagModel, () => TagModel.fromJsonFactory);

    return _apiAdminTagsIdGet(id: id);
  }

  ///Get Tag by ID
  ///@param id ID of the tag to retrieve
  @Get(path: '/api/admin/tags/{id}')
  Future<chopper.Response<TagModel>> _apiAdminTagsIdGet(
      {@Path('id') required int? id});

  ///Update Tag
  ///@param id ID of the tag to update
  Future<chopper.Response> apiAdminTagsIdPut({
    required int? id,
    required TagRequest? body,
  }) {
    return _apiAdminTagsIdPut(id: id, body: body);
  }

  ///Update Tag
  ///@param id ID of the tag to update
  @Put(
    path: '/api/admin/tags/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminTagsIdPut({
    @Path('id') required int? id,
    @Body() required TagRequest? body,
  });

  ///Soft Delete Tag
  ///@param id ID of the tag to delete
  Future<chopper.Response> apiAdminTagsIdDelete({required int? id}) {
    return _apiAdminTagsIdDelete(id: id);
  }

  ///Soft Delete Tag
  ///@param id ID of the tag to delete
  @Delete(path: '/api/admin/tags/{id}')
  Future<chopper.Response> _apiAdminTagsIdDelete(
      {@Path('id') required int? id});

  ///Admin login
  Future<chopper.Response> apiAdminUserapiLoginPost(
      {required AdminLoginFormRequest? body}) {
    return _apiAdminUserapiLoginPost(body: body);
  }

  ///Admin login
  @Post(
    path: '/api/admin/userapi/login',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminUserapiLoginPost(
      {@Body() required AdminLoginFormRequest? body});

  ///Get all vouchers with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Voucher>>> apiAdminVoucherGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Voucher, () => Voucher.fromJsonFactory);

    return _apiAdminVoucherGet(page: page, limit: limit);
  }

  ///Get all vouchers with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/admin/voucher')
  Future<chopper.Response<List<Voucher>>> _apiAdminVoucherGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Add Voucher
  Future<chopper.Response> apiAdminVoucherPost(
      {required VoucherRequest? body}) {
    return _apiAdminVoucherPost(body: body);
  }

  ///Add Voucher
  @Post(
    path: '/api/admin/voucher',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminVoucherPost(
      {@Body() required VoucherRequest? body});

  ///Filter and Sort Vouchers
  Future<chopper.Response<List<Voucher>>> apiAdminVoucherFilterPost(
      {required FilterRequest? body}) {
    generatedMapping.putIfAbsent(Voucher, () => Voucher.fromJsonFactory);

    return _apiAdminVoucherFilterPost(body: body);
  }

  ///Filter and Sort Vouchers
  @Post(
    path: '/api/admin/voucher/filter',
    optionalBody: true,
  )
  Future<chopper.Response<List<Voucher>>> _apiAdminVoucherFilterPost(
      {@Body() required FilterRequest? body});

  ///Get Voucher by ID
  ///@param id ID of the voucher to retrieve
  Future<chopper.Response<Voucher>> apiAdminVoucherIdGet({required int? id}) {
    generatedMapping.putIfAbsent(Voucher, () => Voucher.fromJsonFactory);

    return _apiAdminVoucherIdGet(id: id);
  }

  ///Get Voucher by ID
  ///@param id ID of the voucher to retrieve
  @Get(path: '/api/admin/voucher/{id}')
  Future<chopper.Response<Voucher>> _apiAdminVoucherIdGet(
      {@Path('id') required int? id});

  ///Update Voucher
  ///@param id ID of the voucher to update
  Future<chopper.Response> apiAdminVoucherIdPut({
    required int? id,
    required VoucherRequest? body,
  }) {
    return _apiAdminVoucherIdPut(id: id, body: body);
  }

  ///Update Voucher
  ///@param id ID of the voucher to update
  @Put(
    path: '/api/admin/voucher/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAdminVoucherIdPut({
    @Path('id') required int? id,
    @Body() required VoucherRequest? body,
  });

  ///Soft Delete Voucher
  ///@param id ID of the voucher to delete
  Future<chopper.Response> apiAdminVoucherIdDelete({required int? id}) {
    return _apiAdminVoucherIdDelete(id: id);
  }

  ///Soft Delete Voucher
  ///@param id ID of the voucher to delete
  @Delete(path: '/api/admin/voucher/{id}')
  Future<chopper.Response> _apiAdminVoucherIdDelete(
      {@Path('id') required int? id});

  ///Check book purchased
  ///@param bookId book id
  Future<chopper.Response> apiAppOrderCheckBookPurchasedGet({int? bookId}) {
    return _apiAppOrderCheckBookPurchasedGet(bookId: bookId);
  }

  ///Check book purchased
  ///@param bookId book id
  @Get(path: '/api/app/order/checkBookPurchased')
  Future<chopper.Response> _apiAppOrderCheckBookPurchasedGet(
      {@Query('bookId') int? bookId});

  ///List order of user
  ///@param page
  ///@param limit
  Future<chopper.Response> apiAppOrderListOrderGet({
    int? page,
    int? limit,
  }) {
    return _apiAppOrderListOrderGet(page: page, limit: limit);
  }

  ///List order of user
  ///@param page
  ///@param limit
  @Get(path: '/api/app/order/listOrder')
  Future<chopper.Response> _apiAppOrderListOrderGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Make order
  Future<chopper.Response> apiAppOrderMakePost(
      {required MakeOrderRequest? body}) {
    return _apiAppOrderMakePost(body: body);
  }

  ///Make order
  @Post(
    path: '/api/app/order/make',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppOrderMakePost(
      {@Body() required MakeOrderRequest? body});

  ///Order detail
  ///@param orrderId
  Future<chopper.Response> apiAppOrderOrderDetailGet({int? orrderId}) {
    return _apiAppOrderOrderDetailGet(orrderId: orrderId);
  }

  ///Order detail
  ///@param orrderId
  @Get(path: '/api/app/order/orderDetail')
  Future<chopper.Response> _apiAppOrderOrderDetailGet(
      {@Query('orrderId') int? orrderId});

  ///Make order
  ///@param orderId
  Future<chopper.Response> apiAppOrderPayOrderPost({int? orderId}) {
    return _apiAppOrderPayOrderPost(orderId: orderId);
  }

  ///Make order
  ///@param orderId
  @Post(
    path: '/api/app/order/payOrder',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppOrderPayOrderPost(
      {@Query('orderId') int? orderId});

  ///Get order detail of book
  ///@param bookId
  ///@param orderId
  Future<chopper.Response> apiAppStatisticOrderDetailOfBookPost({
    int? bookId,
    int? orderId,
  }) {
    return _apiAppStatisticOrderDetailOfBookPost(
        bookId: bookId, orderId: orderId);
  }

  ///Get order detail of book
  ///@param bookId
  ///@param orderId
  @Post(
    path: '/api/app/statistic/orderDetailOfBook',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppStatisticOrderDetailOfBookPost({
    @Query('bookId') int? bookId,
    @Query('orderId') int? orderId,
  });

  ///Get revenue by book
  Future<chopper.Response> apiAppStatisticRevenueByBookPost() {
    return _apiAppStatisticRevenueByBookPost();
  }

  ///Get revenue by book
  @Post(
    path: '/api/app/statistic/revenueByBook',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppStatisticRevenueByBookPost();

  ///Get revenue of a book
  ///@param id
  Future<chopper.Response> apiAppStatisticRevenueOfBookPost({int? id}) {
    return _apiAppStatisticRevenueOfBookPost(id: id);
  }

  ///Get revenue of a book
  ///@param id
  @Post(
    path: '/api/app/statistic/revenueOfBook',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppStatisticRevenueOfBookPost(
      {@Query('id') int? id});

  ///Get sumary book upload
  Future<chopper.Response> apiAppStatisticSumaryMyUploadBookPost() {
    return _apiAppStatisticSumaryMyUploadBookPost();
  }

  ///Get sumary book upload
  @Post(
    path: '/api/app/statistic/sumaryMyUploadBook',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppStatisticSumaryMyUploadBookPost();

  ///Get user info
  Future<chopper.Response> apiAppUserInfoPost() {
    return _apiAppUserInfoPost();
  }

  ///Get user info
  @Post(
    path: '/api/app/user/info',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppUserInfoPost();

  ///Get all authors with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Author>>> apiAppAuthorsGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Author, () => Author.fromJsonFactory);

    return _apiAppAuthorsGet(page: page, limit: limit);
  }

  ///Get all authors with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/app/authors')
  Future<chopper.Response<List<Author>>> _apiAppAuthorsGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Author by ID
  ///@param id ID of the author to retrieve
  ///@param limit
  Future<chopper.Response<AuthorAppResponse>> apiAppAuthorsIdGet({
    required int? id,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AuthorAppResponse, () => AuthorAppResponse.fromJsonFactory);

    return _apiAppAuthorsIdGet(id: id, limit: limit);
  }

  ///Get Author by ID
  ///@param id ID of the author to retrieve
  ///@param limit
  @Get(path: '/api/app/authors/{id}')
  Future<chopper.Response<AuthorAppResponse>> _apiAppAuthorsIdGet({
    @Path('id') required int? id,
    @Query('limit') int? limit,
  });

  ///
  Future<chopper.Response<int>> apiAppBooksCreateIdPost() {
    return _apiAppBooksCreateIdPost();
  }

  ///
  @Post(
    path: '/api/app/books/createId',
    optionalBody: true,
  )
  Future<chopper.Response<int>> _apiAppBooksCreateIdPost();

  ///Delete Chapter
  ///@param id ID of the chapter to delete
  ///@param bookId ID of book
  Future<chopper.Response> apiAppBooksDeleteChapterIdBookIdDelete({
    required int? id,
    required int? bookId,
  }) {
    return _apiAppBooksDeleteChapterIdBookIdDelete(id: id, bookId: bookId);
  }

  ///Delete Chapter
  ///@param id ID of the chapter to delete
  ///@param bookId ID of book
  @Delete(path: '/api/app/books/deleteChapter/{id}/{bookId}')
  Future<chopper.Response> _apiAppBooksDeleteChapterIdBookIdDelete({
    @Path('id') required int? id,
    @Path('bookId') required int? bookId,
  });

  ///Delete Image
  ///@param id ID of the image to delete
  Future<chopper.Response> apiAppBooksDeleteImageIdDelete({required int? id}) {
    return _apiAppBooksDeleteImageIdDelete(id: id);
  }

  ///Delete Image
  ///@param id ID of the image to delete
  @Delete(path: '/api/app/books/deleteImage/{id}')
  Future<chopper.Response> _apiAppBooksDeleteImageIdDelete(
      {@Path('id') required int? id});

  ///Get Book by ID
  ///@param id ID of the book to retrieve
  Future<chopper.Response<Book>> apiAppBooksIdGet({required int? id}) {
    generatedMapping.putIfAbsent(Book, () => Book.fromJsonFactory);

    return _apiAppBooksIdGet(id: id);
  }

  ///Get Book by ID
  ///@param id ID of the book to retrieve
  @Get(path: '/api/app/books/{id}')
  Future<chopper.Response<Book>> _apiAppBooksIdGet(
      {@Path('id') required int? id});

  ///Update Book
  ///@param id ID of the book to update
  Future<chopper.Response> apiAppBooksIdPut({
    required int? id,
    required BookAppRequest? body,
  }) {
    return _apiAppBooksIdPut(id: id, body: body);
  }

  ///Update Book
  ///@param id ID of the book to update
  @Put(
    path: '/api/app/books/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBooksIdPut({
    @Path('id') required int? id,
    @Body() required BookAppRequest? body,
  });

  ///Get favourite book ID
  ///@param page
  ///@param limit
  ///@param categories
  ///@param authors
  Future<chopper.Response> apiAppBooksFavouriteListIdGet({
    int? page,
    int? limit,
    List<int>? categories,
    List<int>? authors,
  }) {
    return _apiAppBooksFavouriteListIdGet(
        page: page, limit: limit, categories: categories, authors: authors);
  }

  ///Get favourite book ID
  ///@param page
  ///@param limit
  ///@param categories
  ///@param authors
  @Get(path: '/api/app/books/favouriteListId')
  Future<chopper.Response> _apiAppBooksFavouriteListIdGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('categories') List<int>? categories,
    @Query('authors') List<int>? authors,
  });

  ///Get favourite books
  ///@param page
  ///@param limit
  ///@param categories
  ///@param authors
  Future<chopper.Response> apiAppBooksFavouriteListGet({
    int? page,
    int? limit,
    List<int>? categories,
    List<int>? authors,
  }) {
    return _apiAppBooksFavouriteListGet(
        page: page, limit: limit, categories: categories, authors: authors);
  }

  ///Get favourite books
  ///@param page
  ///@param limit
  ///@param categories
  ///@param authors
  @Get(path: '/api/app/books/favouriteList')
  Future<chopper.Response> _apiAppBooksFavouriteListGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('categories') List<int>? categories,
    @Query('authors') List<int>? authors,
  });

  ///Get favourite filter data
  Future<chopper.Response> apiAppBooksFavouriteFilterDataGet() {
    return _apiAppBooksFavouriteFilterDataGet();
  }

  ///Get favourite filter data
  @Get(path: '/api/app/books/favouriteFilterData')
  Future<chopper.Response> _apiAppBooksFavouriteFilterDataGet();

  ///Get my purchased books
  ///@param page
  ///@param limit
  ///@param sort Value for sort: Author, Date
  ///@param type Value for type: Asc, Desc
  Future<chopper.Response> apiAppBooksMyPurchasedBooksGet({
    int? page,
    int? limit,
    String? sort,
    String? type,
  }) {
    return _apiAppBooksMyPurchasedBooksGet(
        page: page, limit: limit, sort: sort, type: type);
  }

  ///Get my purchased books
  ///@param page
  ///@param limit
  ///@param sort Value for sort: Author, Date
  ///@param type Value for type: Asc, Desc
  @Get(path: '/api/app/books/myPurchasedBooks')
  Future<chopper.Response> _apiAppBooksMyPurchasedBooksGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('sort') String? sort,
    @Query('type') String? type,
  });

  ///Get my purchased books filter data
  Future<chopper.Response> apiAppBooksMyPurchasedBooksFilterDataGet() {
    return _apiAppBooksMyPurchasedBooksFilterDataGet();
  }

  ///Get my purchased books filter data
  @Get(path: '/api/app/books/myPurchasedBooks/filterData')
  Future<chopper.Response> _apiAppBooksMyPurchasedBooksFilterDataGet();

  ///Get my upload books
  ///@param page
  ///@param limit
  ///@param isPublished isPublished
  ///@param sort Value for sort: Author, Date
  ///@param type Value for type: Asc, Desc
  Future<chopper.Response> apiAppBooksMyUploadBooksGet({
    int? page,
    int? limit,
    String? isPublished,
    String? sort,
    String? type,
  }) {
    return _apiAppBooksMyUploadBooksGet(
        page: page,
        limit: limit,
        isPublished: isPublished,
        sort: sort,
        type: type);
  }

  ///Get my upload books
  ///@param page
  ///@param limit
  ///@param isPublished isPublished
  ///@param sort Value for sort: Author, Date
  ///@param type Value for type: Asc, Desc
  @Get(path: '/api/app/books/myUploadBooks')
  Future<chopper.Response> _apiAppBooksMyUploadBooksGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('isPublished') String? isPublished,
    @Query('sort') String? sort,
    @Query('type') String? type,
  });

  ///Get my upload books filter data
  ///@param isPublished isPublished
  Future<chopper.Response> apiAppBooksMyUploadBooksFilterDataGet(
      {String? isPublished}) {
    return _apiAppBooksMyUploadBooksFilterDataGet(isPublished: isPublished);
  }

  ///Get my upload books filter data
  ///@param isPublished isPublished
  @Get(path: '/api/app/books/myUploadBooks/filterData')
  Future<chopper.Response> _apiAppBooksMyUploadBooksFilterDataGet(
      {@Query('isPublished') String? isPublished});

  ///Public a book
  ///@param bookId
  Future<chopper.Response> apiAppBooksPublicBookGet({int? bookId}) {
    return _apiAppBooksPublicBookGet(bookId: bookId);
  }

  ///Public a book
  ///@param bookId
  @Get(path: '/api/app/books/public/book')
  Future<chopper.Response> _apiAppBooksPublicBookGet(
      {@Query('bookId') int? bookId});

  ///
  Future<chopper.Response> apiAppBooksRegisterPublicPost() {
    return _apiAppBooksRegisterPublicPost();
  }

  ///
  @Post(
    path: '/api/app/books/registerPublic',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBooksRegisterPublicPost();

  ///Get status register public book
  Future<chopper.Response> apiAppBooksRegisterPublicStatusGet() {
    return _apiAppBooksRegisterPublicStatusGet();
  }

  ///Get status register public book
  @Get(path: '/api/app/books/registerPublic/status')
  Future<chopper.Response> _apiAppBooksRegisterPublicStatusGet();

  ///Make a book favourite
  ///@param bookId
  Future<chopper.Response> apiAppBooksToggleFavouriteGet({int? bookId}) {
    return _apiAppBooksToggleFavouriteGet(bookId: bookId);
  }

  ///Make a book favourite
  ///@param bookId
  @Get(path: '/api/app/books/toggleFavourite')
  Future<chopper.Response> _apiAppBooksToggleFavouriteGet(
      {@Query('bookId') int? bookId});

  ///Upload book file
  Future<chopper.Response> apiAppBooksUploadChapterWithGoogleDrivePost(
      {required BookChapterGoogleDriveRequest? body}) {
    return _apiAppBooksUploadChapterWithGoogleDrivePost(body: body);
  }

  ///Upload book file
  @Post(
    path: '/api/app/books/uploadChapterWithGoogleDrive',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBooksUploadChapterWithGoogleDrivePost(
      {@Body() required BookChapterGoogleDriveRequest? body});

  ///Upload book file
  Future<chopper.Response> apiAppBooksUploadChapterPost(
      {required AdminBookUploadFormRequest body}) {
    return _apiAppBooksUploadChapterPost(body: body);
  }

  ///Upload book file
  @Post(
    path: '/api/app/books/uploadChapter',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response> _apiAppBooksUploadChapterPost(
      {@Part() required AdminBookUploadFormRequest body});

  ///Upload image
  Future<chopper.Response> apiAppBooksUploadImagePost(
      {required BookImageFormRequest body}) {
    return _apiAppBooksUploadImagePost(body: body);
  }

  ///Upload image
  @Post(
    path: '/api/app/books/uploadImage',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response> _apiAppBooksUploadImagePost(
      {@Part() required BookImageFormRequest body});

  ///View book file
  ///@param fileName File name
  Future<chopper.Response> apiAppBooksViewBookGet({required String? fileName}) {
    return _apiAppBooksViewBookGet(fileName: fileName);
  }

  ///View book file
  ///@param fileName File name
  @Get(path: '/api/app/books/viewBook')
  Future<chopper.Response> _apiAppBooksViewBookGet(
      {@Query('fileName') required String? fileName});

  ///Create Comment
  Future<chopper.Response> apiAppBookCommentCreatePost(
      {required BookCommentRequest? body}) {
    return _apiAppBookCommentCreatePost(body: body);
  }

  ///Create Comment
  @Post(
    path: '/api/app/book-comment/create',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBookCommentCreatePost(
      {@Body() required BookCommentRequest? body});

  ///Delete Comment
  ///@param commentId ID of the comment
  Future<chopper.Response> apiAppBookCommentDeleteCommentIdDelete(
      {required int? commentId}) {
    return _apiAppBookCommentDeleteCommentIdDelete(commentId: commentId);
  }

  ///Delete Comment
  ///@param commentId ID of the comment
  @Delete(path: '/api/app/book-comment/delete/{commentId}')
  Future<chopper.Response> _apiAppBookCommentDeleteCommentIdDelete(
      {@Path('commentId') required int? commentId});

  ///Get Book Comments
  ///@param bookId ID of the book
  ///@param page Page number to retrieve
  ///@param limit Number of comments per page
  Future<chopper.Response> apiAppBookCommentBookBookIdCommentsGet({
    required int? bookId,
    int? page,
    int? limit,
  }) {
    return _apiAppBookCommentBookBookIdCommentsGet(
        bookId: bookId, page: page, limit: limit);
  }

  ///Get Book Comments
  ///@param bookId ID of the book
  ///@param page Page number to retrieve
  ///@param limit Number of comments per page
  @Get(path: '/api/app/book-comment/book/{bookId}/comments')
  Future<chopper.Response> _apiAppBookCommentBookBookIdCommentsGet({
    @Path('bookId') required int? bookId,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Comment by ID
  ///@param commentId ID of the comment
  Future<chopper.Response> apiAppBookCommentCommentCommentIdGet(
      {required int? commentId}) {
    return _apiAppBookCommentCommentCommentIdGet(commentId: commentId);
  }

  ///Get Comment by ID
  ///@param commentId ID of the comment
  @Get(path: '/api/app/book-comment/comment/{commentId}')
  Future<chopper.Response> _apiAppBookCommentCommentCommentIdGet(
      {@Path('commentId') required int? commentId});

  ///Get User Comments
  ///@param page Page number to retrieve
  ///@param limit Number of comments per page
  Future<chopper.Response> apiAppBookCommentCommentsGet({
    int? page,
    int? limit,
  }) {
    return _apiAppBookCommentCommentsGet(page: page, limit: limit);
  }

  ///Get User Comments
  ///@param page Page number to retrieve
  ///@param limit Number of comments per page
  @Get(path: '/api/app/book-comment/comments')
  Future<chopper.Response> _apiAppBookCommentCommentsGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Update Comment
  ///@param commentId ID of the comment
  Future<chopper.Response> apiAppBookCommentUpdateCommentIdPut({
    required int? commentId,
    required BookCommentRequest? body,
  }) {
    return _apiAppBookCommentUpdateCommentIdPut(
        commentId: commentId, body: body);
  }

  ///Update Comment
  ///@param commentId ID of the comment
  @Put(
    path: '/api/app/book-comment/update/{commentId}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBookCommentUpdateCommentIdPut({
    @Path('commentId') required int? commentId,
    @Body() required BookCommentRequest? body,
  });

  ///Report book
  Future<chopper.Response> apiAppBookReportPost(
      {required ContentModerationRequest? body}) {
    return _apiAppBookReportPost(body: body);
  }

  ///Report book
  @Post(
    path: '/api/app/book/report',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBookReportPost(
      {@Body() required ContentModerationRequest? body});

  ///Create Review
  Future<chopper.Response> apiAppBookReviewCreatePost(
      {required BookReviewRequest? body}) {
    return _apiAppBookReviewCreatePost(body: body);
  }

  ///Create Review
  @Post(
    path: '/api/app/book-review/create',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBookReviewCreatePost(
      {@Body() required BookReviewRequest? body});

  ///Get Book Reviews
  ///@param bookId ID of the book
  ///@param page Page number to retrieve
  ///@param limit Number of reviews per page
  Future<chopper.Response> apiAppBookReviewBookBookIdReviewsGet({
    required int? bookId,
    int? page,
    int? limit,
  }) {
    return _apiAppBookReviewBookBookIdReviewsGet(
        bookId: bookId, page: page, limit: limit);
  }

  ///Get Book Reviews
  ///@param bookId ID of the book
  ///@param page Page number to retrieve
  ///@param limit Number of reviews per page
  @Get(path: '/api/app/book-review/book/{bookId}/reviews')
  Future<chopper.Response> _apiAppBookReviewBookBookIdReviewsGet({
    @Path('bookId') required int? bookId,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Review by ID
  ///@param reviewId ID of the review
  Future<chopper.Response> apiAppBookReviewReviewReviewIdGet(
      {required int? reviewId}) {
    return _apiAppBookReviewReviewReviewIdGet(reviewId: reviewId);
  }

  ///Get Review by ID
  ///@param reviewId ID of the review
  @Get(path: '/api/app/book-review/review/{reviewId}')
  Future<chopper.Response> _apiAppBookReviewReviewReviewIdGet(
      {@Path('reviewId') required int? reviewId});

  ///Update Review
  ///@param reviewId ID of the review
  Future<chopper.Response> apiAppBookReviewReviewReviewIdPut({
    required int? reviewId,
    required BookReview? body,
  }) {
    return _apiAppBookReviewReviewReviewIdPut(reviewId: reviewId, body: body);
  }

  ///Update Review
  ///@param reviewId ID of the review
  @Put(
    path: '/api/app/book-review/review/{reviewId}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBookReviewReviewReviewIdPut({
    @Path('reviewId') required int? reviewId,
    @Body() required BookReview? body,
  });

  ///Get User Reviews
  ///@param page Page number to retrieve
  ///@param limit Number of reviews per page
  Future<chopper.Response> apiAppBookReviewReviewsGet({
    int? page,
    int? limit,
  }) {
    return _apiAppBookReviewReviewsGet(page: page, limit: limit);
  }

  ///Get User Reviews
  ///@param page Page number to retrieve
  ///@param limit Number of reviews per page
  @Get(path: '/api/app/book-review/reviews')
  Future<chopper.Response> _apiAppBookReviewReviewsGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Create a new bookmark
  Future<chopper.Response> apiAppBookmarksPost(
      {required BookmarkAppRequest? body}) {
    return _apiAppBookmarksPost(body: body);
  }

  ///Create a new bookmark
  @Post(
    path: '/api/app/bookmarks',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBookmarksPost(
      {@Body() required BookmarkAppRequest? body});

  ///Update bookmark
  ///@param id ID of the bookmark to update
  Future<chopper.Response> apiAppBookmarksIdPut({
    required int? id,
    required BookmarkAppRequest? body,
  }) {
    return _apiAppBookmarksIdPut(id: id, body: body);
  }

  ///Update bookmark
  ///@param id ID of the bookmark to update
  @Put(
    path: '/api/app/bookmarks/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppBookmarksIdPut({
    @Path('id') required int? id,
    @Body() required BookmarkAppRequest? body,
  });

  ///Delete bookmark
  ///@param id ID of the bookmark to delete
  Future<chopper.Response> apiAppBookmarksIdDelete({required int? id}) {
    return _apiAppBookmarksIdDelete(id: id);
  }

  ///Delete bookmark
  ///@param id ID of the bookmark to delete
  @Delete(path: '/api/app/bookmarks/{id}')
  Future<chopper.Response> _apiAppBookmarksIdDelete(
      {@Path('id') required int? id});

  ///Get bookmarks by user ID
  ///@param page Page number
  ///@param limit Results per page
  Future<chopper.Response<PaginatedResult>> apiAppBookmarksUserGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        PaginatedResult, () => PaginatedResult.fromJsonFactory);

    return _apiAppBookmarksUserGet(page: page, limit: limit);
  }

  ///Get bookmarks by user ID
  ///@param page Page number
  ///@param limit Results per page
  @Get(path: '/api/app/bookmarks/user')
  Future<chopper.Response<PaginatedResult>> _apiAppBookmarksUserGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get bookmarks by user ID and book ID
  ///@param bookId ID of the book
  ///@param chapterId ID of the chapter
  ///@param page Page number
  ///@param limit Results per page
  Future<chopper.Response<PaginatedResult>>
      apiAppBookmarksUserBookIdChapterIdGet({
    required int? bookId,
    required int? chapterId,
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        PaginatedResult, () => PaginatedResult.fromJsonFactory);

    return _apiAppBookmarksUserBookIdChapterIdGet(
        bookId: bookId, chapterId: chapterId, page: page, limit: limit);
  }

  ///Get bookmarks by user ID and book ID
  ///@param bookId ID of the book
  ///@param chapterId ID of the chapter
  ///@param page Page number
  ///@param limit Results per page
  @Get(path: '/api/app/bookmarks/user/{bookId}/{chapterId}')
  Future<chopper.Response<PaginatedResult>>
      _apiAppBookmarksUserBookIdChapterIdGet({
    @Path('bookId') required int? bookId,
    @Path('chapterId') required int? chapterId,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get all categories with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Category>>> apiAppCategoriesGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Category, () => Category.fromJsonFactory);

    return _apiAppCategoriesGet(page: page, limit: limit);
  }

  ///Get all categories with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/app/categories')
  Future<chopper.Response<List<Category>>> _apiAppCategoriesGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get all categories of a book
  ///@param id ID of the book to retrieve categories
  Future<chopper.Response<List<Category>>> apiAppCategoriesBookIdGet(
      {required int? id}) {
    generatedMapping.putIfAbsent(Category, () => Category.fromJsonFactory);

    return _apiAppCategoriesBookIdGet(id: id);
  }

  ///Get all categories of a book
  ///@param id ID of the book to retrieve categories
  @Get(path: '/api/app/categories/book/{id}')
  Future<chopper.Response<List<Category>>> _apiAppCategoriesBookIdGet(
      {@Path('id') required int? id});

  ///Get Category by ID
  ///@param id ID of the category to retrieve
  ///@param limit
  Future<chopper.Response<CategoryAppResponse>> apiAppCategoriesIdGet({
    required int? id,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        CategoryAppResponse, () => CategoryAppResponse.fromJsonFactory);

    return _apiAppCategoriesIdGet(id: id, limit: limit);
  }

  ///Get Category by ID
  ///@param id ID of the category to retrieve
  ///@param limit
  @Get(path: '/api/app/categories/{id}')
  Future<chopper.Response<CategoryAppResponse>> _apiAppCategoriesIdGet({
    @Path('id') required int? id,
    @Query('limit') int? limit,
  });

  ///Delete a file
  ///@param filename
  Future<chopper.Response> apiAppFileDeleteFilenameDelete(
      {required String? filename}) {
    return _apiAppFileDeleteFilenameDelete(filename: filename);
  }

  ///Delete a file
  ///@param filename
  @Delete(path: '/api/app/file/delete/{filename}')
  Future<chopper.Response> _apiAppFileDeleteFilenameDelete(
      {@Path('filename') required String? filename});

  ///Download a file
  ///@param filename
  Future<chopper.Response> apiAppFileDownloadFilenameGet(
      {required String? filename}) {
    return _apiAppFileDownloadFilenameGet(filename: filename);
  }

  ///Download a file
  ///@param filename
  @Get(path: '/api/app/file/download/{filename}')
  Future<chopper.Response> _apiAppFileDownloadFilenameGet(
      {@Path('filename') required String? filename});

  ///Upload a file
  Future<chopper.Response> apiAppFileUploadPost(
      {required FileUploadFormRequest body}) {
    return _apiAppFileUploadPost(body: body);
  }

  ///Upload a file
  @Post(
    path: '/api/app/file/upload',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response> _apiAppFileUploadPost(
      {@Part() required FileUploadFormRequest body});

  ///View an image file
  ///@param filename
  Future<chopper.Response> apiAppFileViewFilenameGet(
      {required String? filename}) {
    return _apiAppFileViewFilenameGet(filename: filename);
  }

  ///View an image file
  ///@param filename
  @Get(path: '/api/app/file/view/{filename}')
  Future<chopper.Response> _apiAppFileViewFilenameGet(
      {@Path('filename') required String? filename});

  ///Get Order History by User ID
  ///@param orderType
  ///@param page
  ///@param limit
  Future<chopper.Response<PaginatedResult>> apiAppHistoryOrdersGet({
    String? orderType,
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        PaginatedResult, () => PaginatedResult.fromJsonFactory);

    return _apiAppHistoryOrdersGet(
        orderType: orderType, page: page, limit: limit);
  }

  ///Get Order History by User ID
  ///@param orderType
  ///@param page
  ///@param limit
  @Get(path: '/api/app/history/orders')
  Future<chopper.Response<PaginatedResult>> _apiAppHistoryOrdersGet({
    @Query('orderType') String? orderType,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Public Book Requests by Status
  ///@param status
  ///@param page
  ///@param limit
  Future<chopper.Response<PaginatedResult>> apiAppHistoryPublicBooksGet({
    String? status,
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        PaginatedResult, () => PaginatedResult.fromJsonFactory);

    return _apiAppHistoryPublicBooksGet(
        status: status, page: page, limit: limit);
  }

  ///Get Public Book Requests by Status
  ///@param status
  ///@param page
  ///@param limit
  @Get(path: '/api/app/history/public-books')
  Future<chopper.Response<PaginatedResult>> _apiAppHistoryPublicBooksGet({
    @Query('status') String? status,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Reading Progress by User
  ///@param limit
  Future<chopper.Response<List<BookReadingResponse>>>
      apiAppHistoryReadingProgressGet({int? limit}) {
    generatedMapping.putIfAbsent(
        BookReadingResponse, () => BookReadingResponse.fromJsonFactory);

    return _apiAppHistoryReadingProgressGet(limit: limit);
  }

  ///Get Reading Progress by User
  ///@param limit
  @Get(path: '/api/app/history/reading-progress')
  Future<chopper.Response<List<BookReadingResponse>>>
      _apiAppHistoryReadingProgressGet({@Query('limit') int? limit});

  ///Get all categories with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Category>>> apiAppHomeCategoriesGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Category, () => Category.fromJsonFactory);

    return _apiAppHomeCategoriesGet(page: page, limit: limit);
  }

  ///Get all categories with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/app/home/categories')
  Future<chopper.Response<List<Category>>> _apiAppHomeCategoriesGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get best rated books
  ///@param limit
  Future<chopper.Response<List<BookBestRatedResponse>>>
      apiAppHomeBestRatedBooksGet({int? limit}) {
    generatedMapping.putIfAbsent(
        BookBestRatedResponse, () => BookBestRatedResponse.fromJsonFactory);

    return _apiAppHomeBestRatedBooksGet(limit: limit);
  }

  ///Get best rated books
  ///@param limit
  @Get(path: '/api/app/home/best-rated-books')
  Future<chopper.Response<List<BookBestRatedResponse>>>
      _apiAppHomeBestRatedBooksGet({@Query('limit') int? limit});

  ///Get discounted books
  ///@param limit
  Future<chopper.Response<List<DiscountedBookResponse>>>
      apiAppHomeDiscountedBooksGet({int? limit}) {
    generatedMapping.putIfAbsent(
        DiscountedBookResponse, () => DiscountedBookResponse.fromJsonFactory);

    return _apiAppHomeDiscountedBooksGet(limit: limit);
  }

  ///Get discounted books
  ///@param limit
  @Get(path: '/api/app/home/discounted-books')
  Future<chopper.Response<List<DiscountedBookResponse>>>
      _apiAppHomeDiscountedBooksGet({@Query('limit') int? limit});

  ///Get dynamic content
  ///@param contentTypes
  Future<chopper.Response<List<DynamicContent>>> apiAppHomeDynamicContentGet(
      {List<String>? contentTypes}) {
    generatedMapping.putIfAbsent(
        DynamicContent, () => DynamicContent.fromJsonFactory);

    return _apiAppHomeDynamicContentGet(contentTypes: contentTypes);
  }

  ///Get dynamic content
  ///@param contentTypes
  @Get(path: '/api/app/home/dynamic-content')
  Future<chopper.Response<List<DynamicContent>>> _apiAppHomeDynamicContentGet(
      {@Query('contentTypes') List<String>? contentTypes});

  ///Get most ordered books
  ///@param fromDate
  ///@param toDate
  ///@param limit
  Future<chopper.Response<List<BookMostOrderedResponse>>>
      apiAppHomeMostOrderedBooksGet({
    String? fromDate,
    String? toDate,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        BookMostOrderedResponse, () => BookMostOrderedResponse.fromJsonFactory);

    return _apiAppHomeMostOrderedBooksGet(
        fromDate: fromDate, toDate: toDate, limit: limit);
  }

  ///Get most ordered books
  ///@param fromDate
  ///@param toDate
  ///@param limit
  @Get(path: '/api/app/home/most-ordered-books')
  Future<chopper.Response<List<BookMostOrderedResponse>>>
      _apiAppHomeMostOrderedBooksGet({
    @Query('fromDate') String? fromDate,
    @Query('toDate') String? toDate,
    @Query('limit') int? limit,
  });

  ///Get most popular books
  ///@param limit
  Future<chopper.Response<List<BookMostPopularResponse>>>
      apiAppHomeMostPopularBooksGet({int? limit}) {
    generatedMapping.putIfAbsent(
        BookMostPopularResponse, () => BookMostPopularResponse.fromJsonFactory);

    return _apiAppHomeMostPopularBooksGet(limit: limit);
  }

  ///Get most popular books
  ///@param limit
  @Get(path: '/api/app/home/most-popular-books')
  Future<chopper.Response<List<BookMostPopularResponse>>>
      _apiAppHomeMostPopularBooksGet({@Query('limit') int? limit});

  ///Get new books
  ///@param limit
  Future<chopper.Response<List<NewBookResponse>>> apiAppHomeNewBooksGet(
      {int? limit}) {
    generatedMapping.putIfAbsent(
        NewBookResponse, () => NewBookResponse.fromJsonFactory);

    return _apiAppHomeNewBooksGet(limit: limit);
  }

  ///Get new books
  ///@param limit
  @Get(path: '/api/app/home/new-books')
  Future<chopper.Response<List<NewBookResponse>>> _apiAppHomeNewBooksGet(
      {@Query('limit') int? limit});

  ///Get all publishers with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Publisher>>> apiAppPublisherGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Publisher, () => Publisher.fromJsonFactory);

    return _apiAppPublisherGet(page: page, limit: limit);
  }

  ///Get all publishers with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/app/publisher')
  Future<chopper.Response<List<Publisher>>> _apiAppPublisherGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Publisher by ID
  ///@param id ID of the publisher to retrieve
  Future<chopper.Response<Publisher>> apiAppPublisherIdGet({required int? id}) {
    generatedMapping.putIfAbsent(Publisher, () => Publisher.fromJsonFactory);

    return _apiAppPublisherIdGet(id: id);
  }

  ///Get Publisher by ID
  ///@param id ID of the publisher to retrieve
  @Get(path: '/api/app/publisher/{id}')
  Future<chopper.Response<Publisher>> _apiAppPublisherIdGet(
      {@Path('id') required int? id});

  ///Search for books
  ///@param keyword Keyword to search for
  ///@param page Page number
  ///@param limit Number of results per page
  Future<chopper.Response<PaginatedResult>> apiAppSearchSearchGet({
    String? keyword,
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        PaginatedResult, () => PaginatedResult.fromJsonFactory);

    return _apiAppSearchSearchGet(keyword: keyword, page: page, limit: limit);
  }

  ///Search for books
  ///@param keyword Keyword to search for
  ///@param page Page number
  ///@param limit Number of results per page
  @Get(path: '/api/app/search/search')
  Future<chopper.Response<PaginatedResult>> _apiAppSearchSearchGet({
    @Query('keyword') String? keyword,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Advanced book search
  ///@param page Page number
  ///@param limit Number of results per page
  Future<chopper.Response<PaginatedResult>> apiAppSearchAdvancedSearchPost({
    int? page,
    int? limit,
    required BookAdvancedSearchRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        PaginatedResult, () => PaginatedResult.fromJsonFactory);

    return _apiAppSearchAdvancedSearchPost(
        page: page, limit: limit, body: body);
  }

  ///Advanced book search
  ///@param page Page number
  ///@param limit Number of results per page
  @Post(
    path: '/api/app/search/advanced-search',
    optionalBody: true,
  )
  Future<chopper.Response<PaginatedResult>> _apiAppSearchAdvancedSearchPost({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Body() required BookAdvancedSearchRequest? body,
  });

  ///Get suggested keywords
  ///@param keyword Keyword for suggestions
  ///@param page Page number
  ///@param limit Number of results per page
  Future<chopper.Response<PaginatedResult>> apiAppSearchSuggestionsGet({
    String? keyword,
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        PaginatedResult, () => PaginatedResult.fromJsonFactory);

    return _apiAppSearchSuggestionsGet(
        keyword: keyword, page: page, limit: limit);
  }

  ///Get suggested keywords
  ///@param keyword Keyword for suggestions
  ///@param page Page number
  ///@param limit Number of results per page
  @Get(path: '/api/app/search/suggestions')
  Future<chopper.Response<PaginatedResult>> _apiAppSearchSuggestionsGet({
    @Query('keyword') String? keyword,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get all tags with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<TagModel>>> apiAppTagsGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(TagModel, () => TagModel.fromJsonFactory);

    return _apiAppTagsGet(page: page, limit: limit);
  }

  ///Get all tags with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/app/tags')
  Future<chopper.Response<List<TagModel>>> _apiAppTagsGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Tag by ID
  ///@param id ID of the tag to retrieve
  Future<chopper.Response<TagModel>> apiAppTagsIdGet({required int? id}) {
    generatedMapping.putIfAbsent(TagModel, () => TagModel.fromJsonFactory);

    return _apiAppTagsIdGet(id: id);
  }

  ///Get Tag by ID
  ///@param id ID of the tag to retrieve
  @Get(path: '/api/app/tags/{id}')
  Future<chopper.Response<TagModel>> _apiAppTagsIdGet(
      {@Path('id') required int? id});

  ///Get all tags by book ID
  ///@param bookId ID of the book to retrieve tags
  Future<chopper.Response<List<TagModel>>> apiAppTagsBookBookIdGet(
      {required int? bookId}) {
    generatedMapping.putIfAbsent(TagModel, () => TagModel.fromJsonFactory);

    return _apiAppTagsBookBookIdGet(bookId: bookId);
  }

  ///Get all tags by book ID
  ///@param bookId ID of the book to retrieve tags
  @Get(path: '/api/app/tags/book/{bookId}')
  Future<chopper.Response<List<TagModel>>> _apiAppTagsBookBookIdGet(
      {@Path('bookId') required int? bookId});

  ///Get all reading progress
  ///@param page
  ///@param limit
  Future<chopper.Response> apiAppReadingProgressGet({
    int? page,
    int? limit,
  }) {
    return _apiAppReadingProgressGet(page: page, limit: limit);
  }

  ///Get all reading progress
  ///@param page
  ///@param limit
  @Get(path: '/api/app/reading-progress')
  Future<chopper.Response> _apiAppReadingProgressGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Add or update reading progress
  Future<chopper.Response> apiAppReadingProgressPost(
      {required UserReadingProgressAppRequest? body}) {
    return _apiAppReadingProgressPost(body: body);
  }

  ///Add or update reading progress
  @Post(
    path: '/api/app/reading-progress',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppReadingProgressPost(
      {@Body() required UserReadingProgressAppRequest? body});

  ///Filter and sort reading progress
  Future<chopper.Response> apiAppReadingProgressFilterPost(
      {required FilterRequest? body}) {
    return _apiAppReadingProgressFilterPost(body: body);
  }

  ///Filter and sort reading progress
  @Post(
    path: '/api/app/reading-progress/filter',
    optionalBody: true,
  )
  Future<chopper.Response> _apiAppReadingProgressFilterPost(
      {@Body() required FilterRequest? body});

  ///Get reading progress by ID
  ///@param id
  Future<chopper.Response<UserReadingProgress>> apiAppReadingProgressIdGet(
      {required int? id}) {
    generatedMapping.putIfAbsent(
        UserReadingProgress, () => UserReadingProgress.fromJsonFactory);

    return _apiAppReadingProgressIdGet(id: id);
  }

  ///Get reading progress by ID
  ///@param id
  @Get(path: '/api/app/reading-progress/{id}')
  Future<chopper.Response<UserReadingProgress>> _apiAppReadingProgressIdGet(
      {@Path('id') required int? id});

  ///Get reading progress by user ID
  ///@param bookId
  Future<chopper.Response<UserReadingProgress>>
      apiAppReadingProgressUserBookIdGet({required int? bookId}) {
    generatedMapping.putIfAbsent(
        UserReadingProgress, () => UserReadingProgress.fromJsonFactory);

    return _apiAppReadingProgressUserBookIdGet(bookId: bookId);
  }

  ///Get reading progress by user ID
  ///@param bookId
  @Get(path: '/api/app/reading-progress/user/{bookId}')
  Future<chopper.Response<UserReadingProgress>>
      _apiAppReadingProgressUserBookIdGet(
          {@Path('bookId') required int? bookId});

  ///Get all vouchers with pagination
  ///@param page
  ///@param limit
  Future<chopper.Response<List<Voucher>>> apiAppVoucherGet({
    int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(Voucher, () => Voucher.fromJsonFactory);

    return _apiAppVoucherGet(page: page, limit: limit);
  }

  ///Get all vouchers with pagination
  ///@param page
  ///@param limit
  @Get(path: '/api/app/voucher')
  Future<chopper.Response<List<Voucher>>> _apiAppVoucherGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  ///Get Voucher by ID
  ///@param id ID of the voucher to retrieve
  Future<chopper.Response<Voucher>> apiAppVoucherIdGet({required int? id}) {
    generatedMapping.putIfAbsent(Voucher, () => Voucher.fromJsonFactory);

    return _apiAppVoucherIdGet(id: id);
  }

  ///Get Voucher by ID
  ///@param id ID of the voucher to retrieve
  @Get(path: '/api/app/voucher/{id}')
  Future<chopper.Response<Voucher>> _apiAppVoucherIdGet(
      {@Path('id') required int? id});

  ///Get list of vouchers by user ID
  ///@param page ID of the user to retrieve vouchers for
  ///@param limit
  Future<chopper.Response<List<VoucherAppResponse>>> apiAppVoucherUserGet({
    required int? page,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        VoucherAppResponse, () => VoucherAppResponse.fromJsonFactory);

    return _apiAppVoucherUserGet(page: page, limit: limit);
  }

  ///Get list of vouchers by user ID
  ///@param page ID of the user to retrieve vouchers for
  ///@param limit
  @Get(path: '/api/app/voucher/user')
  Future<chopper.Response<List<VoucherAppResponse>>> _apiAppVoucherUserGet({
    @Query('page') required int? page,
    @Query('limit') int? limit,
  });
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
