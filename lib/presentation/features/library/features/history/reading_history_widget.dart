import 'package:flutter/material.dart';

import '../../core/utils/color.dart';
import '../../generated_code/openapi.models.swagger.dart';

class ReadingHistoryWidget extends StatelessWidget {
  final List<BookReadingResponse> readingHistoryItems;

  const ReadingHistoryWidget({required this.readingHistoryItems, super.key});

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      //compute for today is ... days ago
      final now = DateTime.now();
      final difference = now.difference(date);
      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      }
      return '${difference.inDays} days ago';
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      itemCount: readingHistoryItems.length,
      itemBuilder: (context, index) {
        final item = readingHistoryItems[index];
        return readingHistoryCard(
          id: item.bookId,
          title: item.title ?? '',
          imageUrl: item.imageUrl ?? '',
          date: formatDate(item.lastReadAt ?? DateTime.now()),
          extraInfo: 'Continue Reading',
        );
      },
    );
  }

  Widget readingHistoryCard({
    required int? id,
    required String title,
    required String imageUrl,
    required String date,
    required String extraInfo,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          // Get.toNamed(AppRoutes.BookDetail, arguments: {'idBook': id});
          // Get.toNamed(
          //   controller.bookDetail.value.resourceType == 'eBook'
          //       ? AppRoutes.ReadingPdf
          //       : AppRoutes.SpeakingBook,
          //   arguments: {
          //     'resourceLink': chapters.elementAt(index).resourceLink,
          //     'chapterId': chapters.elementAt(index).id,
          //     'idBook': controller.bookDetail.value.id,
          //     'resourceType': controller.bookDetail.value.resourceType,
          //     'rating': controller.bookResponses,
          //     'chapters': chapters,
          //     'indexChapter': index,
          //   },
          // );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     blurRadius: 10,
            //     offset: const Offset(0, 5),
            //   ),
            // ],
          ),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(2), // Padding around the container
                width: 120, // Width of the container
                height: 90, // Height of the container
                decoration: BoxDecoration(
                  color:
                      AppColor.secondColor, // Background color of the container
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: ClipRRect(
                  // Added ClipRRect to ensure image respects the border radius
                  borderRadius: BorderRadius.circular(
                      12), // Matches the container's border radius
                  child: Image.network(
                    imageUrl, // URL of the image to display
                    width: 114, // Width of the image
                    height: 79, // Height of the image
                    fit: BoxFit
                        .cover, // Makes sure the image covers the entire area
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return const Center(
                          child: Icon(Icons
                              .error)); // Placeholder if the image fails to load
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColor.textColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        date,
                        style:
                            TextStyle(fontSize: 14, color: AppColor.greyColor),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {},
                        child: RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                              text: extraInfo,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.blueColor_3,
                              ),
                            ),
                            const WidgetSpan(child: SizedBox(width: 4)),
                            WidgetSpan(
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColor.blueColor_3.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: AppColor.blueColor_3,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
