part of 'search_screen.dart';

extension SearchSuggestions on SearchScreen {
  Widget _searchSuggestions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Obx(() {
        // Observe changes in the filteredSearches list
        final filteredList = controller.filteredSearches;
        return filteredList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search Results'.tr, // Localized text for search results
                    style: TextStyle(
                      color: AppColor.blueColor_4,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap:
                        true, // To prevent ListView from taking full height
                    physics:const NeverScrollableScrollPhysics(),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return buildItem(title: filteredList[index], index: index);
                    },
                  ),
                ],
              )
            : Center(
                child: Text(
                  'No Results Found'.tr,
                  style: TextStyle(color: AppColor.greyColor, fontSize: 14),
                ),
              );
      }),
    );
  }
}
