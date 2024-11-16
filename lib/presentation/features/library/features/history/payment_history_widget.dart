import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/repos/impl/history_api.swagger.dart';
import '../../core/utils/color.dart';

class PaymentHistoryWidget extends StatelessWidget {
  final List<OrderHistoryDetail> paymentHistoryItems;

  const PaymentHistoryWidget({required this.paymentHistoryItems, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            formattedPrice = '${(parsedPrice / 1000).toStringAsFixed(0)}k LP';
          } else {
            formattedPrice = '${(parsedPrice / 1000).toStringAsFixed(2)}k LP';
          }
        } else {
          formattedPrice = '${parsedPrice.toInt()} LP';
        }
      } catch (e) {
        print(e);
        // In case of error during parsing, show a fallback price
        formattedPrice = '0 LP';
      }
      return formattedPrice;
    }

    //create .. for text if to long
    String formatTextToLong(String text) {
      //hand word not break work only for one line
      if (text.length <= 30) {
        return text;
      }
      final List<String> words = text.split(' ');
      String newText = '';
      for (int i = 0; i < words.length; i++) {
        if (newText.length + words[i].length <= 30) {
          newText += '${words[i]} ';
        } else {
          newText += '...';
          break;
        }
      }
      return newText;
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      itemCount: paymentHistoryItems.length,
      itemBuilder: (context, index) {
        final item = paymentHistoryItems[index];
        return paymentHistoryCard(
          id: 1,
          title: formatTextToLong(item.title),
          amount: getPriceFormatter(item.pricePurchased),
          imageUrl: item.imageUrl,
          date: DateFormat('HH:mm, d MMM yyyy').format(item.orderedAt),
          type: item.resourceType,
        );
      },
    );
  }

  Widget paymentHistoryCard({
    required int id,
    required String title,
    required String amount,
    required String imageUrl,
    required String date,
    required String type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          // Get.toNamed(AppRoutes.BookDetail);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     blurRadius: 10,
            //     offset: const Offset(0, 5),
            //   ),
            // ],
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.all(2), // Padding around the container
                width: 120, // Width of the container
                decoration: BoxDecoration(
                  color:
                      AppColor.secondColor, // Background color of the container
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: ClipRRect(
                  // Added ClipRRect to ensure image respects the border radius
                  borderRadius: BorderRadius.circular(
                      12), // Matches the container's border radius
                  child: Image.network(
                    imageUrl, // URL of the image to display
                    width: 114, // Width of the image
                    height: 79, // Height of the image
                    fit: BoxFit
                        .cover, // Makes sure the image covers the entire area
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return const Center(
                          child: Icon(Icons
                              .error)); // Placeholder if the image fails to load
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColor.textColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      Text(
                        date,
                        style:
                            TextStyle(fontSize: 14, color: AppColor.greyColor),
                        softWrap: true,
                      ),
                      const SizedBox(height: 8),
                      RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(
                            text: type,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.blueColor_3,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  amount, // Display amount with a dollar sign
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.textColor,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
