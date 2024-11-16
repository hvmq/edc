part of 'mybook_screen.dart';

extension Tab on MyBookScreen {
  Widget _tab(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        child: Row(
          children: [
            Obx(
              () => GestureDetector(
                onTap: () async {
                  await controller.fetchBooksPurchased();
                  controller.turnOnPurchased();
                  if (controller.isAuthor.value == true) {
                    await controller.loadBookByAuthors();
                  } else {
                    await controller.loadBookByDate();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: BoxDecoration(
                    color: controller.tabName.value == 'Purchased'
                        ? AppColor.blueColor_4.withOpacity(0.2)
                        : AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: controller.tabName.value == 'Purchased'
                            ? AppColor.blueColor_2
                            : AppColor.greyColor.withOpacity(0.2)),
                  ),
                  child: Text(
                    'Purchased',
                    style: TextStyle(color: AppColor.textColor),
                  ),
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: () async {
                  await controller.fetchBooksPublic();
                  controller.turnOnPublic();
                  if (controller.isAuthor.value == true) {
                    await controller.loadBookByAuthors();
                  } else {
                    await controller.loadBookByDate();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: BoxDecoration(
                    color: controller.tabName.value == 'Publiced'
                        ? AppColor.blueColor_4.withOpacity(0.2)
                        : AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: controller.tabName.value == 'Publiced'
                            ? AppColor.blueColor_2
                            : AppColor.greyColor.withOpacity(0.2)),
                  ),
                  child: Text(
                    'Publiced',
                    style: TextStyle(color: AppColor.textColor),
                  ),
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: () async {
                  await controller.fetchBooksUnPublic();
                  controller.turnOnUnPublic();
                  if (controller.isAuthor.value == true) {
                    await controller.loadBookByAuthors();
                  } else {
                    await controller.loadBookByDate();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: BoxDecoration(
                    color: controller.tabName.value == 'UnPubliced'
                        ? AppColor.blueColor_4.withOpacity(0.2)
                        : AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: controller.tabName.value == 'UnPubliced'
                            ? AppColor.blueColor_2
                            : AppColor.greyColor.withOpacity(0.2)),
                  ),
                  child: Text(
                    'UnPubliced',
                    style: TextStyle(color: AppColor.textColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
