part of 'book_detail_screen.dart';

extension InforBookDetail on BookDetailScreen {
  Widget _inforBookDetail(
      BuildContext context, ScrollController scrollController) {
    void scrollToSection({required double offset}) {
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Obx(() => Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Text(
                  controller.bookDetail.value.title ?? '',
                  style: TextStyle(fontSize: 16, color: AppColor.textColor),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (controller.calculateBookAge(
                          '${controller.bookDetail.value.ageAverage}') !=
                      null
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF0E81FC), // Starting color (#0E81FC)
                            Color(0xFF369C09), // Ending color (#369C09)
                          ],
                        ),
                      ),
                      child: Text(
                        'T${controller.bookDetail.value.ageAverage ?? ''}',
                        style: TextStyle(color: AppColor.textColor),
                      ),
                    )
                  : Container()),
              Obx(() => GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.DetailAuthor, arguments: {
                        'idAuthor': controller.bookDetail.value.author != null
                            ? controller.bookDetail.value.author!.id
                            : 0
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: RichText(
                          text: TextSpan(children: [
                        WidgetSpan(
                            child: Container(
                          margin: const EdgeInsets.only(right: 4),
                          width: 16,
                          height: 16,
                          child: Image.asset(IconConstants.users),
                        )),
                        TextSpan(
                            text: controller.bookDetail.value.author != null &&
                                    controller.bookDetail.value.author!.name !=
                                        null
                                ? '${controller.bookDetail.value.author!.name}' // Hiển thị tên tác giả nếu có
                                : 'No author info',
                            style: TextStyle(color: AppColor.greyColor)),
                        controller.bookDetail.value.author != null &&
                                controller.bookDetail.value.author!.name != null
                            ? TextSpan(
                                text: '  >',
                                style: TextStyle(
                                  color: AppColor.greyColor,
                                  fontSize: 18,
                                ))
                            : const TextSpan(text: ''),
                      ])),
                    ),
                  )),
            ],
          ),
          controller.bookDetail.value.bookReviewResponse != null &&
                  controller.getBookRating() != '0'
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RichText(
                      text: TextSpan(children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.star,
                          color: AppColor.yellowColor,
                          size: 16,
                        ),
                      ),
                    ),
                    TextSpan(
                        text: controller.getBookRating(),
                        style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: ' (${controller.getNumberOfBookReviews()})',
                        style: TextStyle(
                            color: AppColor.greyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ])),
                )
              : const SizedBox(),
          Obx(() {
            String formattedPrice;
            try {
              final price = controller.bookDetail.value.price;
              final priceValue = price!;
              // Format price: If price is over 1000, convert to "1k", else show the price as-is
              if (priceValue >= 1000) {
                if (priceValue % 1000 == 0) {
                  formattedPrice =
                      '${(priceValue / 1000).toStringAsFixed(0)}k Loyalty Point';
                } else {
                  formattedPrice =
                      '${(priceValue / 1000).toStringAsFixed(2)}k Loyalty Point';
                }
              } else {
                formattedPrice = '${priceValue.toInt()} Loyalty Point';
              }
            } catch (e) {
              print(e);
              // In case of error during parsing, show a fallback price
              formattedPrice = '0 Loyalty Point';
            }

            return Container(
              margin: const EdgeInsets.only(top: 4),
              child: GradientText(
                formattedPrice,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                gradientType: GradientType.radial,
                radius: 2.5,
                colors: const [
                  Color(0xFF0E81FC), // Màu bắt đầu (#0E81FC)
                  Color(0xFF369C09),
                ],
              ),
            );
          }),
          Container(
            margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    controller.selectFavorite.value =
                        !controller.selectFavorite.value;
                    final String message = await controller.toggleFavourite(
                        bookId: controller.bookDetail.value.id ?? 1);
                  },
                  child: Obx(() => Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColor.greyColor, width: 2),
                      ),
                      child: Icon(
                        controller.selectFavorite.value == true
                            ? Icons.favorite
                            : Icons.favorite_outline_sharp,
                        color: controller.selectFavorite.value == true
                            ? Colors.pink
                            : AppColor.greyColor,
                        size: 24,
                      ))),
                ),
                Expanded(
                  child: Column(
                    children: [
                      // Primary button: Read Now or Add to Cart
                      GestureDetector(
                        onTap: () async {
                          if (!controller.isBookPurchased.value &&
                              controller.bookType.value != 'UnPubliced' &&
                              controller.bookType.value != 'Publiced') {
                            // Case: Book is public and not purchased
                            cartController.addItem(
                              controller.bookDetail.value.id ?? 0,
                              controller.bookDetail.value.title ?? '',
                              controller.bookDetail.value.price ?? 0,
                              controller.getFirstBookImage(),
                              controller.getAuthorOfBook() ?? '',
                              controller.getCategoryOfBook(),
                            );
                            controller.feedbackMessage.value =
                                'Book added to your cart!';
                            Future.delayed(const Duration(seconds: 1), () {
                              controller.feedbackMessage.value = '';
                            });
                          } else {
                            // Case: Book is public and purchased, open the first chapter
                            if (controller.bookDetail.value.chapters != null &&
                                controller
                                    .bookDetail.value.chapters!.isNotEmpty) {
                              Get.toNamed(
                                controller.bookDetail.value.resourceType ==
                                        'eBook'
                                    ? AppRoutes.ReadingPdf
                                    : AppRoutes.SpeakingBook,
                                arguments: {
                                  'resourceLink':
                                      controller.bookDetail.value.chapters !=
                                              null
                                          ? controller.bookDetail.value
                                              .chapters!.first.resourceLink
                                          : '',
                                  'chapterId':
                                      controller.bookDetail.value.chapters !=
                                              null
                                          ? controller.bookDetail.value
                                              .chapters!.first.id
                                          : '',
                                  'idBook': controller.bookDetail.value.id,
                                  'resourceType': controller
                                          .bookDetail.value.resourceType ??
                                      '',
                                  'chapters':
                                      controller.bookDetail.value.chapters,
                                  'rating': controller.bookResponses,
                                  'indexChapter': 0,
                                },
                              );
                            } else {
                              // Show a dialog if no chapters are available
                              showCommonDialog(
                                content: 'No chapter available',
                                title: '',
                                context: context,
                              );
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: AppColor.blueColor_3,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (!controller.isBookPurchased.value &&
                                  controller.bookType.value != 'UnPubliced' &&
                                  controller.bookType.value != 'Publiced')
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  width: 24,
                                  height: 24,
                                  child: Image.asset(IconConstants
                                      .addCart), // Icon only for Add to Cart
                                ),
                              Text(
                                (!controller.isBookPurchased.value &&
                                        controller.bookType.value !=
                                            'UnPubliced' &&
                                        controller.bookType.value != 'Publiced')
                                    ? 'Add to cart'.tr
                                    : 'Read now'.tr,
                                style: TextStyle(
                                    color: AppColor.textOppositeColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Secondary button: Register to Publish or Waiting for Publish Acceptance
                      if (controller.bookType.value == 'UnPubliced')
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: GestureDetector(
                            onTap: () async {
                              if (controller.bookType.value == 'UnPubliced') {
                                if (controller.isAlreadySendRequest.value) {
                                  //no thing to do
                                } else {
                                  // Case: Book is unpubliced and no request has been sent
                                  await controller.publicABookRequest(
                                      controller.bookDetail.value.id ?? 0);
                                  // showSuccessWithTitle(
                                  //     "Success", "Request has been sent");
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    controller.feedbackMessage.value = '';
                                  });
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(
                                color: controller.isAlreadySendRequest.value
                                    ? AppColor.greyColor
                                    : AppColor.blueColor_3,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: Center(
                                child: Text(
                                  controller.isAlreadySendRequest.value
                                      ? 'Waiting for publish acceptance'.tr
                                      : 'Register to publish'.tr,
                                  style: TextStyle(color: AppColor.textColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(() => Text(
                controller.feedbackMessage.value,
                style: const TextStyle(
                  color: Colors.green, // Hoặc màu bạn muốn
                  fontSize: 16,
                ),
              )),
          Obx(() {
            // Check the description length
            final String description =
                controller.bookDetail.value.description ?? '';
            const int wordLimit = 300;
            final List<String> words = description.split(' ');
            // Conditionally show full or partial description
            final String displayedText =
                controller.isExpanded.value || words.length <= wordLimit
                    ? description
                    : '${words.sublist(0, wordLimit).join(' ')}...';

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.bookDetail.value.publisher != null &&
                      controller.bookDetail.value.publisher!.name != null &&
                      controller.bookDetail.value.publisher!.name!.isNotEmpty)
                    _buildDetailRow(IconConstants.file1,
                        controller.bookDetail.value.publisher!.name!),

                  if (controller.bookDetail.value.isbn != null &&
                      controller.bookDetail.value.isbn!.isNotEmpty)
                    _buildDetailRow(
                        IconConstants.code, controller.bookDetail.value.isbn!),

                  if (controller.bookDetail.value.readingTime != null)
                    _buildDetailRow(
                        IconConstants.clock,
                        controller.convertMinutesToHours(
                            controller.bookDetail.value.readingTime!)),

                  if (controller.bookDetail.value.chapters != null)
                    _buildDetailRow(IconConstants.chapters,
                        '${controller.bookDetail.value.chapters!.length}'),

                  if (controller.bookDetail.value.resourceType != null &&
                      controller.bookDetail.value.resourceType!.isNotEmpty)
                    _buildDetailRow(IconConstants.fileType1,
                        controller.bookDetail.value.resourceType ?? ''),

                  if (controller.bookDetail.value.language != null &&
                      controller.bookDetail.value.language!.isNotEmpty)
                    _buildDetailRow(IconConstants.language,
                        controller.bookDetail.value.language!),
                  const SizedBox(height: 8),

                  // Display the description text
                  Container(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'Content introduction'.tr,
                        style:
                            TextStyle(color: AppColor.textColor, fontSize: 16),
                        children: [
                          TextSpan(
                            text: '\n\n$displayedText',
                            style: TextStyle(
                                color: AppColor.greyColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Conditionally show "Show more" or "Show less"
                  if (words.length > wordLimit)
                    Center(
                      child: TextButton(
                        onPressed: () {
                          controller.isExpanded.value =
                              !controller.isExpanded.value;
                        },
                        child: Text(
                          controller.isExpanded.value
                              ? 'Show less'
                              : 'Show more',
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50, // Đặt chiều cao cố định cho danh sách
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Cuộn theo chiều ngang
                      itemCount: controller.getTagOfBooks().length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.SearchDetailScreen,
                                      arguments:
                                          controller.getTagOfBooks()[index]);
                                },
                                child: Text(
                                  controller.getTagOfBooks()[index],
                                  style: TextStyle(color: AppColor.textColor),
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Text(
                    'Chapter list',
                    style: TextStyle(color: AppColor.textColor, fontSize: 20),
                  ),
                ),
                Obx(() {
                  final chapters = controller.bookDetail.value.chapters;
                  if (chapters == null || chapters.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'No chapter available',
                        style: TextStyle(color: AppColor.greyColor),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: chapters.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(39, 142, 142, 142),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              onTap: () {
                                if (chapters
                                            .elementAt(index)
                                            .isEncrypted !=
                                        null &&
                                    chapters.elementAt(index).isEncrypted ==
                                        true &&
                                    !controller.isBookPurchased.value &&
                                    controller.bookType.value != 'UnPubliced' &&
                                    controller.bookType.value != 'Publiced') {
                                  showCommonDialog(
                                    content:
                                        'You need to purchase the book to unlock this chapter',
                                    title: 'This chapter is locked',
                                    context: context,
                                  );
                                  return;
                                } else {
                                  Get.toNamed(
                                    controller.bookDetail.value.resourceType ==
                                            'eBook'
                                        ? AppRoutes.ReadingPdf
                                        : AppRoutes.SpeakingBook,
                                    arguments: {
                                      'resourceLink': chapters
                                          .elementAt(index)
                                          .resourceLink,
                                      'chapterId': chapters.elementAt(index).id,
                                      'idBook': controller.bookDetail.value.id,
                                      'resourceType': controller
                                          .bookDetail.value.resourceType,
                                      'rating': controller.bookResponses,
                                      'chapters': chapters,
                                      'indexChapter': index,
                                    },
                                  );
                                }
                              },
                              title: Text(
                                'Chapter ${index + 1}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                chapters.elementAt(index).title ?? '',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              trailing: (chapters
                                              .elementAt(index)
                                              .isEncrypted !=
                                          null &&
                                      chapters.elementAt(index).isEncrypted ==
                                          true &&
                                      !controller.isBookPurchased.value &&
                                      controller.bookType.value !=
                                          'UnPubliced' &&
                                      controller.bookType.value != 'Publiced')
                                  ? const Icon(
                                      Icons.lock_outline_rounded,
                                      color: Colors.greenAccent,
                                    )
                                  : const SizedBox(), // Empty box when not encrypted
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.MyFavorite,
                      arguments: {'title': 'MyFavorite'.tr});
                },
                child: Column(
                  children: [
                    Obx(() => Icon(
                          controller.selectFavorite.value
                              ? Icons.favorite
                              : Icons.favorite_outline_sharp,
                          color: controller.selectFavorite.value
                              ? Colors.pink
                              : AppColor.textBlackColor,
                        )),
                    Text('My favorite'.tr,
                        style: const TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.isShowRating.value =
                      !controller.isShowRating.value;
                  controller.isShowListBook.value = false;
                  if (controller.isShowRating.value) {
                    scrollToSection(offset: 5200);
                  }
                },
                child: Column(
                  children: [
                    const Icon(Icons.star, color: Colors.black),
                    Text('Rating'.tr,
                        style: const TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.isShowListBook.value =
                      !controller.isShowListBook.value;
                  controller.isShowRating.value = false;
                  if (controller.isShowListBook.value) {
                    scrollToSection(offset: 5200);
                  }
                },
                child: Column(
                  children: [
                    const Icon(Icons.more_horiz, color: Colors.black),
                    Text('More like this'.tr,
                        style: const TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widget to build rows in the detail section
  Widget _buildDetailRow(String image, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(image),
          ),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
