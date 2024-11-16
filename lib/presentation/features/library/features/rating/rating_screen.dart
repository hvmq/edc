import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resource/resource.dart';
import '../../core/utils/color.dart';
import '../../core/utils/show_noti.dart';
import '../../features/rating/rating_controller.dart';

// The Evaluation Screen UI
class RatingScreen extends GetView<RatingController> {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Dismiss keyboard on tap
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.primaryColor, // Set primary background color
        appBar: AppBar(
          leadingWidth: 0,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: AppColor.textColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Back'.tr,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Row(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: controller.imageUrl.value.startsWith(
                              'http') // Kiểm tra nếu imageUrl là URL của mạng
                          ? Image.network(
                              controller.imageUrl
                                  .value, // Nếu là URL của mạng, hiển thị Image.network
                              height: 80,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              controller.imageUrl
                                  .value, // Nếu không phải URL của mạng, hiển thị Image.asset
                              height: 80,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.title.value,
                          style: TextStyle(
                              color: AppColor.textColor, fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.author.value,
                          style: TextStyle(
                              color: AppColor.greyColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ]),
                const SizedBox(width: 16),
                const SizedBox(height: 24),
                // Star Rating Row
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            Icons.star,
                            color: controller.rating.value > index
                                ? AppColor.yellowStar
                                : Colors.grey,
                            size: 30,
                          ),
                          onPressed: () => controller.updateRating(index + 1),
                        );
                      }),
                    )),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.grey7,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    maxLines: 6,
                    onChanged: (value) {
                      controller.feedbackText.value = value;
                    },
                    onSubmitted: (value) {
                      //turn off the keyboard
                      FocusScope.of(context).unfocus();
                    },
                    style: TextStyle(color: AppColor.textColor),
                    decoration: InputDecoration(
                      hintText: 'Please give us some comments and feedback!',
                      hintStyle: TextStyle(color: AppColor.textColor),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  await controller
                      .createReview(
                    controller.idBook.value,
                    controller.rating.value,
                    controller.feedbackText.value,
                  )
                      .then((value) {
                    if (value) {
                      print('Review submitted successfully!');

                      Get.back();

                      showSuccessWithTitle(
                          'Success', 'Review submitted successfully!');
                    } else {
                      showErrorWithTitle('Error', 'Failed to submit review.');
                    }
                  });

                  // Close the keyboard after tapping the button
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: AppColor.blueColor_2,
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      'Send'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.textColor,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
