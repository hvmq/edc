part of 'search_screen.dart';

extension Search on SearchScreen {
  Widget _search(BuildContext context) {
    return Obx(() => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          child: TextField(
            controller: controller.searchController.value,
            onChanged: (value) {
              controller.bookSearchText.value = value;
              controller.updateSearchResults1(value);
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
            },
            onSubmitted: (value) {
              controller.searchController.value.text = value;
              controller.bookSearchText.value = value;
              controller.addSearchQuery(value);
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
              FocusScope.of(context).unfocus(); // Dismiss the keyboard
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              hintText: 'Search',
              hintStyle: TextStyle(color: AppColor.greyColor),
              prefixIcon: Icon(Icons.search, color: AppColor.greyColor),
              filled: true,
              fillColor: AppColor.blueColor_1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(
              color: AppColor.textColor, // Custom color for input text
              fontSize: 16, // Adjust font size as needed
              fontWeight: FontWeight.w400, // Adjust font weight as needed
            ),
          ),
        ));
  }
}
