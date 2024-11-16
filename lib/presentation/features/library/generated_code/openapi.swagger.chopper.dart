// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Openapi extends Openapi {
  _$Openapi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Openapi;

  @override
  Future<Response<List<ContentModeration>>> _apiAdminBookReportGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/book/report');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<ContentModeration>, ContentModeration>($request);
  }

  @override
  Future<Response<ContentModeration>> _apiAdminBookReportIdGet(
      {required int? id}) {
    final Uri $url = Uri.parse('/api/admin/book/report/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ContentModeration, ContentModeration>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminBookReportIdPut({
    required int? id,
    required ContentModerationRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/admin/book/report/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminFileDeleteFilenameDelete(
      {required String? filename}) {
    final Uri $url = Uri.parse('/api/admin/file/delete/${filename}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminFileDownloadFilenameGet(
      {required String? filename}) {
    final Uri $url = Uri.parse('/api/admin/file/download/${filename}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminFileUploadPost(
      {required AdminFileUploadFormRequest body}) {
    final Uri $url = Uri.parse('/api/admin/file/upload');
    final List<PartValue> $parts = <PartValue>[
      PartValue<AdminFileUploadFormRequest>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminFileViewFilenameGet(
      {required String? filename}) {
    final Uri $url = Uri.parse('/api/admin/file/view/${filename}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<int>> _apiAdminAuthorsCreateIdPost() {
    final Uri $url = Uri.parse('/api/admin/authors/createId');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<int, int>($request);
  }

  @override
  Future<Response<List<Author>>> _apiAdminAuthorsFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/authors/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<Author>, Author>($request);
  }

  @override
  Future<Response<List<Author>>> _apiAdminAuthorsGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/authors');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Author>, Author>($request);
  }

  @override
  Future<Response<Author>> _apiAdminAuthorsIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/authors/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Author, Author>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminAuthorsIdPut({
    required int? id,
    required AuthorRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/admin/authors/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminAuthorsIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/authors/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminAuthorsUploadImagePost(
      {required AuthorImageFormRequest body}) {
    final Uri $url = Uri.parse('/api/admin/authors/uploadImage');
    final List<PartValue> $parts = <PartValue>[
      PartValue<AuthorImageFormRequest>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<int>> _apiAdminBooksCreateIdPost() {
    final Uri $url = Uri.parse('/api/admin/books/createId');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<int, int>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminBooksDeleteChapterIdBookIdDelete({
    required int? id,
    required int? bookId,
  }) {
    final Uri $url =
        Uri.parse('/api/admin/books/deleteChapter/${id}/${bookId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminBooksDeleteImageIdDelete(
      {required int? id}) {
    final Uri $url = Uri.parse('/api/admin/books/deleteImage/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Book>>> _apiAdminBooksFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/books/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<Book>, Book>($request);
  }

  @override
  Future<Response<List<Book>>> _apiAdminBooksGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/books');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Book>, Book>($request);
  }

  @override
  Future<Response<Book>> _apiAdminBooksIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/books/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Book, Book>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminBooksIdPut({
    required int? id,
    required BookRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/admin/books/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminBooksIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/books/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminBooksUploadChapterPost(
      {required AdminBookUploadFormRequest body}) {
    final Uri $url = Uri.parse('/api/admin/books/uploadChapter');
    final List<PartValue> $parts = <PartValue>[
      PartValue<AdminBookUploadFormRequest>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminBooksUploadImagePost(
      {required BookImageFormRequest body}) {
    final Uri $url = Uri.parse('/api/admin/books/uploadImage');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BookImageFormRequest>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<BookComment>>> _apiAdminBookCommentsFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/bookComments/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<BookComment>, BookComment>($request);
  }

  @override
  Future<Response<List<BookComment>>> _apiAdminBookCommentsGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/bookComments');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<BookComment>, BookComment>($request);
  }

  @override
  Future<Response<BookComment>> _apiAdminBookCommentsIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/bookComments/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BookComment, BookComment>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminBookCommentsIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/bookComments/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<BookReview>>> _apiAdminBookRatingFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/bookRating/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<BookReview>, BookReview>($request);
  }

  @override
  Future<Response<List<BookReview>>> _apiAdminBookRatingGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/bookRating');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<BookReview>, BookReview>($request);
  }

  @override
  Future<Response<BookReview>> _apiAdminBookRatingIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/bookRating/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BookReview, BookReview>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminBookRatingIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/bookRating/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Category>>> _apiAdminCategoriesGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/categories');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Category>, Category>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminCategoriesPost(
      {required CategoryRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/categories');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Category>>> _apiAdminCategoriesFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/categories/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<Category>, Category>($request);
  }

  @override
  Future<Response<Category>> _apiAdminCategoriesIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/categories/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Category, Category>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminCategoriesIdPut({
    required int? id,
    required CategoryRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/admin/categories/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminCategoriesIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/categories/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Order>>> _apiAdminOrdersFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/orders/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<Order>, Order>($request);
  }

  @override
  Future<Response<List<Order>>> _apiAdminOrdersGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/orders');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Order>, Order>($request);
  }

  @override
  Future<Response<Order>> _apiAdminOrdersIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/orders/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Order, Order>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminOrdersIdPut({
    required int? id,
    required OrderRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/admin/orders/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminOrdersIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/orders/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
      _apiAdminPublicBookRegisterPublicBookChangeStatusPost({
    int? id,
    String? status,
  }) {
    final Uri $url =
        Uri.parse('/api/admin/publicBook/registerPublicBook/changeStatus');
    final Map<String, dynamic> $params = <String, dynamic>{
      'id': id,
      'status': status,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminPublicBookCheckPublicBookRequestStatusGet(
      {int? id}) {
    final Uri $url =
        Uri.parse('/api/admin/publicBook/checkPublicBookRequestStatus');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PublicBookRequest>>> _apiAdminPublicBookGet({
    int? page,
    int? limit,
    String? status,
  }) {
    final Uri $url = Uri.parse('/api/admin/publicBook');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'status': status,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<PublicBookRequest>, PublicBookRequest>($request);
  }

  @override
  Future<Response<PublicBookRequest>> _apiAdminPublicBookIdGet(
      {required int? id}) {
    final Uri $url = Uri.parse('/api/admin/publicBook/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PublicBookRequest, PublicBookRequest>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminPublicBookListRegisterPublicBookGet({
    int? page,
    int? limit,
    String? status,
  }) {
    final Uri $url = Uri.parse('/api/admin/publicBook/listRegisterPublicBook');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'status': status,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminPublicBookIdStatusPost({
    required int? id,
    required String? status,
  }) {
    final Uri $url = Uri.parse('/api/admin/publicBook/${id}/status');
    final Map<String, dynamic> $params = <String, dynamic>{'status': status};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Publisher>>> _apiAdminPublisherGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/publisher');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Publisher>, Publisher>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminPublisherPost(
      {required PublisherRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/publisher');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Publisher>>> _apiAdminPublisherFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/publisher/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<Publisher>, Publisher>($request);
  }

  @override
  Future<Response<Publisher>> _apiAdminPublisherIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/publisher/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Publisher, Publisher>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminPublisherIdPut({
    required int? id,
    required PublisherRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/admin/publisher/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminPublisherIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/publisher/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TagModel>>> _apiAdminTagsGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/tags');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<TagModel>, TagModel>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminTagsPost({required TagRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/tags');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TagModel>>> _apiAdminTagsFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/tags/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<TagModel>, TagModel>($request);
  }

  @override
  Future<Response<TagModel>> _apiAdminTagsIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/tags/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TagModel, TagModel>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminTagsIdPut({
    required int? id,
    required TagRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/admin/tags/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminTagsIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/tags/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminUserapiLoginPost(
      {required AdminLoginFormRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/userapi/login');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Voucher>>> _apiAdminVoucherGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/admin/voucher');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Voucher>, Voucher>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminVoucherPost(
      {required VoucherRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/voucher');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Voucher>>> _apiAdminVoucherFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/admin/voucher/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<Voucher>, Voucher>($request);
  }

  @override
  Future<Response<Voucher>> _apiAdminVoucherIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/voucher/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Voucher, Voucher>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminVoucherIdPut({
    required int? id,
    required VoucherRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/admin/voucher/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAdminVoucherIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/admin/voucher/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppOrderCheckBookPurchasedGet({int? bookId}) {
    final Uri $url = Uri.parse('/api/app/order/checkBookPurchased');
    final Map<String, dynamic> $params = <String, dynamic>{'bookId': bookId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppOrderListOrderGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/order/listOrder');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppOrderMakePost(
      {required MakeOrderRequest? body}) {
    final Uri $url = Uri.parse('/api/app/order/make');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppOrderOrderDetailGet({int? orrderId}) {
    final Uri $url = Uri.parse('/api/app/order/orderDetail');
    final Map<String, dynamic> $params = <String, dynamic>{
      'orrderId': orrderId
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppOrderPayOrderPost({int? orderId}) {
    final Uri $url = Uri.parse('/api/app/order/payOrder');
    final Map<String, dynamic> $params = <String, dynamic>{'orderId': orderId};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppStatisticOrderDetailOfBookPost({
    int? bookId,
    int? orderId,
  }) {
    final Uri $url = Uri.parse('/api/app/statistic/orderDetailOfBook');
    final Map<String, dynamic> $params = <String, dynamic>{
      'bookId': bookId,
      'orderId': orderId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppStatisticRevenueByBookPost() {
    final Uri $url = Uri.parse('/api/app/statistic/revenueByBook');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppStatisticRevenueOfBookPost({int? id}) {
    final Uri $url = Uri.parse('/api/app/statistic/revenueOfBook');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppStatisticSumaryMyUploadBookPost() {
    final Uri $url = Uri.parse('/api/app/statistic/sumaryMyUploadBook');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppUserInfoPost() {
    final Uri $url = Uri.parse('/api/app/user/info');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Author>>> _apiAppAuthorsGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/authors');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Author>, Author>($request);
  }

  @override
  Future<Response<AuthorAppResponse>> _apiAppAuthorsIdGet({
    required int? id,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/authors/${id}');
    final Map<String, dynamic> $params = <String, dynamic>{'limit': limit};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AuthorAppResponse, AuthorAppResponse>($request);
  }

  @override
  Future<Response<int>> _apiAppBooksCreateIdPost() {
    final Uri $url = Uri.parse('/api/app/books/createId');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<int, int>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksDeleteChapterIdBookIdDelete({
    required int? id,
    required int? bookId,
  }) {
    final Uri $url = Uri.parse('/api/app/books/deleteChapter/${id}/${bookId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksDeleteImageIdDelete(
      {required int? id}) {
    final Uri $url = Uri.parse('/api/app/books/deleteImage/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Book>> _apiAppBooksIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/app/books/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Book, Book>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksIdPut({
    required int? id,
    required BookAppRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/app/books/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksFavouriteListIdGet({
    int? page,
    int? limit,
    List<int>? categories,
    List<int>? authors,
  }) {
    final Uri $url = Uri.parse('/api/app/books/favouriteListId');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'categories': categories,
      'authors': authors,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksFavouriteListGet({
    int? page,
    int? limit,
    List<int>? categories,
    List<int>? authors,
  }) {
    final Uri $url = Uri.parse('/api/app/books/favouriteList');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'categories': categories,
      'authors': authors,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksFavouriteFilterDataGet() {
    final Uri $url = Uri.parse('/api/app/books/favouriteFilterData');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksMyPurchasedBooksGet({
    int? page,
    int? limit,
    String? sort,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/app/books/myPurchasedBooks');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort': sort,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksMyPurchasedBooksFilterDataGet() {
    final Uri $url = Uri.parse('/api/app/books/myPurchasedBooks/filterData');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksMyUploadBooksGet({
    int? page,
    int? limit,
    String? isPublished,
    String? sort,
    String? type,
  }) {
    final Uri $url = Uri.parse('/api/app/books/myUploadBooks');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'isPublished': isPublished,
      'sort': sort,
      'type': type,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksMyUploadBooksFilterDataGet(
      {String? isPublished}) {
    final Uri $url = Uri.parse('/api/app/books/myUploadBooks/filterData');
    final Map<String, dynamic> $params = <String, dynamic>{
      'isPublished': isPublished
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksPublicBookGet({int? bookId}) {
    final Uri $url = Uri.parse('/api/app/books/public/book');
    final Map<String, dynamic> $params = <String, dynamic>{'bookId': bookId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksRegisterPublicPost() {
    final Uri $url = Uri.parse('/api/app/books/registerPublic');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksRegisterPublicStatusGet() {
    final Uri $url = Uri.parse('/api/app/books/registerPublic/status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksToggleFavouriteGet({int? bookId}) {
    final Uri $url = Uri.parse('/api/app/books/toggleFavourite');
    final Map<String, dynamic> $params = <String, dynamic>{'bookId': bookId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksUploadChapterWithGoogleDrivePost(
      {required BookChapterGoogleDriveRequest? body}) {
    final Uri $url = Uri.parse('/api/app/books/uploadChapterWithGoogleDrive');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksUploadChapterPost(
      {required AdminBookUploadFormRequest body}) {
    final Uri $url = Uri.parse('/api/app/books/uploadChapter');
    final List<PartValue> $parts = <PartValue>[
      PartValue<AdminBookUploadFormRequest>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksUploadImagePost(
      {required BookImageFormRequest body}) {
    final Uri $url = Uri.parse('/api/app/books/uploadImage');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BookImageFormRequest>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBooksViewBookGet(
      {required String? fileName}) {
    final Uri $url = Uri.parse('/api/app/books/viewBook');
    final Map<String, dynamic> $params = <String, dynamic>{
      'fileName': fileName
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookCommentCreatePost(
      {required BookCommentRequest? body}) {
    final Uri $url = Uri.parse('/api/app/book-comment/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookCommentDeleteCommentIdDelete(
      {required int? commentId}) {
    final Uri $url = Uri.parse('/api/app/book-comment/delete/${commentId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookCommentBookBookIdCommentsGet({
    required int? bookId,
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/book-comment/book/${bookId}/comments');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookCommentCommentCommentIdGet(
      {required int? commentId}) {
    final Uri $url = Uri.parse('/api/app/book-comment/comment/${commentId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookCommentCommentsGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/book-comment/comments');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookCommentUpdateCommentIdPut({
    required int? commentId,
    required BookCommentRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/app/book-comment/update/${commentId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookReportPost(
      {required ContentModerationRequest? body}) {
    final Uri $url = Uri.parse('/api/app/book/report');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookReviewCreatePost(
      {required BookReviewRequest? body}) {
    final Uri $url = Uri.parse('/api/app/book-review/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookReviewBookBookIdReviewsGet({
    required int? bookId,
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/book-review/book/${bookId}/reviews');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookReviewReviewReviewIdGet(
      {required int? reviewId}) {
    final Uri $url = Uri.parse('/api/app/book-review/review/${reviewId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookReviewReviewReviewIdPut({
    required int? reviewId,
    required BookReview? body,
  }) {
    final Uri $url = Uri.parse('/api/app/book-review/review/${reviewId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookReviewReviewsGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/book-review/reviews');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookmarksPost(
      {required BookmarkAppRequest? body}) {
    final Uri $url = Uri.parse('/api/app/bookmarks');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookmarksIdPut({
    required int? id,
    required BookmarkAppRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/app/bookmarks/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppBookmarksIdDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/app/bookmarks/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedResult>> _apiAppBookmarksUserGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/bookmarks/user');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PaginatedResult, PaginatedResult>($request);
  }

  @override
  Future<Response<PaginatedResult>> _apiAppBookmarksUserBookIdChapterIdGet({
    required int? bookId,
    required int? chapterId,
    int? page,
    int? limit,
  }) {
    final Uri $url =
        Uri.parse('/api/app/bookmarks/user/${bookId}/${chapterId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PaginatedResult, PaginatedResult>($request);
  }

  @override
  Future<Response<List<Category>>> _apiAppCategoriesGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/categories');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Category>, Category>($request);
  }

  @override
  Future<Response<List<Category>>> _apiAppCategoriesBookIdGet(
      {required int? id}) {
    final Uri $url = Uri.parse('/api/app/categories/book/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Category>, Category>($request);
  }

  @override
  Future<Response<CategoryAppResponse>> _apiAppCategoriesIdGet({
    required int? id,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/categories/${id}');
    final Map<String, dynamic> $params = <String, dynamic>{'limit': limit};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<CategoryAppResponse, CategoryAppResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppFileDeleteFilenameDelete(
      {required String? filename}) {
    final Uri $url = Uri.parse('/api/app/file/delete/${filename}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppFileDownloadFilenameGet(
      {required String? filename}) {
    final Uri $url = Uri.parse('/api/app/file/download/${filename}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppFileUploadPost(
      {required FileUploadFormRequest body}) {
    final Uri $url = Uri.parse('/api/app/file/upload');
    final List<PartValue> $parts = <PartValue>[
      PartValue<FileUploadFormRequest>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppFileViewFilenameGet(
      {required String? filename}) {
    final Uri $url = Uri.parse('/api/app/file/view/${filename}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaginatedResult>> _apiAppHistoryOrdersGet({
    String? orderType,
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/history/orders');
    final Map<String, dynamic> $params = <String, dynamic>{
      'orderType': orderType,
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PaginatedResult, PaginatedResult>($request);
  }

  @override
  Future<Response<PaginatedResult>> _apiAppHistoryPublicBooksGet({
    String? status,
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/history/public-books');
    final Map<String, dynamic> $params = <String, dynamic>{
      'status': status,
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PaginatedResult, PaginatedResult>($request);
  }

  @override
  Future<Response<List<BookReadingResponse>>> _apiAppHistoryReadingProgressGet(
      {int? limit}) {
    final Uri $url = Uri.parse('/api/app/history/reading-progress');
    final Map<String, dynamic> $params = <String, dynamic>{'limit': limit};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<BookReadingResponse>, BookReadingResponse>($request);
  }

  @override
  Future<Response<List<Category>>> _apiAppHomeCategoriesGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/home/categories');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Category>, Category>($request);
  }

  @override
  Future<Response<List<BookBestRatedResponse>>> _apiAppHomeBestRatedBooksGet(
      {int? limit}) {
    final Uri $url = Uri.parse('/api/app/home/best-rated-books');
    final Map<String, dynamic> $params = <String, dynamic>{'limit': limit};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<BookBestRatedResponse>, BookBestRatedResponse>($request);
  }

  @override
  Future<Response<List<DiscountedBookResponse>>> _apiAppHomeDiscountedBooksGet(
      {int? limit}) {
    final Uri $url = Uri.parse('/api/app/home/discounted-books');
    final Map<String, dynamic> $params = <String, dynamic>{'limit': limit};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<DiscountedBookResponse>, DiscountedBookResponse>($request);
  }

  @override
  Future<Response<List<DynamicContent>>> _apiAppHomeDynamicContentGet(
      {List<String>? contentTypes}) {
    final Uri $url = Uri.parse('/api/app/home/dynamic-content');
    final Map<String, dynamic> $params = <String, dynamic>{
      'contentTypes': contentTypes
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<DynamicContent>, DynamicContent>($request);
  }

  @override
  Future<Response<List<BookMostOrderedResponse>>>
      _apiAppHomeMostOrderedBooksGet({
    String? fromDate,
    String? toDate,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/home/most-ordered-books');
    final Map<String, dynamic> $params = <String, dynamic>{
      'fromDate': fromDate,
      'toDate': toDate,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<BookMostOrderedResponse>, BookMostOrderedResponse>($request);
  }

  @override
  Future<Response<List<BookMostPopularResponse>>>
      _apiAppHomeMostPopularBooksGet({int? limit}) {
    final Uri $url = Uri.parse('/api/app/home/most-popular-books');
    final Map<String, dynamic> $params = <String, dynamic>{'limit': limit};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<BookMostPopularResponse>, BookMostPopularResponse>($request);
  }

  @override
  Future<Response<List<NewBookResponse>>> _apiAppHomeNewBooksGet({int? limit}) {
    final Uri $url = Uri.parse('/api/app/home/new-books');
    final Map<String, dynamic> $params = <String, dynamic>{'limit': limit};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<NewBookResponse>, NewBookResponse>($request);
  }

  @override
  Future<Response<List<Publisher>>> _apiAppPublisherGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/publisher');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Publisher>, Publisher>($request);
  }

  @override
  Future<Response<Publisher>> _apiAppPublisherIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/app/publisher/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Publisher, Publisher>($request);
  }

  @override
  Future<Response<PaginatedResult>> _apiAppSearchSearchGet({
    String? keyword,
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/search/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'keyword': keyword,
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PaginatedResult, PaginatedResult>($request);
  }

  @override
  Future<Response<PaginatedResult>> _apiAppSearchAdvancedSearchPost({
    int? page,
    int? limit,
    required BookAdvancedSearchRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/app/search/advanced-search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<PaginatedResult, PaginatedResult>($request);
  }

  @override
  Future<Response<PaginatedResult>> _apiAppSearchSuggestionsGet({
    String? keyword,
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/search/suggestions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'keyword': keyword,
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PaginatedResult, PaginatedResult>($request);
  }

  @override
  Future<Response<List<TagModel>>> _apiAppTagsGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/tags');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<TagModel>, TagModel>($request);
  }

  @override
  Future<Response<TagModel>> _apiAppTagsIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/app/tags/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TagModel, TagModel>($request);
  }

  @override
  Future<Response<List<TagModel>>> _apiAppTagsBookBookIdGet(
      {required int? bookId}) {
    final Uri $url = Uri.parse('/api/app/tags/book/${bookId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<TagModel>, TagModel>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppReadingProgressGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/reading-progress');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppReadingProgressPost(
      {required UserReadingProgressAppRequest? body}) {
    final Uri $url = Uri.parse('/api/app/reading-progress');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiAppReadingProgressFilterPost(
      {required FilterRequest? body}) {
    final Uri $url = Uri.parse('/api/app/reading-progress/filter');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserReadingProgress>> _apiAppReadingProgressIdGet(
      {required int? id}) {
    final Uri $url = Uri.parse('/api/app/reading-progress/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserReadingProgress, UserReadingProgress>($request);
  }

  @override
  Future<Response<UserReadingProgress>> _apiAppReadingProgressUserBookIdGet(
      {required int? bookId}) {
    final Uri $url = Uri.parse('/api/app/reading-progress/user/${bookId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserReadingProgress, UserReadingProgress>($request);
  }

  @override
  Future<Response<List<Voucher>>> _apiAppVoucherGet({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/voucher');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Voucher>, Voucher>($request);
  }

  @override
  Future<Response<Voucher>> _apiAppVoucherIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/app/voucher/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Voucher, Voucher>($request);
  }

  @override
  Future<Response<List<VoucherAppResponse>>> _apiAppVoucherUserGet({
    required int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/api/app/voucher/user');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<VoucherAppResponse>, VoucherAppResponse>($request);
  }
}
