part of 'edc_zoom_screen.dart';

extension TopMentor on EDCZoomScreen {
  Widget _topMentor(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AppColor.blueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'Top mentor can delight you'.tr,
              style: TextStyle(
                  color: AppColor.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          _buildCarousel(),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider.builder(
      itemCount: controller.mentors.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return _buildCarouselItem(controller.mentors[index]);
      },
      options: CarouselOptions(
        viewportFraction: 0.8, // Kích thước phần hiển thị của mỗi item
        enableInfiniteScroll: true,
        enlargeCenterPage: true, // Làm nổi bật item ở giữa
        autoPlay: true, // Tự động chuyển đổi giữa các item
      ),
    );
  }

  Widget _buildCarouselItem(Map<String, String> mentor) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            // height: 165,
            // width: 288,
            decoration: BoxDecoration(
              color: AppColor.textColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              mentor['image']!,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 28),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mentor['name']!.tr,
                          style: TextStyle(
                              color: AppColor.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        RichText(
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
                              text: ' ${mentor['rating']}',
                              style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                          TextSpan(
                              text: ' (${mentor['reviews']} review)'.tr,
                              style: TextStyle(
                                  color: AppColor.greyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ])),
                      ],
                    )),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 34,
                      height: 34,
                      padding: EdgeInsets.zero,
                      child: Image.asset(IconConstants.iconChat),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
