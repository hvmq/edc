import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;

import '../../../generated_code/openapi.models.swagger.dart';
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class OrderApiRepository extends OpenApiRepository<MakeOrderRequest> {
  OrderApiRepository()
      : super(DefaultJsonDecoder<MakeOrderResponse>(
            (json) => MakeOrderResponse.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<MakeOrderResponse>> make_order(
      List<int>? bookIds, int? voucherId) async {
        print('bookIds: $bookIds');
        print('voucherId: $voucherId');
    // Make the API call and get a dynamic response
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppOrderMakePost(
            body: MakeOrderRequest(
      bookIds: bookIds,
      voucherId: voucherId,
    ));

    print(chopperResult.body);
    print(chopperResult.statusCode);
    print(chopperResult.error);

    // Convert the dynamic response to a MakeOrderResponse
    if (chopperResult.statusCode == 200) {
      final MakeOrderResponse response =
          MakeOrderResponse.fromJson(chopperResult.body);

      return get_response.Response(
        statusCode: chopperResult.base.statusCode,
        headers: chopperResult.base.headers,
        body: response,
      );
    } else if (chopperResult.statusCode == 505) {
      throw Exception('You have already ordered this book');
    } else {
      throw Exception('Failed to make order! Please try again');
    }
  }
}

class MakeOrderResponse {
  final OrderData data;

  MakeOrderResponse({
    required this.data,
  });

  factory MakeOrderResponse.fromJson(Map<String, dynamic> json) {
    return MakeOrderResponse(
      data: OrderData.fromJson(json['data']),
    );
  }
}

class OrderData {
  final int id;
  final int userId;
  final double totalPrice;
  final String paymentMethod;
  final String orderStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItem> orderItems;

  OrderData({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.paymentMethod,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.orderItems,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    var orderItemsFromJson = json['orderItems'] as List;
    List<OrderItem> orderItemsList =
        orderItemsFromJson.map((item) => OrderItem.fromJson(item)).toList();

    return OrderData(
      id: json['id'],
      userId: json['userId'],
      totalPrice: (json['totalPrice'] as num).toDouble(), // Cast to double
      paymentMethod: json['paymentMethod'],
      orderStatus: json['orderStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      orderItems: orderItemsList,
    );
  }
}

class OrderItem {
  final int id;
  final int orderId;
  final int bookId;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.bookId,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['orderId'],
      bookId: json['bookId'],
      price: (json['price'] as num).toDouble(), // Cast to double
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class PayOrderApiRepository extends OpenApiRepository<PayOrderResponse> {
  PayOrderApiRepository()
      : super(DefaultJsonDecoder<PayOrderResponse>(
            (json) => PayOrderResponse.fromJson(json)));

  Future<get_response.Response<PayOrderResponse>> payOrder(int? orderId) async {
    try {
      // Make the API call and get a dynamic response
      final chopper_response.Response<dynamic> chopperResult =
          await openapi.apiAppOrderPayOrderPost(orderId: orderId);

      // Handle successful response
      if (chopperResult.base.statusCode == 200) {
        final PayOrderResponse response =
            PayOrderResponse.fromJson(chopperResult.body);

        return get_response.Response(
          statusCode: chopperResult.base.statusCode,
          headers: chopperResult.base.headers,
          body: response,
        );
      }
      // Handle error response
      else {
        // If the error is a string, attempt to parse it as a JSON string
        if (chopperResult.error is String) {
          try {
            // Attempt to decode the string into a Map
            final Map<String, dynamic> errorJson =
                jsonDecode(chopperResult.error as String);
            final String message = errorJson['message'] ?? 'Unknown error';

            return get_response.Response(
              statusCode: chopperResult.base.statusCode,
              headers: chopperResult.base.headers,
              body: null,
              statusText: message,
            );
          } catch (e) {
            // If decoding fails, return the raw string as the error message
            return get_response.Response(
              statusCode: chopperResult.base.statusCode,
              headers: chopperResult.base.headers,
              body: null,
              statusText: chopperResult.error as String,
            );
          }
        }
        // If the error is already a Map<String, dynamic>, handle it as JSON
        else if (chopperResult.error is Map<String, dynamic>) {
          final BasicResponse errorResponse = BasicResponse.fromJson(
              chopperResult.error as Map<String, dynamic>);
          return get_response.Response(
            statusCode: chopperResult.base.statusCode,
            headers: chopperResult.base.headers,
            body: null,
            statusText: errorResponse.message,
          );
        } else {
          // Handle unexpected error types
          return get_response.Response(
            statusCode: chopperResult.base.statusCode,
            headers: chopperResult.base.headers,
            body: null,
            statusText: 'An unknown error occurred',
          );
        }
      }
    } catch (e, stackTrace) {
      print('Error occurred: $e');
      print('Stack trace: $stackTrace');
      // Handle unexpected errors
      return get_response.Response(
        statusCode: 500,
        body: null,
        statusText: 'Something went wrong: $e',
      );
    }
  }
}

class BasicResponse {
  final String data;
  final String message;
  final int status;

  BasicResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) {
    return BasicResponse(
      data: json['data'] ?? '',
      message: json['message'] ?? 'Unknown error',
      status: json['status'] ?? 500,
    );
  }
}

class PayOrderResponse {
  final int id;
  final int userId;
  final double totalPrice;
  final String paymentMethod;
  final String orderStatus;
  final String createdAt;
  final String updatedAt;
  final double discount;

  PayOrderResponse({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.paymentMethod,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.discount,
  });

  // Factory method to parse JSON into PayOrderResponse object
  factory PayOrderResponse.fromJson(Map<String, dynamic> json) {
    return PayOrderResponse(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      discount: json['discount'] ?? 0.0,
    );
  }
}

class VoucherApiRepository extends OpenApiRepository<VoucherAppResponse> {
  VoucherApiRepository()
      : super(DefaultJsonDecoder<VoucherAppResponse>(
            (json) => VoucherAppResponse.fromJson(json)));

  // Method to search books and return a BookSearchResponse
  Future<get_response.Response<List<VoucherAppResponse>>> list_vouchers() async {
    // Make the API call and get a dynamic response
    final chopper_response.Response<List<VoucherAppResponse>> chopperResult =
        await openapi.apiAppVoucherUserGet(
      page: 1,
      limit: 1000,
    );

    // Convert the dynamic response to a MakeOrderResponse
    if (chopperResult.statusCode == 200) {
      final List<VoucherAppResponse> response = chopperResult.body!;

      return get_response.Response(
        statusCode: chopperResult.base.statusCode,
        headers: chopperResult.base.headers,
        body: response,
      );
    } else {
      throw Exception('Failed to get voucher! Please try again');
    }
  }
}
