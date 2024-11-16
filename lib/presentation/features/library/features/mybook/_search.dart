part of 'mybook_screen.dart';

extension Search on MyBookScreen {
  Widget _search(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: TextField(
        controller: controller.searchController.value,
        onChanged: (value) {
          controller.updateFilteredBooks(value);
        },
        onSubmitted: (value) {
          // Handle the search when Enter is pressed
          controller.updateFilteredBooks(
              value); // Ensure the filtered books are updated
          // You can add any additional actions you want to take when Enter is pressed
          FocusScope.of(context).unfocus(); // Dismiss the keyboard
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColor.greyColor),
          prefixIcon: Icon(Icons.search, color: AppColor.greyColor),
          filled: true,
          fillColor: AppColor.primaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: BorderSide(color: AppColor.greyColor.withOpacity(0.2)),
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
