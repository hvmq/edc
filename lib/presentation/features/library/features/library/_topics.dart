part of 'library_screen.dart';

extension Topics on LibraryScreen {
  Widget _topics(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.grey7,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: EdgeInsets.zero,
                  width: 29,
                  height: 29,
                  child: Image.asset(IconConstants.topics),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Topics'.tr,
                    style: TextStyle(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          Obx(() => Wrap(
                spacing: 8.0, // Khoảng cách giữa các phần tử theo chiều ngang
                runSpacing: 8.0, // Khoảng cách giữa các hàng khi xuống dòng
                children: List.generate(
                  controller.categories.length,
                  (index) {
                    return GestureDetector(
                        onTap: () async {
                          await controller
                              .loadBookByCategoryId(
                                  controller.categories[index].id)
                              .then((value) {
                            final List<BookRaw> list =
                                controller.categoriesAppResponse.value.map((e) {
                              final BookRaw br =
                                  BookRaw.fromRetrieveBookByCategoryId(e);
                              print('br.category: ${br.category}');
                              if (br.category.isEmpty ||
                                  br.category.trim() == 'Unknown') {
                                br.category =
                                    controller.categories[index].name ?? '';
                              }
                              print('br.category: ${br.category}');
                              return br;
                            }).toList();
                            Get.toNamed(AppRoutes.SeeMore, arguments: {
                              'title':
                                  'Topic: ${controller.categories[index].name}' ??
                                      'Topics',
                              'id': controller.categories[index].id ?? '',
                              'list': list
                            });
                            return value;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal:
                                  12), // Padding cho không gian bên trong
                          decoration: BoxDecoration(
                            color: AppColor.textBlackColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            controller.categories[index].name ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.textWhileColor,
                              fontSize: 16,
                            ),
                          ),
                        ));
                  },
                ),
              ))
        ],
      ),
    );
  }
}
