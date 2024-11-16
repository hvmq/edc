part of 'search_detail_screen.dart';

extension SearchDetail on SearchDetailScreen {
  Widget _searchDetail(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: TextField(
        controller: controller.searchController.value,
        onChanged: (value) {
          controller.bookSearchText.value = value;
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
          controller.bookSearchText.value = value;
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
          FocusScope.of(context).unfocus(); // Dismiss the keyboard
        },
        decoration: InputDecoration(
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
        ),
      ),
    );
  }
}
