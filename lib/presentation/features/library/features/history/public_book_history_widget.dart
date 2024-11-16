import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../api/repos/impl/history_api.swagger.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';

class PublicBookHistory extends StatelessWidget {
  final List<PublicBookHistoryDetail> historyItems;

  const PublicBookHistory({required this.historyItems, super.key});

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

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      itemCount: historyItems.length,
      itemBuilder: (context, index) {
        final item = historyItems[index];
        return _buildHistoryCard(
          id: item.bookId,
          title: item.title,
          imageUrl: item.imageUrl,
          author: item.authorName,
          chaptersNumber: 0,
          date: DateFormat('dd/MM/yyyy').format(item.requestedAt),
          loyaltyPoints: getPriceFormatter(item.price),
          category: '',
          ageAverage: item.ageAverage.toInt(),
        );
      },
    );
  }

  Widget _buildHistoryCard({
    required int id,
    required String title,
    required String imageUrl,
    required String author,
    required int chaptersNumber,
    required String date,
    required String loyaltyPoints,
    required String category,
    required int ageAverage,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.BookDetail, arguments: {'idBook': id});
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      width: 120,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Center(child: Icon(Icons.error));
                          },
                        ),
                      ),
                    ),
                    if (ageAverage > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF0E81FC), // Starting color
                                Color(0xFF369C09), // Ending color
                              ],
                            ),
                          ),
                          child: Text(
                            'T$ageAverage',
                            style: TextStyle(color: AppColor.textColor),
                          ),
                        ),
                      ),
                    if (category.isNotEmpty)
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.blueColor_1,
                          ),
                          child: Text(
                            category,
                            style: TextStyle(color: AppColor.textColor),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColor.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                          text: TextSpan(children: [
                        WidgetSpan(
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: Image.asset(
                              IconConstants.iconLa,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: ' $author',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ])),
                      const SizedBox(height: 8),
                      if (chaptersNumber > 0)
                        RichText(
                            text: TextSpan(children: [
                          WidgetSpan(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: Image.asset(
                                IconConstants.iconBooks,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: ' $chaptersNumber Chapters',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.greyColor,
                            ),
                          ),
                        ])),
                      const SizedBox(height: 4),
                      RichText(
                          text: TextSpan(children: [
                        WidgetSpan(
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: Image.asset(
                              IconConstants.iconTime,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: ' $date',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ])),
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: GradientText(
                          loyaltyPoints,
                          style: const TextStyle(fontSize: 14.0),
                          gradientType: GradientType.radial,
                          radius: 2.5,
                          colors: const [
                            Color(0xFF0E81FC), // Start color
                            Color(0xFF369C09), // End color
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
