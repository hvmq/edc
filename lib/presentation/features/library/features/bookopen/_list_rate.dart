part of 'speaking_book_screen.dart';

extension ListRate on SpeakingBookScreen {
  Widget _listRate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Evaluate (${controller.reviewsList.length})',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final String imageUrl = controller
                                    .bookDetail.value.images !=
                                null &&
                            controller.bookDetail.value.images!.isNotEmpty &&
                            controller
                                    .bookDetail.value.images!.first.imageUrl !=
                                null
                        ? controller.bookDetail.value.images!.first.imageUrl!
                        : ImageConstants.logo1;
                    Get.toNamed(AppRoutes.Rating, arguments: {
                      'idBook': controller.bookDetail.value.id ?? 0,
                      'title': controller.bookDetail.value.title ?? '',
                      'imageUrl': imageUrl,
                      'author': controller.bookDetail.value.author != null &&
                              controller.bookDetail.value.author!.name != null
                          ? controller.bookDetail.value.author!.name!
                          : 'No author info',
                    });
                  },
                  child: const Text(
                    'Write a review',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Obx(() => controller.reviewsList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.reviewsList.length,
                    itemBuilder: (context, index) {
                      final review = controller.reviewsList[index];
                      return ReviewCard(
                          review); // Pass the review data to ReviewCard
                    },
                  )
                : const Center(
                    child: Text(
                      'No reviews available',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget ReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.grey7,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //check if avatar is not url then use AssetImage
              review.avatarUrl != null &&
                      review.avatarUrl!.isNotEmpty &&
                      review.avatarUrl!.startsWith('http')
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(review.avatarUrl!),
                      radius: 20,
                    )
                  : const CircleAvatar(
                      backgroundImage: AssetImage(ImageConstants
                          .admission), // Replace with actual user avatar if available
                      radius: 20,
                    ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName ?? 'User Id ${review.userId}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    controller.getFormatDate(review.createdAt) ?? '',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color:
                    index < (review.rating ?? 0) ? Colors.yellow : Colors.grey,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            review.reviewText ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
