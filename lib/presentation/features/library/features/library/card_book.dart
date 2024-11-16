import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../core/utils/resource/assets_constant/image_constant.dart';

Widget bookItemCart(
    String? title,
    String? image,
    String? author,
    String? category,
    String? price,
    String? ageAverage,
    VoidCallback? onTap,
    int? type,
    VoidCallback? onTapFavorite) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    image != null && image.isNotEmpty
                        ? Image.network(
                            image,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            ImageConstants.books, // Path to your default image
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
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
                                Color(0xFF0E81FC), // Starting color (#0E81FC)
                                Color(0xFF369C09), // Ending color (#369C09)
                              ],
                            ),
                          ),
                          child: Text(
                            'T$ageAverage',
                            style: TextStyle(color: AppColor.textColor),
                          ),
                        )),
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
                            category!,
                            style: TextStyle(color: AppColor.textColor),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  title!,
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1, // Limit to 1 line
                  overflow:
                      TextOverflow.ellipsis, // Show ellipsis when overflow
                ),
              ),
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
                  )),
                  TextSpan(
                      text: author, style: TextStyle(color: AppColor.greyColor))
                ])),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: GradientText(
                  '$price Loyalty Point',
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                  gradientType: GradientType.radial,
                  radius: 2.5,
                  colors: const [
                    Color(0xFF0E81FC), // Start color (#0E81FC)
                    Color(0xFF369C09), // End color (#369C09)
                  ],
                ),
              )
            ],
          ),
          type == 1
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: onTapFavorite,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColor.textColor,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColor.redColor,
                      ),
                    ),
                  ))
              : Container(),
        ],
      ),
    ),
  );
}
