part of 'search_screen.dart';

extension RecentlySearched on SearchScreen {
  Widget _recentlySearched(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              child: Text(
                'Recently searched'.tr,
                style: TextStyle(
                  color: AppColor.blueColor_4,
                  fontSize: 16,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.recentSearches.length, // dynamic length
              itemBuilder: (context, index) {
                return buildItem(
                    title: controller.recentSearches[index],
                    index: index,
                    isRecent: true);
              },
            ),
          ],
        ));
  }

  Widget buildItem(
      {required String title, int index = 0, bool isRecent = false}) {
    return GestureDetector(
      onTap: () {
        print(title);
        print(index);
        print(isRecent);
        if (isRecent) {
          controller.searchController.value.text =
              controller.recentSearches[index];
        } else {
          controller.searchController.value.text =
              controller.filteredSearches[index];
        }

        controller.bookSearchText.value =
            controller.searchController.value.text;
        controller.addSearchQuery(controller.searchController.value.text);
        controller.searchBooks(
          controller.searchController.value.text,
          controller.sortBy.value,
          controller.evaluate.value,
          controller.format.value,
          controller.author.value,
          controller.state.value,
          controller.categories.value,
          controller.fromPrice.value,
          controller.toPrice.value,
          controller.publishers.value,
          controller.languages.value,
          controller.fromPublicationYear.value,
          controller.toPublicationYear.value,
        );

        Get.toNamed(AppRoutes.SearchDetailScreen);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: Get.width,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColor.greyColor.withOpacity(0.5),
              width: 0.2,
            ),
          ),
        ),
        child: Text(
          title.tr,
          style: TextStyle(
            color: AppColor.greyColor.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
