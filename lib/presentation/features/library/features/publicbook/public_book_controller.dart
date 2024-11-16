import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../home/home.dart';
import '../../api/contanst.dart';
import '../../api/repos/impl/author_api.swagger.dart';
import '../../api/repos/impl/home_api.swagger.dart';
import '../../api/repos/impl/public_book_api.swagger.dart';
import '../../api/repos/impl/publisher_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/show_noti.dart';
import '../../generated_code/openapi.models.swagger.dart';

class Chapter {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxString fileName = ''.obs; // Holds the file name after upload
  RxBool isLocked = false.obs;
  RxString filePath = ''.obs; // Holds the file path after upload
}

class PublicBookController extends AppController {
  RxBool isAgree = false.obs;
  RxBool isLoadingAuthors = true.obs;

  final CategoryApiRepository _categoryApiRepository = CategoryApiRepository();
  final AuthorApiRepository _authorApiRepository = AuthorApiRepository();
  final UploadImageApiRepository _uploadImageApiRepository =
      UploadImageApiRepository();
  final UploadChapterApiRepository _uploadChapterApiRepository =
      UploadChapterApiRepository();
  final CreateBookIDApiRepository _createBookIDApiRepository =
      CreateBookIDApiRepository();
  final UploadBookApiRepository _updateBookApiRepository =
      UploadBookApiRepository();
  final RegisterPublicBookApiRepository _registerPublicBookApiRepository =
      RegisterPublicBookApiRepository();
  final GetUserInfoApiRepository _getUserInfoApiRepository =
      GetUserInfoApiRepository();
  final PublisherApiRepository publish = PublisherApiRepository();

  RxBool isLoading = true.obs;

  final RxList<Category> categories = <Category>[].obs;
  final RxList<Author> authors = <Author>[].obs;
  final RxList<Publisher> publishers = <Publisher>[].obs;

  // final List<String> topics = ['Novel', 'Science', 'History', 'Biography'];
  final List<String> ageLimits = ['All Ages', '16+ (For teens)', '18+'];
  final List<String> years = List.generate(124, (index) => '${1901 + index}');
  final List<String> languages = ['English', 'Vietnamese'];
  final List<String> formats = ['eBook', 'Audio'];
  final List<String> formatVideo = ['Video'];
  // Text Controllers
  final bookNameController = TextEditingController();
  final publishingHouseController = TextEditingController();
  final priceController = TextEditingController();
  final introduceController = TextEditingController();
  final excerptController = TextEditingController();
  final authorEvaluateController = TextEditingController();
  final keywordsController = TextEditingController();
  final isbnController = TextEditingController();
  final timeController = TextEditingController();
  final numberOfChaptersController = TextEditingController();

  var selectedAgeLimit = '16+ (For teens)'.obs;
  var selectedYear = '2024'.obs;
  var selectedLanguage = 'English'.obs;
  var selectedFormat = 'eBook'.obs;
  var selectedFormatVideo = 'Video'.obs;
  var selectedPublisherObj = const Publisher(id: 1).obs;
  var selectedAuthorObj = const Author(id: 1).obs;
  var selectedTopicObj = const Category(id: 1).obs;

  // List of images and file paths
  var bookImages = <File>[].obs;
  var uploadedBookPath = ''.obs;
  var uploadedAudiobookPath = ''.obs;
  var uploadedISBNPath = ''.obs;
  var chapters = <Chapter>[].obs;
  var isVideo = false.obs;

  // Add new chapter entry
  void addChapter() {
    chapters.add(Chapter());
    numberOfChaptersController.text = chapters.length.toString();
  }

  // Pick a file for a specific chapter
  Future<void> pickChapterFileEbook(int index) async {
    // Logic for picking the file and saving the file name
    await pickFiles(
        fileType: FileType.custom,
        allowedExtensions: ['pdf', 'epub', 'mobi'],
        targetFile: uploadedBookPath); // Implement your file picker logic
    //get file name by uploadedBookPath
    final String pickedFileName = uploadedBookPath.value.split('/').last;
    chapters[index].fileName.value = pickedFileName;
    chapters[index].filePath.value = uploadedBookPath.value;
    chapters.refresh(); // Refresh the UI after file selection
  }

  Future<void> pickChapterFileVideo(int index) async {
    // Logic for picking the file and saving the file name
    await pickFiles(fileType: FileType.video, targetFile: uploadedBookPath);
    //get file name by uploadedBookPath
    final String pickedFileName = uploadedBookPath.value.split('/').last;
    chapters[index].fileName.value = pickedFileName;
    chapters[index].filePath.value = uploadedBookPath.value;
    chapters.refresh(); // Refresh the UI after file selection
  }

  Future<void> pickChapterFileAudio(int index) async {
    // Logic for picking the file and saving the file name
    await pickFiles(
        fileType: FileType.audio, targetFile: uploadedAudiobookPath);
    //get file name by uploadedBookPath
    final String pickedFileName = uploadedAudiobookPath.value.split('/').last;
    chapters[index].fileName.value = pickedFileName;
    chapters[index].filePath.value = uploadedBookPath.value;
    chapters.refresh(); // Refresh the UI after file selection
  }

  void removeChapter(int index) {
    chapters.removeAt(index);
    numberOfChaptersController.text = chapters.length.toString();
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    //get isVideo from argument
    if (Get.arguments != null) {
      final bool isVideoArg = Get.arguments['isVideo'];
      if (isVideoArg) {
        isVideo.value = true;
      } else {
        isVideo.value = false;
      }

      await fetchAuthors();
      await loadCategories();
      await loadPublishers();
      selectedPublisherObj.value = publishers.first;
      selectedAuthorObj.value = authors.first;
      selectedTopicObj.value = categories.first;
    }
    isLoading.value = false;
  }

  // File pickers optimized
  Future<void> pickFiles({
    required FileType fileType,
    List<String>? allowedExtensions,
    RxString? targetFile,
    bool isMultiple = false, // Corrected: default to false
  }) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowedExtensions: allowedExtensions,
      allowMultiple: isMultiple, // use the passed `isMultiple` variable
    );

    if (result != null) {
      if (isMultiple) {
        // For multiple files, add them to the list
        bookImages.addAll(result.paths.map((path) => File(path!)).toList());
      } else {
        // For single file, update the targetFile with the picked file
        targetFile?.value = File(result.files.single.path!).path;
      }
    }
  }

  Future<void> pickBookImages() async =>
      pickFiles(fileType: FileType.image, isMultiple: true);
  Future<void> pickBookFile() async => pickFiles(
      fileType: FileType.custom,
      allowedExtensions: ['pdf', 'epub', 'mobi'],
      targetFile: uploadedBookPath);
  Future<void> pickAudiobookFile() async =>
      pickFiles(fileType: FileType.audio, targetFile: uploadedAudiobookPath);
  Future<void> pickISBNFile() async =>
      pickFiles(fileType: FileType.image, targetFile: uploadedISBNPath);

  Future<void> pickVideoFile() async =>
      pickFiles(fileType: FileType.video, targetFile: uploadedBookPath);

  // Simplified book ID creation
  Future<CreateBookIDRequestResponse?> createBookId() async {
    try {
      final response = await _createBookIDApiRepository.create_book_id();
      return response.body;
    } catch (e) {
      showErrorWithTitle('Error', 'Failed to create book ID: $e');
    }
    return null;
  }

  // Upload book chapter
  // Future<void> uploadChapter(String? bookId) async {
  //   try {
  //     String encoded = base64.encode(utf8.encode(bookNameController.text));
  //     final uri = Uri.parse(
  //         'https://lib-dev.educhain.tech/app/api/app/books/uploadChapter');
  //     var request = http.MultipartRequest('POST', uri)
  //       ..headers['Authorization'] = 'Bearer $token'
  //       ..fields['bookId'] = bookId ?? ''
  //       ..fields['title'] = encoded
  //       ..fields['chapterNumber'] = numberOfChaptersController.text
  //       ..fields['format'] = selectedFormat.value
  //       ..fields['isEncrypted'] = '0';

  //     request.files.add(await http.MultipartFile.fromPath(
  //         'fileData', uploadedBookPath.value));
  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       print('Chapter uploaded successfully!');
  //     } else {
  //       print('Failed to upload chapter. Status code: ${response.statusCode}');
  //     }
  //   } catch (e, stackTrace) {
  //     print(stackTrace);
  //     print('Failed to upload chapter: $e');
  //   }
  // }

  Future<void> uploadBookWithChapters(String? bookId) async {
    try {
      // Iterate over each chapter in your chapters list
      for (int index = 0; index < chapters.length; index++) {
        final chapter = chapters[index];
        final String encodedTitle =
            base64.encode(utf8.encode(chapter.nameController.text));
        final String token = Get.find<HomeController>().accessToken;
        final String formatType =
            isVideo.value ? 'Video' : selectedFormat.value;

        // Prepare request to upload each chapter
        final uri = Uri.parse(
            'https://lib-dev.educhain.tech/app/api/app/books/uploadChapter');
        final request = http.MultipartRequest('POST', uri)
          ..headers['Authorization'] = 'Bearer $token'
          ..fields['bookId'] = bookId ?? ''
          ..fields['title'] = encodedTitle
          ..fields['chapterNumber'] = (index + 1).toString() // Chapter number
          ..fields['format'] = formatType
          ..fields['isEncrypted'] =
              chapter.isLocked.value ? '1' : '0'; // Encrypted if locked

        // Attach the chapter file
        if (chapter.fileName.isNotEmpty) {
          request.files.add(await http.MultipartFile.fromPath(
              'fileData', chapter.filePath.value));
        }

        // Send the request
        final response = await request.send();

        // Handle response
        if (response.statusCode == 200) {
          print('Chapter ${index + 1} uploaded successfully!');
        } else {
          print(
              'Failed to upload chapter ${index + 1}. Status code: ${response.statusCode}');
        }
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      print('Failed to upload book with chapters: $e');
    }
  }

  // Batch upload images for the book
  Future<void> uploadImages(String? bookId) async {
    if (bookImages.isEmpty) {
      showErrorWithTitle('Error', 'Please select images to upload');
      return;
    }
    final String token = Get.find<HomeController>().accessToken;
    final futures = bookImages.map((image) async {
      try {
        final request = http.MultipartRequest(
            'POST',
            Uri.parse(
                'https://lib-dev.educhain.tech/app/api/app/books/uploadImage'))
          ..headers['Authorization'] = 'Bearer $token'
          ..fields['bookId'] = bookId ?? '';
        request.files
            .add(await http.MultipartFile.fromPath('fileData', image.path));
        final response = await request.send();
        return response;
      } catch (e) {
        print('Error uploading image: $e');
      }
    });
    await Future.wait(futures);
  }

  // Upload entire book process
  Future<void> uploadBook() async {
    try {
      //check already fill all field
      if (bookNameController.text.isEmpty ||
          // authorController.value.isEmpty ||
          uploadedBookPath.value.isEmpty ||
          bookNameController.text.isEmpty ||
          priceController.text.isEmpty ||
          // introduceController.text.isEmpty ||
          // excerptController.text.isEmpty ||
          // authorEvaluateController.text.isEmpty ||
          // keywordsController.text.isEmpty ||
          // isbnController.text.isEmpty ||
          // timeController.text.isEmpty ||
          numberOfChaptersController.text.isEmpty) {
        showErrorWithTitle('Error', 'Please fill in all required fields');
        return;
      }

      final bookId = await createBookId();
      if (bookId == null) {
        showErrorWithTitle(
          'Error',
          'Failed to create book ID. Please reload application and start again.',
        );
        return;
      }

      isLoading.value = true;

      await uploadBookWithChapters('${bookId.bookId}').then((value) async {
        await uploadImages('${bookId.bookId}').then((value) async {
          await updateBook(bookId.bookId).then(
            (value) {
              if (value) {
                isLoading.value = false;
                showSuccessWithTitle(
                  'Success',
                  'Book uploaded successfully!',
                );
                Get.toNamed(AppRoutes.MyBook,
                    arguments: {'isVideo': isVideo.value});
              }
            },
            onError: (e) {
              showErrorWithTitle('Error', 'Failed to update book: $e');
            },
          );
        });
      });
    } catch (e) {
      // Handle any errors here, show an error notification
      showErrorWithTitle('Error', 'Failed to create book. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateBook(int? bookId) async {
    try {
      final category = categories
          .where((category) {
            return category.id ==
                int.parse(selectedTopicObj.value.id.toString());
          })
          .map((category) => category.id)
          .firstOrNull;

      int? age;
      switch (selectedAgeLimit.value) {
        case 'All Ages':
          age = -1;
          break;
        case '16+ (For teens)':
          age = 16;
          break;
        case '18+':
          age = 18;
          break;
        default:
          age = 0;
      }

      // Check if the author is present using firstWhere with orElse.
      final Author author = authors.firstWhere(
        (author) =>
            author.id == int.parse(selectedAuthorObj.value.id.toString()),
        orElse: () => const Author(), // Use a fallback if no author is found
      );

      print('Author ID: ${author.id}');
      final bookAppRequest = BookAppRequest(
        title: bookNameController.text,
        ageAverage: age,
        authorEvaluation: authorEvaluateController.text,
        authorId: author.id, // Now safely using authorId
        excerpt: excerptController.text,
        description: introduceController.text,
        categoryIds: (category != null) ? [category] : [],
        isbn: isbnController.text,
        language: selectedLanguage.value,
        price: double.parse(priceController.text),
        numberOfChapters: numberOfChaptersController.text.isNotEmpty
            ? int.parse(numberOfChaptersController.text)
            : 1,
        publicationYear: int.parse(selectedYear.value),
        publisherId: 1,
        pageCount: 0,
        readingTime:
            timeController.text.isNotEmpty ? int.parse(timeController.text) : 0,
        resourceType: isVideo.value ? 'Video' : selectedFormat.value,
        tagIds: [],
      );

      print('BookAppRequest: $bookAppRequest');

      final response =
          await _updateBookApiRepository.upload_book(bookId, bookAppRequest);
      return true;
    } catch (e, stackTrace) {
      print(stackTrace);
      showErrorWithTitle('Error', 'Failed to upload book');
      return false;
    }
  }

  @override
  void dispose() {
    bookNameController.dispose();
    publishingHouseController.dispose();
    priceController.dispose();
    introduceController.dispose();
    excerptController.dispose();
    authorEvaluateController.dispose();
    keywordsController.dispose();
    isbnController.dispose();
    timeController.dispose();
    numberOfChaptersController.dispose();
    super.dispose();
  }

  Future<void> fetchAuthors({int page = 1, int limit = 100}) async {
    final url = '$baseUrl/app/authors?page=$page&limit=$limit';
    final String token = Get.find<HomeController>().accessToken;
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      authors.clear();
      authors.addAll((data['items'] as List)
          .map((json) => Author.fromJson(json))
          .toList());
      isLoadingAuthors.value = false;
    } else {
      throw Exception('Failed to load authors');
    }
  }

  Future<void> loadCategories() async {
    try {
      final fetchedCategories = await _categoryApiRepository.get_categories();
      categories.assignAll(fetchedCategories.body
              ?.map(
                  (category) => Category(id: category.id, name: category.name))
              .toList() ??
          []);
    } catch (e) {
      print('Error loading categories: $e');
    } finally {
      update();
    }
  }

  Future<void> loadPublishers() async {
    try {
      final fetchedPublishers = await publish.get_publishers(100, 1);
      publishers.assignAll(fetchedPublishers.body
              ?.map((publisher) => Publisher(
                  id: publisher.id,
                  name: publisher.name,
                  address: publisher.address,
                  contactInfo: publisher.contactInfo,
                  createdAt: publisher.createdAt,
                  updatedAt: publisher.updatedAt))
              .toList() ??
          []);
    } catch (e) {
      print('Error loading publishers: $e');
    } finally {
      update();
    }
  }

  void removeImage(int index) {
    bookImages.removeAt(index); // Remove image from list
  }

  Future<bool> registerPublicBook() async {
    if (isAgree.value) {
      final Response<BaseResponse> baseResponse =
          await _registerPublicBookApiRepository.register();
      if (baseResponse.statusCode == 200) {
        showSuccessWithTitle('Success', 'Public book registered successfully');
        return true;
      } else {
        showErrorWithTitle('Error', 'Failed to register public book');
        return false;
      }
    } else {
      showErrorWithTitle('Error', 'Please agree to the terms and conditions');
      return false;
    }
  }
}
