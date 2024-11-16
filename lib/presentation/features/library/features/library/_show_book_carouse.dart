part of 'library_screen.dart';

extension ShowBookCarouse on LibraryScreen {
  Widget _showBookCarouse(BuildContext context) {
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
    return SizedBox(
      height: Get.height * 0.46, // Set your desired height here
      child: Obx(() => CarouselSlider.builder(
            itemCount: controller.books.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              if (controller.isLoadingCarousel.value == true) {
                return Card(
                  elevation: 9,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.blueColor_3),
                    ),
                  ),
                );
              }

              // If books are available, show the carousel
              if (controller.books.isEmpty) {
                return Center(
                  child: Text(
                    'No data',
                    style: TextStyle(color: AppColor.textColor),
                  ),
                );
              }

              final book = controller.books[index];
              return _buildCarouselItem(
                  title: book.title ?? '', // Explicitly cast title to String
                  image: (book.imageUrl != null && book.imageUrl!.isNotEmpty)
                      ? (book.imageUrl! as String?) ?? ''
                      : '',
                  idBook: book.id ?? 0);
            },
            options: CarouselOptions(
              height: 395,
              viewportFraction: 0.68,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              scrollPhysics: CustomScrollPhysics(),
            ),
          )),
    );
  }

  Widget _buildCarouselItem(
      {required String? title, required String? image, required int? idBook}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.BookDetail, arguments: {'idBook': idBook});
        print('idBook $idBook');
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
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: (image != null && image.isNotEmpty)
                        ? Image.network(
                            image,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'lib/core/utils/resource/image/default-book.png', // Path to your placeholder image
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              // Title Section
              Container(
                margin: const EdgeInsets.only(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.blueColor_2,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title!,
                        style: TextStyle(
                            fontSize: 12, color: AppColor.textWhileColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('play button');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColor.textWhileColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.play_circle,
                          size: 16,
                          color: AppColor.blueColor_2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
