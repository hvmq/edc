part of 'library_screen.dart';

extension Banner on LibraryScreen {
  Widget _banner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 12, top: 12),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Image.asset(ImageConstants.banner),
    );
  }
}
