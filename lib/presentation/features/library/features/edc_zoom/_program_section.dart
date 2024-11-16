part of 'edc_zoom_screen.dart';

extension ProgramSection on EDCZoomScreen {
  Widget _programSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.blueColor,
        borderRadius: BorderRadius.circular(10),
      ),
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
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Image.asset(ImageConstants.books),
              ),
              Expanded(
                  child: Text(
                'Program under study'.tr,
                style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ))
            ],
          ),
          _buildProgramCard(
            'Mentoring and Coaching 1:1',
            ImageConstants.mentor, // Replace with real image
            '1 hour',
            0.70,
            () {
              print('Multilingual Teacher');
            },
          ),
          _buildProgramCard(
            'Admissions and Scholarships',
            ImageConstants.admission, // Replace with real image
            '1 hour',
            0.23,
            () {
              print('Multilingual Teacher');
            },
          ),
          _buildProgramCard(
            'Multilingual Teacher',
            ImageConstants.multi, // Replace with real image
            'Video • 1 hour',
            0.95,
            () {
              print('Multilingual Teacher');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(String title, String imagePath, String time,
      double progress, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: Get.width * 0.34,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: EdgeInsets.zero,
                        width: 24,
                        height: 24,
                        child: Image.asset(IconConstants.ph_video),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Text('Video'.tr,
                            style: TextStyle(
                                color: AppColor.textColor, fontSize: 14)),
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.greyColor,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: Text(time,
                            style: TextStyle(
                                color: AppColor.textColor.withOpacity(0.8),
                                fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text('Learning progress'.tr,
                        style: TextStyle(
                            color: AppColor.textColor.withOpacity(0.8),
                            fontSize: 14)),
                  ),
                  LinearProgressIndicator(
                    minHeight: 12,
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: AppColor.greenColor_1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
