import 'dart:async';
import 'dart:convert';

import 'package:audio_session/audio_session.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import '../../../all.dart';
import '../../api/contanst.dart';
import '../../api/repos/impl/book_details_api_swagger.dart';
import '../../api/repos/impl/bookmark_api.swagger.dart';
import '../../api/repos/impl/review_book_api.swagger.dart';
import '../../api/repos/impl/user_progress_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../generated_code/openapi.models.swagger.dart';

class BookOpenController extends AppController {
  RxInt loadingProgress = 0.obs;
  final AudioPlayer _player = AudioPlayer();
  RxBool isPlaying = false.obs; // Track playing state
  Rx<Duration> audioDuration = const Duration().obs;
  Rx<Duration> currentPosition = const Duration().obs;
  RxBool isLoading = true.obs;
  Rx<Book> bookDetail = const Book().obs;
  RxList<Review> reviewsList = <Review>[].obs;
  RxString resourceType = 'Video'.obs;
  RxList<BookChapter> chapters = <BookChapter>[].obs;
  BookReviewApiRepository bookReviewApiRepository = BookReviewApiRepository();
  GetUserProgressApiRepository getUserProgressApiRepository =
      GetUserProgressApiRepository();
  CreateUserProgressApiRepository createUserProgressApiRepository =
      CreateUserProgressApiRepository();
  RxInt idBook = 0.obs;
  RxDouble playbackSpeed = 1.0.obs;
  RxInt chapterIndex = 0.obs;
  final BookDetailsApiRepository _bookDetailsApiRepository =
      BookDetailsApiRepository();
  var currentAudioPosition;
  RxBool isBookOpening = true.obs;
  Rx<Duration> currentPositionTracking = const Duration().obs;
  CreateBookmarkApiRepository createBookmarkApiRepository =
      CreateBookmarkApiRepository();
  GetBookmarkApiRepository getBookmarkApiRepository =
      GetBookmarkApiRepository();
  DeleteBookmarkApiRepository deleteBookmarkApiRepository =
      DeleteBookmarkApiRepository();
  RxList<Bookmark> bookmarks = <Bookmark>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    simulateLoading();
    idBook.value = Get.arguments['idBook'];
    chapters.value = Get.arguments['chapters'] ?? [];
    chapterIndex.value = Get.arguments['indexChapter'] ?? 0;

    resourceType.value = Get.arguments['resourceType'];
    reviewsList.value = Get.arguments['rating'];
    await fetchBookDetail(idBook.value);
    await loadProgress();

    _player.positionStream.listen((position) {
      if (position.inSeconds + currentPositionTracking.value.inSeconds <
          audioDuration.value.inSeconds) {
        currentPosition.value = position + currentPositionTracking.value;
        if (currentPosition.value >= audioDuration.value) {
          currentPosition.value = audioDuration.value;
          isPlaying.value = false;
        }
      } else {
        currentPosition.value = audioDuration.value;
        isPlaying.value = false;
        pauseAudio();
      }
      update(); // Cập nhật UI
    });

    _player.durationStream.listen((duration) {
      audioDuration.value = duration ?? const Duration();
      update(); // Cập nhật UI
    });

    _player.setSpeed(playbackSpeed.value);

    isLoading.value = false;
    loadingProgress.value = 100;
    isBookOpening.value = false;
  }

  // Method to save reading progress for book, audio, or video
  Future<void> saveProgress() async {
    if (resourceType.value == 'Audio' || resourceType.value == 'eBook') {
      try {
        final UserReadingProgressAppRequest userReadingProgressAppRequest =
            UserReadingProgressAppRequest(
          bookId: idBook.value,
          currentChapter: chapterIndex.value,
          totalChapters: chapters.length,
          currentPage: _calculateCurrentPage(),
          totalPage: bookDetail.value.pageCount ?? 0,
        );

        createUserProgressApiRepository
            .create_user_progress(userReadingProgressAppRequest)
            .then(
          (value) {
            if (value.statusCode == 201) {
              print('Progress saved successfully!');
            } else {
              print(
                  'Failed to save progress. Status code: ${value.statusCode}');
            }
          },
        );
      } catch (e) {
        print('Error saving progress: $e');
      }
    }
  }

  // Helper method to calculate the current page based on the current position
  int _calculateCurrentPage() {
    print('Resource type: ${resourceType.value}');
    if (resourceType.value == 'Audio') {
      final positionSeconds = currentPosition.value.inSeconds;
      final durationSeconds = audioDuration.value.inSeconds;
      // return (positionSeconds / durationSeconds * bookDetail.value.pageCount!)
      //     .round();
      return positionSeconds; // For audio, save as seconds
    }
    // else if (resourceType.value == 'Video') {
    //   print('Current position: ${currentPosition.value.inSeconds}');
    //   return currentPosition.value.inSeconds; // For video, save as seconds
    // }
    return 0; // Default for other types
  }

  @override
  void onClose() {
    _player.dispose(); // Hủy trình phát nhạc khi thoát màn hình
    saveProgress(); // Save progress when exiting
    super.onClose();
  }

  // Call this in audio or video playback control
  Future<void> onPause() async {
    isPlaying.value = false;
    await _player.pause();
    saveProgress(); // Save progress on pause
  }

  Future<void> loadProgress() async {
    try {
      final url = '$baseUrl/app/reading-progress/user/${idBook.value}';
      final String accessToken = Get.find<HomeController>().accessToken;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $accessToken', // Replace $token with actual token
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final currentChapter = data[0]['currentChapter'] ?? 0;
        final currentPage = data[0]['currentPage'] ?? 0;
        final currentPositionInSeconds = currentPage;

        // Restore progress based on resource type
        if (resourceType.value == 'Audio') {
          chapterIndex.value = currentChapter;
          currentPosition.value = Duration(seconds: currentPositionInSeconds);
          currentPositionTracking.value =
              Duration(seconds: currentPositionInSeconds);
          // await _player.seek(currentPosition.value);
        } else if (resourceType.value == 'eBook') {
          chapterIndex.value = currentChapter;
        }
      } else {
        print('Failed to load progress. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading progress: $e');
    }
  }

  void startPeriodicProgressSave() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (!isPlaying.value) return; // Only save if something is playing/active
      saveProgress();
    });
  }

  Future<void> getListReviewBook(int bookId) async {
    try {
      final response = await bookReviewApiRepository.getListFavouriteBooks(
        bookId,
        1, // Page number (starting from 1)
        100, // Limit the number of reviews to 100
      );

      if (response.statusCode == 200 && response.body != null) {
        reviewsList.value = response.body!;
      } else {
        print(
            'Failed to fetch book reviews. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching book reviews: $e');
    }
  }

  void simulateLoading() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (loadingProgress.value < 90) {
        loadingProgress.value += 10; // Increment loading progress
      } else {
        timer.cancel(); // Stop the timer when loading is complete
      }
    });
  }

  Future<void> loadAudioForChapter() async {
    try {
      await _player.setAudioSource(AudioSource.uri(
          Uri.parse(chapters.elementAt(chapterIndex.value).resourceLink!)));
      if (isPlaying.value) {
        await _player.play();
      }
    } on PlayerException catch (e) {
      print('Error loading audio source: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  Future<void> playAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    try {
      await _player.setAudioSource(
          AudioSource.uri(Uri.parse(Get.arguments['resourceLink'])));
      isPlaying.value = true; // Cập nhật trạng thái đang phát
      await _player.play();
    } on PlayerException catch (e) {
      print('Error loading audio source: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  Future<void> pauseAudio() async {
    try {
      isPlaying.value = false; // Cập nhật trạng thái dừng
      await _player.pause();
    } on PlayerException catch (e) {
      print('Error pausing audio: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  Future<void> seekAudio(Duration position) async {
    pauseAudio();
    await _player.seek(position);
    currentPosition.value = position;
    currentPositionTracking.value = position;
    playAudio();
  }

  void rewindAudio() {
    pauseAudio();
    final newPosition = currentPosition.value - const Duration(seconds: 15);
    seekAudio(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void fastForwardAudio() {
    pauseAudio();
    final newPosition = currentPosition.value + const Duration(seconds: 15);
    seekAudio(
        newPosition > audioDuration.value ? audioDuration.value : newPosition);
  }

  // Phương thức để dừng nhạc
  void stopAudio() {
    _player.stop();
  }

  Future<void> fetchBookDetail(int idBook) async {
    print('Book data:$idBook');
    try {
      final Response<Book> bookResponse =
          await _bookDetailsApiRepository.get_book_by_id(idBook);
      if (bookResponse.statusCode == 200) {
        bookDetail.value = bookResponse.body!;
      } else {
        print('Failed to load book data');
      }
    } catch (e) {
      print('Error fetching book details: $e');
    }
  }

  Future<void> fetchBookReviews(int idBook,
      {int page = 1, int limit = 100}) async {
    final String accessToken = Get.find<HomeController>().accessToken;
    final url =
        '$baseUrl/app/book-review/book/$idBook/reviews?page=$page&limit=$limit';
    print('Fetching reviews for book ID: $idBook');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken', // Use your actual token
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        // Assuming you want to store reviews in an observable list (RxList)
        reviewsList.assignAll(
            data['items']); // Update the observable list with the reviews data
        print('Fetching reviews for book ID: ${reviewsList.length}');
      } else {
        print('Failed to load reviews, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching book reviews: $e');
    }
  }

  String getFormatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void setPlaybackSpeed(double speed) {
    playbackSpeed.value = speed;
    _player.setSpeed(
        playbackSpeed.value); // Cập nhật tốc độ phát lại cho trình phát
  }

  void selectChapter(int index) {
    chapterIndex.value = index;
  }

  Future<void> getBookmarks() async {
    bookmarks.clear();
    getBookmarkApiRepository
        .get_list_bookmark(
            idBook.value, chapters[chapterIndex.value].id, 100, 1)
        .then(
      (value) {
        if (value.statusCode == 200) {
          print('Bookmarks fetched successfully!');
          bookmarks.value = value.body!;
        } else {
          print('Failed to fetch bookmarks. Status code: ${value.statusCode}');
        }
      },
    );
  }

  void saveMark({required String title, required currentPosition}) {
    createBookmarkApiRepository
        .create_bookmark(BookmarkAppRequest(
      bookId: idBook.value,
      chapterId: chapters[chapterIndex.value].id,
      title: title,
      position: currentPosition,
    ))
        .then(
      (value) {
        if (value.statusCode == 201) {
          print('Bookmark saved successfully!');
        } else {
          print('Failed to save bookmark. Status code: ${value.statusCode}');
        }
      },
    );
  }

  void deleteMark(int id) {
    deleteBookmarkApiRepository.delete_bookmark(id).then(
      (value) {
        if (value.statusCode == 200) {
          getBookmarks();
          print('Bookmark deleted successfully!');
        } else {
          print('Failed to delete bookmark. Status code: ${value.statusCode}');
        }
      },
    );
  }
}
