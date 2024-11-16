part of 'library_screen.dart';

extension Continue on LibraryScreen {
  Widget _continue(BuildContext context) {
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
                width: 32,
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Image.asset(IconConstants.iconContinue),
              ),
              Expanded(
                  child: Text(
                'Continue'.tr,
                style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ))
            ],
          ),
          _buildItemContinue(
            'Mentoring and Coaching 1:1',
            ImageConstants.mentor, // Replace with real image
            '1 hour',
            0.70,
            () {
              print('Multilingual Teacher');
            },
          ),
          _buildItemContinue(
            'Admissions and Scholarships',
            ImageConstants.admission, // Replace with real image
            '1 hour',
            0.23,
            () {
              print('Multilingual Teacher');
            },
          ),
          _buildItemContinue(
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

  Widget _buildItemContinue(String title, String imagePath, String time,
      double progress, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: Get.width * 0.4,
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
                        width: 28,
                        height: 28,
                        child: Icon(
                          Icons.play_circle,
                          color: AppColor.textColor,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text('Book'.tr,
                        style: TextStyle(
                            color: AppColor.textColor.withOpacity(0.8),
                            fontSize: 14)),
                  ),
                  LinearProgressIndicator(
                    minHeight: 8,
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
