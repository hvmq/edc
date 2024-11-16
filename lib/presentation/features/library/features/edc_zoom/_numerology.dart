part of 'edc_zoom_screen.dart';

extension Numerolory on EDCZoomScreen {
  Widget _numerolory(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
              ImageConstants.bg_numerology), // Đường dẫn đến hình ảnh
          // Điều chỉnh kích thước hình ảnh cho phù hợp với Container
        ),
        color: AppColor.blueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: EdgeInsets.zero,
                      width: 29,
                      height: 29,
                      child: Image.asset(IconConstants.iconB),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Numerology'.tr,
                        style: TextStyle(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Image.asset(ImageConstants.numerology),
              )
            ],
          ),
        ],
      ),
    );
  }
}
