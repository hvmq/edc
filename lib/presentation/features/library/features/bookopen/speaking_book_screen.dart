import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resource/resource.dart';
import '../../api/repos/impl/review_book_api.swagger.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../core/utils/resource/assets_constant/image_constant.dart';
import '../../core/utils/wigdet/custom_network_image.dart';
import '../../features/bookopen/book_open_controller.dart';
import '../../features/bookopen/speaking/widget/video_play.dart';

part '_control_book.dart';
part '_group_button.dart';
part '_list_rate.dart';

class SpeakingBookScreen extends GetView<BookOpenController> {
  const SpeakingBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<VideoPlayerWidgetState> videoPlayerKey = GlobalKey();
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: _buildAppBarTitle(context, videoPlayerKey: videoPlayerKey),
      ),
      body: Obx(
        () => controller.isBookOpening.value
            ? _buildBookOpeningScreen(context)
            : _buildSpeakingBookScreen(context, videoPlayerKey: videoPlayerKey),
      ),
    );
  }

  // AppBar Title Section
  Widget _buildAppBarTitle(BuildContext context,
      {required GlobalKey<VideoPlayerWidgetState> videoPlayerKey}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.arrow_back, color: AppColor.textColor),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    const WidgetSpan(child: SizedBox(width: 12)),
                    TextSpan(
                      text: 'Back'.tr,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.getBookmarks().then((value) {
                if (controller.resourceType.value == 'Video' &&
                    videoPlayerKey.currentState != null) {
                  videoPlayerKey.currentState!.showBookmarkListSheet(context);
                } else {
                  showBookmarkListSheet(context);
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.tran,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset(IconConstants.iconBook),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBookmarkListSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Obx(() {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Indicator bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bookmarks',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Bookmark List
                if (controller.bookmarks.isEmpty)
                  Center(
                    child: Text(
                      'No bookmarks added.',
                      style: TextStyle(color: AppColor.textColor),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.bookmarks.length,
                      itemBuilder: (context, index) {
                        final bookmark = controller.bookmarks[index];
                        return ListTile(
                          leading:
                              Icon(Icons.bookmark, color: AppColor.blueColor_3),
                          title: Text(
                            bookmark.title ?? 'No title',
                            style: TextStyle(
                              color: AppColor.textColor,
                            ),
                          ),
                          subtitle: Text(
                            'Position: ${(bookmark.position / 60).toInt()}:${(bookmark.position.toInt() % 60).toString().padLeft(2, '0')} sec',
                            style: TextStyle(
                              color: AppColor.greyColor,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller
                                  .deleteMark(bookmark.id); // Delete bookmark
                            },
                          ),
                          onTap: () {
                            // Seek to the saved position in the audio
                            controller.seekAudio(
                                Duration(seconds: bookmark.position.toInt()));
                            Navigator.pop(context); // Close the bottom sheet
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        });
      },
    );
  }

  // Book Opening Screen (Progress)
  Widget _buildBookOpeningScreen(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: Get.height,
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage(ImageConstants.bgBook),
                fit: BoxFit.none,
              ),
              color: AppColor.primaryColor),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBookImage(),
            _buildOpeningText(),
            _buildProgressIndicator(),
            _buildLoadingPercentage(),
          ],
        ),
      ],
    );
  }

  // Components for Book Opening Screen
  Widget _buildBookImage() {
    return Container(
      width: 150,
      height: 240,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.blueColor_4),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      alignment: Alignment.center,
      child: Obx(
        () => controller.isLoading.value == false
            ? SizedBox(
                width: 150,
                height: 240,
                child: CustomNetworkImage(
                  imageUrl: controller.bookDetail.value.images != null &&
                          controller.bookDetail.value.images!.isNotEmpty &&
                          controller.bookDetail.value.images!.first.imageUrl !=
                              null
                      ? controller.bookDetail.value.images!.first.imageUrl!
                      : ImageConstants.logo1,
                ),
              )
            : Center(
                child: CircularProgressIndicator(color: AppColor.blueColor_4),
              ),
      ),
    );
  }

  Widget _buildOpeningText() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      alignment: Alignment.center,
      child: Text(
        'Opening...',
        style: TextStyle(
          color: AppColor.textColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      width: Get.width * 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0E81FC), Color(0xFF369C09)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
        () => LinearProgressIndicator(
          value: controller.loadingProgress.value / 100,
          backgroundColor: AppColor.textColor.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.textColor),
        ),
      ),
    );
  }

  Widget _buildLoadingPercentage() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Obx(
        () => Text(
          '${controller.loadingProgress.value}%',
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSpeakingBookScreen(BuildContext context,
      {required GlobalKey<VideoPlayerWidgetState> videoPlayerKey}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          controller.resourceType.value == 'Video'
              ? Obx(() => Column(
                    children: [
                      VideoPlayerWidget(
                        videoUrl:
                            'https://lib-dev.educhain.tech/app/api/app/books/viewBook?fileName=${Get.arguments['resourceLink']}',
                        title: '${controller.bookDetail.value.title}',
                        bookId: controller.bookDetail.value.id ?? 0,
                        chapterId: controller
                                .chapters[controller.chapterIndex.value].id ??
                            0,
                        key: videoPlayerKey,
                      ),
                    ],
                  ))
              : Column(
                  children: [
                    _controlBook(context),
                    _groupButton(context),
                  ],
                ),
          _listRate(context),
        ],
      ),
    );
  }
}
