part of 'speaking_book_screen.dart';

extension ControlBook on SpeakingBookScreen {
  Widget _controlBook(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: Get.height * 0.6,
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage(
                    ImageConstants.bgBook), // Add your image path here
                fit: BoxFit.none,
              ),
              color: AppColor.primaryColor),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 182,
              height: 273,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.blueColor_4, width: 1),
              ),
              margin: const EdgeInsets.only(bottom: 12, top: 12),
              alignment: Alignment.center,
              child: Obx(() => controller.isLoading.value == false
                  ? SizedBox(
                      width: 182,
                      height: 273,
                      child: CustomNetworkImage(
                        imageUrl: controller.bookDetail.value.images != null &&
                                controller
                                    .bookDetail.value.images!.isNotEmpty &&
                                controller.bookDetail.value.images!.first
                                        .imageUrl !=
                                    null
                            ? controller
                                .bookDetail.value.images!.first.imageUrl!
                            : ImageConstants.logo1,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: AppColor.blueColor_4,
                      ),
                    )),
            ),
            Obx(() => Container(
                  margin:
                      const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  child: Text(
                    '${controller.bookDetail.value.title}',
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 16,
                    ),
                  ),
                )),
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Chapter: ${controller.chapters.elementAt(controller.chapterIndex.value).title}',
                  style: TextStyle(color: AppColor.textColor),
                ),
              ),
            ),

            Container(
              width: Get.width * 0.8,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Obx(() => Slider(
                    value: controller.currentPosition.value.inSeconds
                                .toDouble() >
                            controller.audioDuration.value.inSeconds.toDouble()
                        ? controller.audioDuration.value.inSeconds.toDouble()
                        : controller.currentPosition.value.inSeconds.toDouble(),
                    min: 0,
                    max: controller.audioDuration.value.inSeconds.toDouble(),
                    onChanged: (value) {
                      // Update the position when the user interacts with the slider
                      controller.seekAudio(Duration(seconds: value.toInt()));
                    },
                    activeColor: AppColor.textColor,
                    inactiveColor: AppColor.textColor.withOpacity(0.3),
                  )),
            ),
            Obx(() => Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${controller.currentPosition.value.inMinutes}:${(controller.currentPosition.value.inSeconds % 60).toString().padLeft(2, '0')} / ${controller.audioDuration.value.inMinutes}:${(controller.audioDuration.value.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                )),

            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.rewindAudio();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: EdgeInsets.zero,
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.tua),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('next');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: EdgeInsets.zero,
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.next),
                      ),
                    ),
                  ),
                  Obx(() => GestureDetector(
                      onTap: () {
                        controller.isPlaying.value == true
                            ? controller.pauseAudio()
                            : controller.playAudio();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: AppColor.blueColor_2,
                              borderRadius: BorderRadius.circular(50)),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            controller.isPlaying.value == true
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 36,
                            color: AppColor.textColor,
                          ),
                        ),
                      ))),
                  GestureDetector(
                    onTap: () {
                      print('next');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: EdgeInsets.zero,
                        width: 24,
                        height: 24,
                        child: Image.asset(
                          IconConstants
                              .next1, // Thay đổi đường dẫn đến hình ảnh của bạn
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.fastForwardAudio();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: EdgeInsets.zero,
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.tua1),
                      ),
                    ),
                  ),
                ],
              ),
            ), // Play/Pause button
          ],
        )
      ],
    );
  }

  void showChapterListSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Chapter list',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.chapters.value.length,
                  itemBuilder: (context, index) {
                    final chapter = controller.chapters.value[index];
                    return ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: controller.chapterIndex.value == index
                              ? AppColor.blueColor_3
                              : AppColor.textColor,
                        ),
                      ),
                      title: Text(
                        chapter.title ??
                            "", // assuming each chapter has a 'title' key
                        style: TextStyle(
                          color: controller.chapterIndex.value == index
                              ? AppColor.blueColor_3
                              : AppColor.textColor,
                          fontWeight: controller.chapterIndex.value == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      onTap: () {
                        controller.selectChapter(index);
                        Navigator.pop(context);
                        Get.offNamed(
                          controller.bookDetail.value.resourceType == 'eBook'
                              ? AppRoutes.ReadingPdf
                              : AppRoutes.SpeakingBook,
                          arguments: {
                            'resourceLink': controller.chapters
                                    .elementAt(index)
                                    .resourceLink ??
                                '',
                            'chapterId':
                                controller.chapters.elementAt(index).id ?? '',
                            'idBook': controller.bookDetail.value.id ?? 0,
                            'resourceType':
                                controller.bookDetail.value.resourceType ?? '',
                            'chapters': controller.chapters,
                            'indexChapter': index,
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showPlaybackSpeedSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Playback speed',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ...[0.5, 0.8, 0.9, 1.0, 1.5, 2.0].map((speed) {
                  return ListTile(
                    title: Text(
                      '${speed}x',
                      style: TextStyle(
                        color: controller.playbackSpeed.value == speed
                            ? AppColor.blueColor_3
                            : AppColor.textColor,
                        fontWeight: controller.playbackSpeed.value == speed
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      controller.setPlaybackSpeed(speed);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
