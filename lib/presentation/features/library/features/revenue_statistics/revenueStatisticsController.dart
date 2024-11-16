import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../all.dart';
import '../../api/repos/impl/revenue_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../core/utils/show_noti.dart';

class RevenuestatisticsController extends AppController {
  var bookRevenues = <BookRevenue>[].obs;
  var isLoading = false.obs;
  var books = <Book>[].obs;
  var revenueByBook = <BookRevenue>[].obs;
  var revenueOfABook = <RevenueOfABook>[].obs;
  RevenueByBookApiRepository revenueByBookApiRepository =
      RevenueByBookApiRepository();
  SummaryMyUploadBookApiRepository summaryMyUploadBookApiRepository =
      SummaryMyUploadBookApiRepository();
  OrderDetailOfBookApiRepository orderDetailOfBookApiRepository =
      OrderDetailOfBookApiRepository();
  RevenueOfABookApiRepository revenueOfABookApiRepository =
      RevenueOfABookApiRepository();

  var chartData = <double>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadRevenueByBook();
    await fetchRevenueByBook();
    await loadSummaryByMonth();
  }

  Future<void> loadSummaryByMonth() async {
    try {
      isLoading(true);
      final response =
          await summaryMyUploadBookApiRepository.get_summary_by_month();
      print(response.body);
      if (response.statusCode == 200 && response.body != null) {
        // Assuming response.body is of type Map<int, double>
        chartData.value =
            response.body!.values.toList(); // Convert values to List<double>
        print(chartData);
      } else {
        showErrorWithTitle('Error', 'Failed to fetch data.');
      }
    } catch (e) {
      showErrorWithTitle('Error', 'Failed to load data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadRevenueByABook(int? book) async {
    try {
      isLoading(true);
      final response =
          await revenueOfABookApiRepository.get_list_revenue_of_a_book(book);
      if (response.statusCode == 200 && response.body != null) {
        revenueOfABook.value = response.body!
            .map((e) => RevenueOfABook.fromJson(e.toJson()))
            .toList();
      } else {
        showErrorWithTitle('Error', 'Failed to fetch data.');
      }
    } catch (e) {
      showErrorWithTitle('Error', 'Failed to load data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<OrderDetailOfBook?> loadOrderDetailsBook(
      int? bookId, int? orderId) async {
    try {
      isLoading(true);

      final response = await orderDetailOfBookApiRepository
          .get_list_revenue_by_books(bookId, orderId);

      if (response.statusCode == 200 && response.body != null) {
        return response.body;
      } else {
        showErrorWithTitle('Error', 'Failed to fetch data.');
        return null;
      }
    } catch (e) {
      showErrorWithTitle('Error', 'Failed to load data: $e');
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadRevenueByBook() async {
    try {
      isLoading(true);
      final response =
          await revenueByBookApiRepository.get_list_revenue_by_books();
      if (response.statusCode == 200 && response.body != null) {
        revenueByBook.value = response.body!
            .map((e) => BookRevenue.fromJson(e.toJson()))
            .toList();
        // Populate chart data based on book revenue
        // chartData.value =
        //     revenueByBook.map((book) => book.price * book.quantity).toList();
        //     print(chartData);
      } else {
        showErrorWithTitle('Error', 'Failed to fetch data.');
      }
    } catch (e) {
      showErrorWithTitle('Error', 'Failed to load data: $e');
    } finally {
      isLoading(false);
    }
  }

  double getTotalRevenue() {
    return revenueByBook.fold(
        0, (sum, book) => sum + (book.price * book.quantity));
  }

  int getTotalBooksSold() {
    return revenueByBook.fold(0, (sum, book) => sum + book.quantity);
  }

  // Fetch revenue by book from API
  Future<void> fetchRevenueByBook() async {
    try {
      isLoading(true); // Start loading
      // API URL
      final url = Uri.parse(
          'https://lib-dev.educhain.tech/app/api/app/statistic/revenueByBook');
      final String token = Get.find<HomeController>().accessToken;
      // Send the GET request
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Decode the response body
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        // Check the status in the response
        if (responseData['status'] == 200) {
          // Map the JSON data to the list of BookRevenue
          final List<dynamic> data = responseData['data'];
          bookRevenues.value =
              data.map((item) => BookRevenue.fromJson(item)).toList();
        } else {
          showErrorWithTitle('Error', 'Failed to fetch data.');
        }
      } else {
        showErrorWithTitle('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      showErrorWithTitle('Error', 'Failed to load data: $e');
    } finally {
      isLoading(false); // End loading
    }
  }

  // getTotalBooksSold() {}
}

class BookRevenue {
  final double totalRevenue;
  final int quantity;
  final int id;
  final String title;
  final double price;

  BookRevenue({
    required this.totalRevenue,
    required this.quantity,
    required this.id,
    required this.title,
    required this.price,
  });

  // Factory method to create an instance from JSON
  factory BookRevenue.fromJson(Map<String, dynamic> json) {
    return BookRevenue(
      totalRevenue: (json['total_revenue'] as num).toDouble(),
      quantity: json['quantity'],
      id: json['id'],
      title: json['title'].toString().trim(),
      price: (json['price'] as num).toDouble(),
    );
  }
}

class Book {
  final String title;
  final String totalRevenue;
  final String totalBooksSold;
  final String unitPrice;

  Book({
    required this.title,
    required this.totalRevenue,
    required this.totalBooksSold,
    required this.unitPrice,
  });
}

class Order {
  final String orderNumber;
  final String date;
  final String nftNumber;
  final String price;

  Order({
    required this.orderNumber,
    required this.date,
    required this.nftNumber,
    required this.price,
  });
}
