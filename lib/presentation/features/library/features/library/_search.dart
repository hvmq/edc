part of 'library_screen.dart';

extension Search on LibraryScreen {
  Widget _search(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.SearchModule);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: TextField(
          controller: controller.searchController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            hintText: 'Search',
            hintStyle: TextStyle(color: AppColor.greyColor),
            prefixIcon: Icon(Icons.search, color: AppColor.greyColor),
            filled: true,
            fillColor: AppColor.textWhileColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide:
                  BorderSide(color: AppColor.greyColor.withOpacity(0.2)),
            ),
          ),
          style: TextStyle(
            color: AppColor.textColor, // Custom color for input text
            fontSize: 16, // Adjust font size as needed
            fontWeight: FontWeight.w400, // Adjust font size as needed00
          ),
          enabled: false,
        ),
      ),
    );
  }
}
