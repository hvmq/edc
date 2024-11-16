import 'dart:typed_data';

import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../home/home.dart';
import '../../api/repos/impl/bookmark_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../core/utils/show_noti.dart';
import '../../generated_code/openapi.models.swagger.dart';

class ReadingPdfController extends AppController {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  final PdfViewerController pdfViewerController = PdfViewerController();
  RxBool isHorizontalScroll = true.obs;
  RxInt totalPages = 0.obs; // Tổng số trang
  RxInt currentPage = 0.obs;
  var pdfData = Rx<Uint8List?>(null); // Biến để lưu trữ dữ liệu PDF
  var isLoading = true.obs; //  // Biến để theo dõi trạng thái tải
// Giá trị zoom mặc định
  RxDouble zoomLevel = 1.0.obs;
  late EpubController epubController;
  // Màu nền mặc định
  Rx<Color> backgroundColor = Colors.white.obs;
  RxList<int> bookmarks = <int>[].obs; // Store bookmark pages
  GetBookmarkApiRepository getBookmarkApiRepository =
      GetBookmarkApiRepository();
  CreateBookmarkApiRepository createBookmarkApiRepository =
      CreateBookmarkApiRepository();
  DeleteBookmarkApiRepository deleteBookmarkApiRepository =
      DeleteBookmarkApiRepository();
  RxInt bookId = 0.obs;
  RxInt chapterIdData = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    final String? resourceLink = Get.arguments['resourceLink'];
    final int? chapterId = Get.arguments['chapterId'];
    final int? bookIdVal = Get.arguments['idBook'];
    if (bookIdVal != null) {
      bookId.value = bookIdVal;
    }
    if (resourceLink != null && resourceLink.isNotEmpty && chapterId != null) {
      chapterIdData.value = chapterId;
      loadBookmarks();
      fetchPdfDemo();
      pdfViewerController.addListener(() {
        currentPage.value = pdfViewerController.pageNumber;
        totalPages.value = pdfViewerController.pageCount;
      });
    }
  }

  Future<void> addBookmark(String title, int page) async {
    try {
      if (bookmarks.contains(page)) {
        showInfo('Cannot add bookmark', 'Bookmark already exists', duration: 1);
        return;
      }
      // Send bookmark to backend
      final BookmarkAppRequest bookmarkRequest = BookmarkAppRequest(
          bookId: bookId.value, // Define bookId
          chapterId: chapterIdData.value,
          position: page,
          isBook: true,
          title: title);

      await createBookmarkApiRepository
          .create_bookmark(bookmarkRequest); // Define this method
      bookmarks.add(page);
      showSuccessWithTitle('Bookmark added', 'Bookmark added successfully',
          duration: 1);
    } catch (e) {
      print('Error adding bookmark: $e');
      showErrorWithTitle('Error adding bookmark', 'Failed to add bookmark');
    }
  }

  Future<void> loadBookmarks() async {
    try {
      final response = await getBookmarkApiRepository.get_list_bookmark(
          bookId.value, chapterIdData.value, 100, 1); // Define this method
      if (response.statusCode == 200) {
        bookmarks.clear();
        bookmarks.addAll(
            response.body!.map((bookmark) => bookmark.position.toInt()));
      } else {
        print('Failed to load bookmarks');
        showErrorWithTitle(
            'Error loading bookmarks', 'Failed to load bookmarks');
      }
    } catch (e) {
      print('Error loading bookmarks: $e');
      showErrorWithTitle('Error loading bookmarks', 'Failed to load bookmarks');
    }
  }

  // Hàm tăng zoom
  void increaseZoom() {
    if (zoomLevel.value < 3.0) {
      zoomLevel.value += 0.25;
      pdfViewerController.zoomLevel = zoomLevel.value;
    }
  }

  // Hàm giảm zoom
  void decreaseZoom() {
    if (zoomLevel.value > 1.0) {
      zoomLevel.value -= 0.25;
      pdfViewerController.zoomLevel = zoomLevel.value;
    }
  }

  // Chuyển đổi màu nền (Dark/Light mode)
  void toggleBackgroundColor() {
    if (backgroundColor.value == Colors.white) {
      backgroundColor.value = Colors.black;
    } else {
      backgroundColor.value = Colors.white;
    }
  }

  void changeBackgroundColor(Color color) {
    backgroundColor.value = color;
  }

  void toggleScrollDirection() {
    isHorizontalScroll.value = !isHorizontalScroll.value;
  }

  void goToPage(int pageNumber) {
    pdfViewerController.jumpToPage(pageNumber);
  }

  Future<Uint8List?> fetchPdf({required String fileName}) async {
    try {
      final String token = Get.find<HomeController>().accessToken;
      final response = await http.get(
        Uri.parse(
            'https://lib-dev.educhain.tech/app/api/app/books/viewBook?fileName=$fileName'),
        headers: {
          'Authorization': 'Bearer $token', // Thêm token vào header
        },
      );
      if (response.statusCode == 200) {
        return response.bodyBytes; // Trả về dữ liệu PDF dưới dạng bytes
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      print('Error fetching PDF: $e');
      return null;
    }
  }

  Future<void> fetchPdfDemo() async {
    try {
      isLoading.value = true; // Đánh dấu bắt đầu tải
      final String resourceLink = Get.arguments['resourceLink'];
      if (resourceLink.endsWith('.epub')) {
        // Load EPUB if the file extension is .epub
        await loadEpub(resourceLink);
      } else {
        // Otherwise, load PDF
        pdfData.value = await fetchPdf(fileName: resourceLink);
      }
    } catch (e) {
      print('Error fetching PDF: $e');
    } finally {
      isLoading.value = false; // Đánh dấu rằng quá trình tải đã hoàn tất
    }
  }

  Future<void> loadEpub(String resourceLink) async {
    try {
      // Fetch EPUB data as Uint8List from the resourceLink
      final String token = Get.find<HomeController>().accessToken;
      final response = await http.get(
        Uri.parse(
            'https://lib-dev.educhain.tech/app/api/app/books/viewBook?fileName=$resourceLink'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final epubBook = await EpubReader.readBook(response.bodyBytes);
        epubController = EpubController(document: Future.value(epubBook));
      } else {
        throw Exception('Failed to load EPUB');
      }
    } catch (e) {
      print('Error loading EPUB: $e');
    }
  }

  void removeBookmark(int page) {
    try {
      final bookmark = bookmarks.firstWhere((element) => element == page);
      deleteBookmarkApiRepository.delete_bookmark(bookmark);
      bookmarks.remove(bookmark);
    } catch (e) {
      print('Error removing bookmark: $e');
      showErrorWithTitle('Error removing bookmark', 'Failed to remove bookmark',
          duration: 3);
    }
  }
}
