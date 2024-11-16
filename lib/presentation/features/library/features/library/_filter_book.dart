part of 'library_screen.dart';

extension FiterBook on LibraryScreen {
  Widget _filterBook(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.features.length,
          itemBuilder: (context, index) {
            // Wrap the GestureDetector (or the part that depends on state) in Obx
            return Obx(() {
              return GestureDetector(
                key: ValueKey(controller.features[index]),
                onTap: () {
                  // Update the selected category and trigger loading
                  controller.currentCategory.value = controller.features[index];
                  controller.loadBooks(controller.features[index]);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 4, left: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
                  decoration: BoxDecoration(
                    color: controller.currentCategory.value ==
                            controller.features[index]
                        ? AppColor.blueColor_4.withOpacity(0.2)
                        : AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: controller.currentCategory.value ==
                              controller.features[index]
                          ? AppColor.blueColor_2
                          : AppColor.greyColor.withOpacity(0.2),
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    controller.features[index],
                    style: TextStyle(color: AppColor.textColor),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
