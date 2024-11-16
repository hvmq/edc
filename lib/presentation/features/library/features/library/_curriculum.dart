part of 'library_screen.dart';

extension Curriculum on LibraryScreen {
  Widget _curriculum(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 2,
                  height: 21,
                  decoration: BoxDecoration(
                    color: AppColor.greenColor_1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Image.asset(IconConstants.curriculum),
                ),
                Expanded(
                    child: Text(
                  'Curriculum'.tr,
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
                GestureDetector(
                  onTap: () {
                    List<BookRaw> list = controller.listVideos
                        .map((e) => BookRaw.fromVideoBook(e))
                        .toList();
                    Get.toNamed(AppRoutes.SeeMore, arguments: {
                      'title': 'Curriculum'.tr,
                      'list': list,
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'See more'.tr,
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontSize: 14,
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: AppColor.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Reactive ListView.builder wrapped in Obx
            // Obx(() {
            //   return SizedBox(
            //     height: Get.height * 0.16, // Provide a fixed height
            //     child: ListView.builder(
            //       padding: const EdgeInsets.all(0),
            //       scrollDirection: Axis.horizontal,
            //       itemCount: controller.listVideos.length, // Reactive length
            //       itemBuilder: (context, index) {
            //         final video = controller.listVideos[index];
            //         String formattedPrice;
            //         try {
            //           //handle price
            //           double priceValue = video.price ?? 0;

            //           // Format price: If price is over 1000, convert to "1k", else show the price as-is
            //           if (priceValue > 1000) {
            //             // Convert to integer first, then apply the "k" format
            //             formattedPrice =
            //                 '${(priceValue / 1000).toStringAsFixed(0)}k Loyalty Point';
            //           } else {
            //             // Show price without any modification
            //             formattedPrice = '${priceValue.toInt()} Loyalty Point';
            //           }
            //         } catch (e) {
            //           // In case of error during parsing, show a fallback price
            //           formattedPrice = '0 Loyalty Point';
            //         }
            //         return Container(
            //           alignment: Alignment.center,
            //           width: Get.width - 40,
            //           margin: const EdgeInsets.only(right: 10),
            //           child: _buildItemCuriculum(
            //             video.title ?? 'Unknown',
            //             video.imageUrl ?? ImageConstants.admission,
            //             'no data',
            //              formattedPrice ?? '0 Loyalty Point',
            //             () {
            //               Get.toNamed(AppRoutes.BookDetail, arguments: {
            //                 'idBook': controller.listVideos[index].id
            //               });
            //             },
            //           ),
            //         );
            //       },
            //     ),
            //   );
            // }),

            // Static ListView.builder (no Obx needed if not reactive)
            Obx(() {
              return SizedBox(
                height: Get.height * 0.16, // Provide a fixed height
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.listVideos.length, // Reactive length
                  itemBuilder: (context, index) {
                    final video = controller.listVideos[index];
                    String formattedPrice;
                    try {
                      //handle price
                      double priceValue = video.price ?? 0;

                      // Format price: If price is over 1000, convert to "1k", else show the price as-is
                      if (priceValue > 1000) {
                        // Convert to integer first, then apply the "k" format
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
                    return Container(
                      alignment: Alignment.center,
                      width: Get.width - 40,
                      margin: const EdgeInsets.only(right: 10),
                      child: _buildItemCuriculum(
                        video.title ?? 'Unknown',
                        video.imageUrl ?? ImageConstants.admission,
                        'no data',
                        formattedPrice ?? '0 Loyalty Point',
                        () {
                          Get.toNamed(AppRoutes.BookDetail,
                              arguments: {'idBook': video.id});
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ));
  }

  Widget _buildItemCuriculum(String? title, String? imagePath, String? time,
      String? price, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: Get.width * 0.34,
              child: (imagePath != null && imagePath.isNotEmpty)
                  ? Image.network(
                      imagePath,
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
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wrapping the title in Marquee widget for auto-scrolling
                  Container(
                    height: 24, // Set height for the Marquee
                    child: Marquee(
                      text: title ?? 'Unknown', // The title to scroll
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      scrollAxis: Axis.horizontal, // Scroll horizontally
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace:
                          20.0, // Space after the text ends before repeating
                      velocity: 30.0, // Scrolling speed
                      pauseAfterRound:
                          Duration(seconds: 2), // Pause between scrolls
                      startPadding: 10.0, // Start padding for the scroll
                      accelerationDuration: Duration(seconds: 1),
                      decelerationDuration: Duration(milliseconds: 500),
                      accelerationCurve: Curves.linear,
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: EdgeInsets.zero,
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.ph_video),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Text(
                          'Video'.tr,
                          style: TextStyle(
                              color: AppColor.textColor, fontSize: 14),
                        ),
                      ),
                      // Container(
                      //   width: 4,
                      //   height: 4,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: AppColor.greyColor,
                      //   ),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.only(left: 4),
                      //   child: Text(
                      //     time ?? 'no data',
                      //     style: TextStyle(
                      //         color: AppColor.whiteColor.withOpacity(0.8),
                      //         fontSize: 14),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      ''.tr,
                      style: TextStyle(
                          color: AppColor.textColor.withOpacity(0.8),
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: GradientText(
                      '$price',
                      style: const TextStyle(fontSize: 12.0),
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.blueColor_1,
                borderRadius: BorderRadius.circular(24),
              ),
              child: SizedBox(
                width: 24,
                height: 24,
                child: (imagePath != null && imagePath.isNotEmpty)
                    ? Image.network(
                        imagePath,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'lib/core/utils/resource/image/default-book.png', // Path to your placeholder image
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
