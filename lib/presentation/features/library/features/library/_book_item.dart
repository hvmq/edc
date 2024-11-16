import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';

Widget bookItem({
  required String? title,
  required String? image,
  required String? author,
  required String? price,
  required VoidCallback? onTap,
  String? category,
  String? ageAverage,
}) {
  // Try parsing the price as a double and handle formatting
  String formattedPrice;
  try {
    //handle category
    if (category == null || category == '' || category == 'Unknown') {
      category = null;
    }

    //handle price
    final double priceValue = double.parse(price ?? '0');

    // Format price: If price is over 1000, convert to "1k", else show the price as-is
    if (priceValue > 1000) {
      if (priceValue % 1000 == 0) {
        formattedPrice =
            '${(priceValue / 1000).toStringAsFixed(0)}k Loyalty Point';
      } else {
        formattedPrice =
            '${(priceValue / 1000).toStringAsFixed(2)}k Loyalty Point';
      }
    } else {
      // Show price without any modification
      formattedPrice = '${priceValue.toInt()} Loyalty Point';
    }
  } catch (e) {
    // In case of error during parsing, show a fallback price
    formattedPrice = '0 Loyalty Point';
  }

  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                // If the image is available, show it; otherwise, show a placeholder image
                image != null && image.isNotEmpty
                    ? Image.network(
                        image,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'lib/core/utils/resource/image/default-book.png',
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                // Age Indicator: Only show if age is valid (not null or -1)
                if (ageAverage != null && ageAverage != '-1')
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
                // Category Label: Only show if category is not empty
                if (category != null && category.isNotEmpty)
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
                        style: TextStyle(color: AppColor.textWhileColor),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Book Title
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              title ?? 'Unknown Title',
              style: TextStyle(
                color: AppColor.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1, // Limit to 1 line
              overflow: TextOverflow.ellipsis, // Ellipsis for overflow
            ),
          ),
          // Author Information
          Container(
            padding: EdgeInsets.zero,
            child: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    width: 16,
                    height: 16,
                    child: Image.asset(IconConstants.users),
                  ),
                ),
                TextSpan(
                  text: author ?? 'Unknown Author',
                  style: TextStyle(color: AppColor.greyColor),
                )
              ]),
            ),
          ),
          // Price Information
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: GradientText(
              formattedPrice,
              style: const TextStyle(fontSize: 12.0),
              gradientType: GradientType.radial,
              radius: 2.5,
              colors: const [
                Color(0xFF0E81FC), // Starting color
                Color(0xFF369C09), // Ending color
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
