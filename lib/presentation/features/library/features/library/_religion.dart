part of 'library_screen.dart';

extension Religion on LibraryScreen {
  Widget _religion(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 2,
                height: 21,
                decoration: BoxDecoration(
                  color: AppColor.greenColor_1,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Image.asset(IconConstants.iconStar),
              ),
              Expanded(
                child: Text(
                  'Religion books'.tr,
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () {
                  List<BookRaw> list = controller.religionResponse.map((e) {
                    BookRaw br = BookRaw.fromRetrieveBookByCategoryId(e);
                    br.category = 'Religion';
                    return br;
                  }).toList();
                  Get.toNamed(AppRoutes.SeeMore,
                      arguments: {'title': 'Religion'.tr, 'list': list});
                },
                child: Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'See more'.tr,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 14,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColor.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Recommended Books List
          Obx(() {
            if (controller.religionResponse.isEmpty) {
              return SizedBox(); // Return an empty SizedBox to avoid gaps
            }
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.religionResponse.length,
                      itemBuilder: (context, index) {
                        final book = controller.religionResponse[index];
                        return Container(
                          width: Get.width / 2 - 20,
                          margin: const EdgeInsets.only(right: 10),
                          child: bookItem(
                            title: book.title,
                            image: book.imageUrl,
                            author: book.author?.name,
                            category: 'Religion',
                            price: book.price?.toString(),
                            ageAverage: controller
                                .calculateBookAge(book.ageAverage ?? 0),
                            onTap: () {
                              Get.toNamed(AppRoutes.BookDetail,
                                  arguments: {'idBook': book.id});
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
