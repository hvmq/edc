
import 'package:get/get_connect/http/src/response/response.dart'
    as get_response;
import 'package:chopper/chopper.dart' as chopper_response;
import '../../decoder/impl/default_json_decoder.dart';
import '../abs_openapi.swagger.dart';

class RevenueByBookApiRepository extends OpenApiRepository<RevenueByBook> {
  RevenueByBookApiRepository()
      : super(DefaultJsonDecoder<RevenueByBook>(
            (json) => RevenueByBook.fromJson(json)));

  Future<get_response.Response<List<RevenueByBook>>>
      get_list_revenue_by_books() async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppStatisticRevenueByBookPost();

    final List<RevenueByBook> response = (chopperResult.body as List)
        .map((json) => RevenueByBook.fromJson(json as Map<String, dynamic>))
        .toList();
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }
}

class RevenueByBook {
  final double totalRevenue;
  final int quantity;
  final int id;
  final String title;
  final double price;

  // Constructor
  RevenueByBook({
    required this.totalRevenue,
    required this.quantity,
    required this.id,
    required this.title,
    required this.price,
  });

  // Factory method to create a Book from a JSON map
  factory RevenueByBook.fromJson(Map<String, dynamic> json) {
    return RevenueByBook(
      totalRevenue: json['total_revenue'].toDouble(),
      quantity: json['quantity'],
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
    );
  }

  // Method to convert a Book object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'total_revenue': totalRevenue,
      'quantity': quantity,
      'id': id,
      'title': title,
      'price': price,
    };
  }
}

class OrderDetailOfBookApiRepository
    extends OpenApiRepository<OrderDetailOfBook> {
  OrderDetailOfBookApiRepository()
      : super(DefaultJsonDecoder<OrderDetailOfBook>(
            (json) => OrderDetailOfBook.fromJson(json)));

  Future<get_response.Response<OrderDetailOfBook>> get_list_revenue_by_books(
      int? bookId, int? orderId) async {
    final chopper_response.Response<dynamic> chopperResult = await openapi
        .apiAppStatisticOrderDetailOfBookPost(bookId: bookId, orderId: orderId);

    final OrderDetailOfBook response = (chopperResult.body as List)
        .map((json) => OrderDetailOfBook.fromJson(json as Map<String, dynamic>))
        .toList()[0];

    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }
}

class OrderDetailOfBook {
  final String lastName;
  final String firstName;
  final int orderId;
  final String authorName;
  final String paymentMethod;
  final double bookPrice;
  final int userId;
  final String email;
  final String orderCreatedAt;
  final int bookId;
  final String bookTitle;

  // Constructor
  OrderDetailOfBook({
    required this.lastName,
    required this.firstName,
    required this.orderId,
    required this.authorName,
    required this.paymentMethod,
    required this.bookPrice,
    required this.userId,
    required this.email,
    required this.orderCreatedAt,
    required this.bookId,
    required this.bookTitle,
  });

  // Factory method to create an Order from a JSON map
  factory OrderDetailOfBook.fromJson(Map<String, dynamic> json) {
    return OrderDetailOfBook(
      lastName: json['lastName'],
      firstName: json['fistName'],
      orderId: json['orderId'],
      authorName: json['authorName'],
      paymentMethod: json['paymentMethod'],
      bookPrice: json['bookPrice'].toDouble(),
      userId: json['userId'],
      email: json['email'],
      orderCreatedAt: json['orderCreatedAt'],
      bookId: json['bookId'],
      bookTitle: json['bookTitle'].trim(),
    );
  }

  // Method to convert an Order object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'lastName': lastName,
      'fistName': firstName,
      'orderId': orderId,
      'authorName': authorName,
      'paymentMethod': paymentMethod,
      'bookPrice': bookPrice,
      'userId': userId,
      'email': email,
      'orderCreatedAt': orderCreatedAt,
      'bookId': bookId,
      'bookTitle': bookTitle,
    };
  }
}

class RevenueOfABookApiRepository extends OpenApiRepository<RevenueOfABook> {
  RevenueOfABookApiRepository()
      : super(DefaultJsonDecoder<RevenueOfABook>(
            (json) => RevenueOfABook.fromJson(json)));

  Future<get_response.Response<List<RevenueOfABook>>>
      get_list_revenue_of_a_book(int? bookId) async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppStatisticRevenueOfBookPost(id: bookId);

    final List<RevenueOfABook> response = (chopperResult.body["orderByBook"]
            as List)
        .map((json) => RevenueOfABook.fromJson(json as Map<String, dynamic>))
        .toList();
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }
}

class RevenueOfABook {
  final int id;
  final int orderId;
  final int bookId;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Constructor
  RevenueOfABook({
    required this.id,
    required this.orderId,
    required this.bookId,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an Order from a JSON map
  factory RevenueOfABook.fromJson(Map<String, dynamic> json) {
    return RevenueOfABook(
      id: json['id'],
      orderId: json['orderId'],
      bookId: json['bookId'],
      price: json['price'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to convert an Order object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'bookId': bookId,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class SummaryMyUploadBookApiRepository extends OpenApiRepository<RevenueData> {
  SummaryMyUploadBookApiRepository()
      : super(DefaultJsonDecoder<RevenueData>(
            (json) => RevenueData.fromJson(json)));

  Future<get_response.Response<RevenueOfABook>>
      get_summary_my_upload_book() async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppStatisticSumaryMyUploadBookPost();

    final RevenueOfABook response = RevenueOfABook.fromJson(chopperResult.body);
    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: response,
    );
  }

  Future<get_response.Response<Map<int, double>>> get_summary_by_month() async {
    final chopper_response.Response<dynamic> chopperResult =
        await openapi.apiAppStatisticSumaryMyUploadBookPost();

    // {revenewByBook: {}, quantity: 2, revenewByMonth: {10: {total_nevenue: 43.0, month: 10, year: 2024}}, totalRevenue: 43.0}
    // Parse the JSON data
    if (chopperResult.body == null) {
      throw Exception('Failed to load data');
    }
    final Map<String, dynamic> parsedJson =
        chopperResult.body as Map<String, dynamic>;

    // // Create a map for total revenue by month
    Map<int, double> revenueMap = {};

    // // Get the revenewByMonth data
    final revenueByMonth = parsedJson['revenewByMonth'] as Map<String, dynamic>;

    for (int i = 1; i <= 12; i++) {
      revenueMap.putIfAbsent(i, () => 0);
    }
    // // Fill the revenueMap
    for (var entry in revenueByMonth.entries) {
      int month = int.parse(entry.key); // month as key
      double totalRevenue =
          entry.value['total_nevenue'] ?? 0; // total_nevenue as value
      revenueMap[month] = totalRevenue; // add to the map
    }

    // // Optionally, fill missing months with zero revenue

    return get_response.Response(
      statusCode: chopperResult.base.statusCode,
      headers: chopperResult.base.headers,
      body: revenueMap,
    );
  }
}

class RevenueData {
  final Map<String, dynamic> revenewByBook;
  final int quantity;
  final Map<String, RevenueByMonth> revenewByMonth;
  final double totalRevenue;

  // Constructor
  RevenueData({
    required this.revenewByBook,
    required this.quantity,
    required this.revenewByMonth,
    required this.totalRevenue,
  });

  // Factory method to create RevenueData from a JSON map
  factory RevenueData.fromJson(Map<String, dynamic> json) {
    return RevenueData(
      revenewByBook: json['revenewByBook'] ?? {},
      quantity: json['quantity'],
      revenewByMonth: (json['revenewByMonth'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, RevenueByMonth.fromJson(value)),
      ),
      totalRevenue: json['totalRevenue'].toDouble(),
    );
  }

  // Method to convert RevenueData object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'revenewByBook': revenewByBook,
      'quantity': quantity,
      'revenewByMonth': revenewByMonth.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      'totalRevenue': totalRevenue,
    };
  }
}

class RevenueByMonth {
  final double totalRevenue;
  final int month;
  final int year;

  // Constructor
  RevenueByMonth({
    required this.totalRevenue,
    required this.month,
    required this.year,
  });

  // Factory method to create RevenueByMonth from a JSON map
  factory RevenueByMonth.fromJson(Map<String, dynamic> json) {
    return RevenueByMonth(
      totalRevenue: json['total_nevenue'].toDouble(),
      month: json['month'],
      year: json['year'],
    );
  }

  // Method to convert RevenueByMonth object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'total_nevenue': totalRevenue,
      'month': month,
      'year': year,
    };
  }
}
