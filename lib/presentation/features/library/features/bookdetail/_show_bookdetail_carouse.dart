part of 'book_detail_screen.dart';

extension ShowBookDetailCarouse on BookDetailScreen {
  Widget _showBookDetailCarouse(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: Get.height * 0.5,
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage(
                      ImageConstants.bgBook), // Add your image path here
                  fit: BoxFit.none,
                ),
                color: AppColor.primaryColor),
          ),
          _buildCarousel(),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Obx(() => SizedBox(
          height: Get.height * 0.46, // Set your desired height here
          child: CarouselSlider.builder(
            itemCount: controller.bookDetail.value.images!.isNotEmpty
                ? controller.bookDetail.value.images!.length
                : 1,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final String imageUrl =
                  controller.bookDetail.value.images != null &&
                          controller.bookDetail.value.images!.isNotEmpty &&
                          controller.bookDetail.value.images!
                                  .elementAt(index)
                                  .imageUrl !=
                              null
                      ? controller.bookDetail.value.images!
                          .elementAt(index)
                          .imageUrl!
                      : ImageConstants.logo1;
              return _buildCarouselItem(
                  controller.bookDetail.value.title ?? '', imageUrl);
            },
            options: CarouselOptions(
              height: 395,
              viewportFraction:
                  0.68, // Size of the visible portion of each item
              enlargeCenterPage: true, // Highlight the item in the center
              autoPlay: true, // Automatically transition between items
              autoPlayInterval: const Duration(
                  seconds: 5), // Increase interval for slower auto-play
              scrollPhysics: CustomScrollPhysics(),
            ),
          ),
        ));
  }

  Widget _buildCarouselItem(String title, String image) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(AppRoutes.BookOpen, arguments: { 'idBook': controller.bookDetail['id'] ?? 1, 'resourceLink': '',  'resourceType': ''});
      },
      child: AspectRatio(
        aspectRatio: 2 / 3, // Set your desired aspect ratio here
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     spreadRadius: 3,
            //     blurRadius: 6,
            //     offset: const Offset(0, 1), // Position of shadow
            //   ),
            // ],
          ),
          child: Column(
            children: [
              // Book Image
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.textColor,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16), bottom: Radius.circular(16)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16), bottom: Radius.circular(16)),
                    child: _buildImage(
                        image), // Use method to handle both online and asset images
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Method to handle both network and asset images
  Widget _buildImage(String image) {
    // Check if the image is a URL (for demonstration, you might want a better check)
    final bool isNetworkImage =
        image.startsWith('http://') || image.startsWith('https://');

    return isNetworkImage
        ? Image.network(image, fit: BoxFit.cover)
        : Image.asset(image,
            fit: BoxFit.cover); // Assuming 'image' is a valid asset path
  }
}

// Define custom scroll physics to adjust manual scroll speed
class CustomScrollPhysics extends ScrollPhysics {
  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics();
  }

  @override
  double get dragStartDistanceMotionThreshold => 4.0;

  @override
  Duration get duration => const Duration(
      milliseconds: 600); // Adjust the duration of the scrolling animation
}
