import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/repos/impl/book_details_api_swagger.dart';
import '../../api/repos/impl/order_api.swagger.dart';
import '../../api/repos/impl/public_book_api.swagger.dart';
import '../../core/utils/show_noti.dart';
import '../../generated_code/openapi.models.swagger.dart';

class CartController extends GetxController {
  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  final OrderApiRepository _orderApiRepository = OrderApiRepository();
  final PayOrderApiRepository _payOrderApiRepository = PayOrderApiRepository();
  final BookDetailsApiRepository _bookDetailsApiRepository =
      BookDetailsApiRepository();
  final GetUserInfoApiRepository _getUserInfoApiRepository =
      GetUserInfoApiRepository();
  final VoucherApiRepository _voucherApiRepository = VoucherApiRepository();

  var selectedIndices = <int>[].obs;
  RxBool isStatus = true.obs;
  RxString descriptionResponse = ''.obs;

  RxString totalLoyaltyPoint = '0'.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadCartItems(); // Load cart from local storage when the app starts
    await fetchVouchers();
    totalLoyaltyPoint.value = getPriceFormatter(await getTotaLoyaltyPoint())
        .replaceAll('Loyalty Point', '');
  }

  //get name of book id
  Future<String> getBookName(int? id) async {
    final response = await _bookDetailsApiRepository.get_book_by_id(id);
    if (response.statusCode == 200 && response.body != null) {
      return response.body!.title ?? 'Unknown';
    } else {
      return 'Unknown';
    }
  }

  Future<double> getTotaLoyaltyPoint() async {
    final response = await _getUserInfoApiRepository.get_info();
    if (response.statusCode == 200 && response.body != null) {
      return response.body!.balance;
    } else {
      return 0.0;
    }
  }

  Future<MakeOrderResponse?> makeOrder() async {
    try {
      // Retrieve the book IDs from cartItems (selected items)
      final List<int> bookIds =
          getSelectedBookIds(); // Ensure this is not empty

      if (bookIds.isEmpty) {
        showSuccessWithTitle(
            'No Books Selected', 'Please select at least one book.');
        return null;
      }

      // Retrieve the voucherId, set it to null if no voucher is selected
      final int? voucherIndex =
          selectedVoucherIndex.value == -1 ? null : selectedVoucherIndex.value;

      //get voucher id
      final voucherId = voucherIndex != null ? vouchers[voucherIndex].id : null;
      // Make the API call to create an order
      final response = await _orderApiRepository.make_order(bookIds, voucherId);

      // Check if the API call is successful
      if (response.statusCode == 200 && response.body != null) {
        // Show success message
        // Get.snackbar(
        //     'Order Processing', 'Your order is currently pending ...');
        // Return the response body containing the MakeOrderResponse
        return response.body!;
      } else {
        isStatus.value = false;
        return null;
      }
    } catch (e) {
      // Handle any errors during the API call
      isStatus.value = false;
      descriptionResponse.value = '$e'.replaceAll('Exception:', '');
      // Get.snackbar('Error', 'Something went wrong: $e');
      return null; // Return null in case of an exception
    }
  }

  Future<PayOrderResponse?> payOrder(int? orderId) async {
    try {
      // Make the API call to create an order
      final response = await _payOrderApiRepository.payOrder(orderId);
      // Check if the API call is successful
      if (response.statusCode == 200 && response.body != null) {
        // Clear the cart and selections after successful order
        //only clear item purchased
        for (int index in selectedIndices) {
          cartItems.removeAt(index);
        }

        clearSelections();
        isStatus.value = true;
        // Show success message
        // showSuccessWithTitle(
        //     'Order Successful', 'Your order has been placed successfully');
        descriptionResponse.value = '';
        // Return the response body containing the MakeOrderResponse
        return response.body!;
      } else if (response.body == null && response.statusCode == 503) {
        // showErrorWithTitle('Order Faild', 'Not enough balance');
        isStatus.value = false;
        descriptionResponse.value = 'Your balace is not enough!';
        return null;
      } else {
        descriptionResponse.value =
            'Unfortunately, your payment could not be processed. Please try again or contact support.';
        isStatus.value = false;
        return null;
      }
    } catch (e) {
      isStatus.value = false;
      descriptionResponse.value = '$e';
      // Handle any errors during the API call
      // showErrorWithTitle('Error', 'Something went wrong: $e');
      return null; // Return null in case of an exception
    }
  }

  // Save cart to SharedPreferences
  Future<void> saveCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cartJson = jsonEncode(cartItems);
    await prefs.setString('cartItems', cartJson);
  }

  // Load cart from SharedPreferences
  Future<void> loadCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString('cartItems');
    if (cartJson != null) {
      final List<dynamic> items = jsonDecode(cartJson);
      cartItems.value = List<Map<String, dynamic>>.from(items);
    }
  }

  // Clear all cart items
  Future<void> clearCartItems() async {
    cartItems.clear();
    saveCartItems(); // Save after clearing
    selectedIndices.clear(); // Clear selections
    update(); // Update the UI
  }

  // Add new product to cart (no quantity management)
  void addItem(int id, String name, double price, String image, String author,
      String category) {
    // Check if the item already exists in the cart by its id
    final existingItemIndex = cartItems.indexWhere((item) => item['id'] == id);

    if (existingItemIndex == -1) {
      // If the item does not exist, add it to the cart
      cartItems.add({
        'id': id,
        'name': name,
        'price': price,
        'image': image,
        'author': author,
        'category': category,
      });

      // Save the updated cart to SharedPreferences
      saveCartItems();

      // Refresh the cart items to update the UI
      cartItems.refresh();
    }
  }

  // Remove product from cart by ID
  void removeItemById(String id) {
    cartItems.removeWhere((item) => item['id'] == id);
    saveCartItems(); // Save after removing
  }

  // Remove product from cart by b
  void removeItem(int index) {
    cartItems.removeAt(index);
    saveCartItems(); // Save after removing
  }

  // Calculate total price of selected items
  double getTotalPrice() {
    double total = 0.0;

    // Iterate through selected items
    for (int index in selectedIndices) {
      final item = cartItems[index]; // Get item by index
      total += item['price'] as double; // Add item price to total
    }

    return total;
  }

  // Toggle item selection
  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index); // Deselect
    } else {
      selectedIndices.add(index); // Select
    }

    selectedIndices.refresh(); // Refresh selection state to update UI
  }

// Retrieve selected book IDs
  List<int> getSelectedBookIds() {
    final List<int> bookIds = [];

    // Iterate through selected items and get their IDs from cartItems
    for (int index in selectedIndices) {
      final item = cartItems[index];
      bookIds.add(item['id'] as int);
    }

    return bookIds;
  }

  void clearSelections() {
    selectedIndices.clear(); // Clear all selections
    update(); // Update UI
  }

  void selectAllItems() {
    selectedIndices.clear();
    for (int i = 0; i < cartItems.length; i++) {
      selectedIndices.add(i);
    }
    update(); // Notify listeners about the change
  }

  // Vouchers
  var vouchers = <Voucher>[].obs;
  var selectedVoucherIndex = (-1).obs;
  var voucherCode = ''.obs;

  void selectVoucher(int index) {
    if (index < 0 || index >= vouchers.length) {
      selectedVoucherIndex.value = -1;
      voucherCode.value = '';
      return;
    }
    selectedVoucherIndex.value = index;
    voucherCode.value = vouchers[index].discountPercent % 1 == 0
        ? 'Discount ${vouchers[index].discountPercent.toInt()}%'
        : 'Discount ${vouchers[index].discountPercent.toStringAsFixed(2)}%';
  }

  String getVoucherPercent() {
    if (selectedVoucherIndex.value == -1) {
      return '0%';
    }
    return vouchers[selectedVoucherIndex.value].discountPercent % 1 == 0
        ? '${vouchers[selectedVoucherIndex.value].discountPercent.toInt()}%'
        : '${vouchers[selectedVoucherIndex.value].discountPercent.toStringAsFixed(2)}%';
  }

  double computeVoucher() {
    final totalPrice = getTotalPrice();
    final voucher = vouchers[selectedVoucherIndex.value];
    final discount = totalPrice * voucher.discountPercent / 100.0;
    return discount > voucher.maxDiscountAmount
        ? voucher.maxDiscountAmount
        : discount;
  }

  Future<void> fetchVouchers() async {
    try {
      await _voucherApiRepository.list_vouchers().then((response) {
        if (response.statusCode == 200 && response.body != null) {
          vouchers.clear();
          for (VoucherAppResponse voucher in response.body!) {
            vouchers.add(Voucher(
              title: voucher.code!,
              code: voucher.code!,
              expiration: DateFormat('dd MMM yyyy').format(voucher.endDate!),
              discountPercent: voucher.discountPercentage!,
              maxDiscountAmount: voucher.maxDiscountAmount!,
              id: voucher.id!,
            ));
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  String shortenString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input; // Return original string if it's shorter than or equal to maxLength
    } else {
      return '${input.substring(0, maxLength - 3)}...'; // Cut string and add ellipsis
    }
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

class Voucher {
  String title;
  String code;
  String expiration;
  double discountPercent;
  double maxDiscountAmount;
  int id;

  Voucher({
    required this.title,
    required this.code,
    required this.expiration,
    required this.discountPercent,
    required this.maxDiscountAmount,
    required this.id,
  });
}
