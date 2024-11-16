import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../api/repos/impl/review_book_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../core/utils/show_noti.dart';
import '../../features/bookdetail/book_detail_controller.dart';
import '../../generated_code/openapi.swagger.dart';

class RatingController extends AppController {
  var rating = 0.obs; // Observable variable for the star rating
  var feedbackText = ''.obs; // Observable for the feedback
  // final int idBook = Get.arguments['idBook'];
  RxString title = ''.obs;
  RxInt idBook = 1.obs;
  RxString imageUrl = ''.obs;
  RxString author = 'No author info'.obs;
  CreateBookReviewApiRepository createBookReviewApiRepository =
      CreateBookReviewApiRepository();

  @override
  Future<void> onInit() async {
    super.onInit();
    title.value = Get.arguments['title'];
    idBook.value = Get.arguments['idBook'];
    imageUrl.value = Get.arguments['imageUrl'];
    author.value = Get.arguments['author'];
  }

  Future<bool> createReview(
    int? bookId,
    int? rating,
    String? reviewText,
  ) async {
    try {
      final response =
          await createBookReviewApiRepository.createReview(BookReviewRequest(
        bookId: bookId,
        rating: rating,
        reviewText: reviewText!.trim(),
      ));
      print('response: ${response.statusCode}');
      if (response.statusCode == 201) {
        print('response: ${response.body}');
        final BookDetailController firstController =
            Get.find<BookDetailController>();
        firstController.getListReviewBook(bookId!);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      showErrorWithTitle('Error', 'Failed to submit review: $e');
      return false;
    }
  }

  // Method to update the rating
  void updateRating(int newRating) {
    rating.value = newRating;
  }

  // Method to submit feedback
  void submitFeedback() {
    if (feedbackText.isNotEmpty) {
      // Handle feedback submission (API call, local storage, etc.)
      showSuccessWithTitle('Success', 'Feedback submitted successfully!');
    } else {
      showErrorWithTitle('Error', 'Please provide feedback before submitting.');
    }
  }
}
