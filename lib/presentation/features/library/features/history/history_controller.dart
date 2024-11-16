import 'dart:async';

import 'package:get/get.dart';

import '../../api/repos/impl/history_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../generated_code/openapi.models.swagger.dart';

class HistoryController extends AppController {
  final OrderDetailsHistoryApiRepository orderDetailsHistoryApiRepository =
      OrderDetailsHistoryApiRepository();
  final PublicBookHistoryApiRepository publicBookHistoryApiRepository =
      PublicBookHistoryApiRepository();
  final BookProgressHistoryApiRepository bookProgressHistoryApiRepository =
      BookProgressHistoryApiRepository();

  RxList<PublicBookHistoryDetail> approvedBooks =
      <PublicBookHistoryDetail>[].obs;
  RxList<OrderHistoryDetail> paymentHistoryItems = <OrderHistoryDetail>[].obs;
  RxList<BookReadingResponse> bookReadingResponse = <BookReadingResponse>[].obs;

  var statusList = ['NEW', 'WAITING', 'PUBLIC', 'UNPUBLIC', 'REJECT'];
  var sortTypeList = ['DESC', 'ASC'];
  RxInt tabIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString selectedStatus = 'WAITING'.obs;
  RxString selectedSortType = 'DESC'.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await loadPublicBookHistory();
    await loadOrderDetailsHistory();
    await loadBookProgressHistory();
    isLoading.value = false;
  }

  Future<void> loadPublicBookHistory({String? status}) async {
    try {
      final response =
          await publicBookHistoryApiRepository.get_public_book_history(
        status: status ?? statusList[1], // Default to 'WAITING'
      );
      if (response.body != null && response.statusCode == 200) {
        approvedBooks.value = response.body!;
      }
    } catch (e) {
      print('Error loading public book history: $e');
    }
  }

  Future<void> loadOrderDetailsHistory({String? sortType}) async {
    try {
      final response = await orderDetailsHistoryApiRepository.get_order_history(
        sortType: sortType ?? sortTypeList[0], // Default to 'DESC'
      );
      if (response.body != null && response.statusCode == 200) {
        paymentHistoryItems.value = response.body!;
      }
    } catch (e) {
      print('Error loading order details history: $e');
    }
  }

  Future<void> loadBookProgressHistory() async {
    try {
      final response =
          await bookProgressHistoryApiRepository.get_book_progress_history();
      if (response.body != null && response.statusCode == 200) {
        bookReadingResponse.value = response.body!;
      }
    } catch (e) {
      print('Error loading book progress history: $e');
    }
    // bookReadingResponse.value = await bookProgressHistoryApiRepository.fetchReadingProgress();
  }

  // Filter method for Public History tab
  Future<void> applyFilter(String status) async {
    isLoading.value = true;
    await loadPublicBookHistory(status: status);
    isLoading.value = false;
  }

  // Sort method for Reading History and Payment History tabs
  Future<void> applySort(String sortType) async {
    isLoading.value = true;
    if (tabIndex.value == 1) {
      await loadOrderDetailsHistory(sortType: sortType);
    } else if (tabIndex.value == 2) {
      paymentHistoryItems.sort((a, b) => sortType == 'DESC'
          ? b.orderedAt.compareTo(a.orderedAt)
          : a.orderedAt.compareTo(b.orderedAt));
    }
    isLoading.value = false;
  }

  // Helper method to update tab index and refresh content
  void setTabIndex(int index) {
    tabIndex.value = index;
    isLoading.value = true;
    switch (index) {
      case 0:
        loadPublicBookHistory();
        break;
      case 1:
        loadBookProgressHistory();
        break;
      case 2:
        loadOrderDetailsHistory();
        break;
    }
    isLoading.value = false;
  }

  String getPriceFormatter(dynamic priceValue) {
    String formattedPrice;
    try {
      double parsedPrice;

      // If the price is already a double, use it directly; otherwise, try parsing it as a string.
      if (priceValue is double) {
        parsedPrice = priceValue;
      } else {
        parsedPrice = double.tryParse(priceValue?.toString() ?? '0') ?? 0;
      }

      // Format price: If price is over 1000, convert to "1k", else show the price as-is
      if (parsedPrice >= 1000) {
        if (parsedPrice % 1000 == 0) {
          formattedPrice =
              '${(parsedPrice / 1000).toStringAsFixed(0)}k Loyalty Point';
        } else {
          formattedPrice =
              '${(parsedPrice / 1000).toStringAsFixed(2)}k Loyalty Point';
        }
      } else {
        formattedPrice = '${parsedPrice.toInt()} Loyalty Point';
      }
    } catch (e) {
      print(e);
      // In case of error during parsing, show a fallback price
      formattedPrice = '0 Loyalty Point';
    }
    return formattedPrice;
  }
}
