part of 'edc_zoom_screen.dart';

extension EDCFeaturesGrid on EDCZoomScreen {
  Widget _buildEDCFeaturesGrid(BuildContext context) {
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
                  child: Image.asset(IconConstants.iconLamp),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'EDC brings it to you'.tr,
                    style: TextStyle(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          Wrap(
            spacing: 8.0, // Khoảng cách giữa các phần tử theo chiều ngang
            runSpacing: 8.0, // Khoảng cách giữa các hàng khi xuống dòng
            children: List.generate(
              controller.features.length,
              (index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12), // Padding cho không gian bên trong
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      controller.features[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
