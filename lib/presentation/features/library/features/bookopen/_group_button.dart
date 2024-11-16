part of 'speaking_book_screen.dart';

extension GroupButton on SpeakingBookScreen {
  Widget _groupButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buttonIcon(
            icon: IconConstants.mark,
            onTap: () {
              _showSaveMarkDialog(context); // Show mark dialog
            },
            title: 'Mark'.tr,
          ),
          buttonIcon(
            icon: IconConstants.chapter,
            onTap: () {
              showChapterListSheet(context);
            },
            title: 'Chapter'.tr,
          ),
          buttonIcon(
            icon: IconConstants.speed,
            onTap: () {
              showPlaybackSpeedSheet(context);
            },
            title: 'Speed'.tr,
          ),
        ],
      ),
    );
  }

  void _showSaveMarkDialog(BuildContext context) {
    //format the current position to a readable time format
    String currentTime =
        'Mark at ${controller.currentPosition.value.inMinutes}:${(controller.currentPosition.value.inSeconds % 60).toString().padLeft(2, '0')}';
    final TextEditingController titleController =
        TextEditingController(text: currentTime);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Save Mark"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter a title for the mark",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                final String title = titleController.text;
                if (title.isNotEmpty) {
                  _saveMark(title); // Save the mark
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _saveMark(String title) {
    // Call your controller or service to save the mark
    controller.saveMark(
      title: title,
      currentPosition: controller.currentPosition.value.inSeconds,
    );

    Get.snackbar(
      'Mark Saved',
      'Mark "$title" saved at ${controller.currentPosition.value.inMinutes}:${(controller.currentPosition.value.inSeconds % 60).toString().padLeft(2, '0')}',
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.blueAccent,
    );
  }

  Widget buttonIcon(
      {required String icon,
      required Function() onTap,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColor.textColor.withOpacity(0.1),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: EdgeInsets.zero,
                width: 24,
                height: 24,
                child: Image.asset(icon),
              ),
            ),
            Text(
              title,
              style: TextStyle(color: AppColor.textColor),
            )
          ],
        ),
      ),
    );
  }
}
