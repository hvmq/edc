import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../home/home.dart';
import '../../api/contanst.dart';
import '../../api/repos/impl/author_api.swagger.dart';
import '../../api/repos/impl/home_api.swagger.dart';
import '../../api/repos/impl/publisher_api.swagger.dart';
import '../../api/repos/impl/search_api.swagger.dart';
import '../../core/controllers/app_controller.dart';
import '../../generated_code/openapi.models.swagger.dart';

class MySearchController extends AppController {
  var selectedOptions = <String>[].obs;
  final searchController = TextEditingController().obs;
  var recentSearches = <String>[].obs;
  var filteredSearches = <String>[].obs;
  final RxList<String> listCategories = <String>[].obs;
  final RxMap<int, Widget> resultWidgets = <int, Widget>{}.obs;
  final RxList<BookAdvancedSearchResponse> listBooks =
      <BookAdvancedSearchResponse>[].obs;
  final SuggestedKeywordApiRepository _suggestedKeywordApiRepository;
  final CategoryApiRepository _categoryApiRepository;
  final AuthorApiRepository _authorApiRepository;
  final box = GetStorage(); // GetStorage for local storage
  final AdvancedSearchApiRepository _searchApiRepository;
  final PublisherApiRepository _publisherApiRepository;

  RxString sortBy = ''.obs;
  RxList<int> evaluate = <int>[].obs;
  RxList<String> format = <String>[].obs;
  RxDouble fromPrice = 0.1.obs;
  RxDouble toPrice = 0.1.obs;
  RxList<String> author = <String>[].obs;
  RxString state = ''.obs;
  RxList<String> categories = <String>[].obs;
  RxString bookSearchText = ''.obs;
  RxList<String> publishers = <String>[].obs;
  RxList<String> languages = <String>[].obs;
  RxInt fromPublicationYear = 1.obs;
  RxInt toPublicationYear = 1.obs;

  var listEvalutes = <String>[].obs;

  MySearchController()
      : _suggestedKeywordApiRepository = SuggestedKeywordApiRepository(),
        _categoryApiRepository = CategoryApiRepository(),
        _authorApiRepository = AuthorApiRepository(),
        _searchApiRepository = AdvancedSearchApiRepository(),
        _publisherApiRepository = PublisherApiRepository();
  List<String> filter = [
    'Sort by',
    'Evaluate',
    'Format',
    'Price',
    'Author',
    'State',
    'Categories',
    'Publishers',
    'Languages',
    'Publication year',
  ];

  List<String> listLanguages = ['Vietnamese', 'English'];

  List<String> listFormat = [
    'eBook',
    'Audio',
    'Video',
  ];
  var listAuthor = <String>[].obs;
  var listPublisher = <String>[].obs;
  void addEvalutes() {
    final List<String> sampleEvalutes = [
      '5-star',
      '4-star',
      '3-star',
      '2-star',
      '1-star',
    ];
    // Add each category to the observable list
    for (var evalutes in sampleEvalutes) {
      listEvalutes.add(evalutes);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // Load recent searches from local storage
    _loadRecentSearches();
    // load if there keywork search from arguments
    if (Get.arguments != null) {
      searchController.value.text = Get.arguments;
      bookSearchText.value = Get.arguments;
      addSearchQuery(Get.arguments);
      searchBooks(Get.arguments, null, null, null, null, null, null, null, null,
          null, null, null, null);
    }
    // _loadSampleData();
    // addCategories();
    addEvalutes();
    loadAuthors();
    loadCategories();
    loadPublishers();
  }

  // void _loadSampleData() {
  //   recentSearches.addAll([
  //     'The Alchemist',
  //     '1984 by George Orwell',
  //     'Harry Potter',
  //     'To Kill a Mockingbird',
  //     'Moby Dick',
  //   ]);
  // }

  void addSearchQuery(String query) {
    if (query.isNotEmpty && !recentSearches.contains(query)) {
      recentSearches.insert(0, query); // Add to top of the list
      if (recentSearches.length > 5) {
        recentSearches.removeLast(); // Limit to 5 recent searches
      }
      _saveRecentSearches(); // Save recent searches to local storage
    }
  }

  Future<void> updateSearchResults1(String query) async {
    if (query.isEmpty) {
      // If the query is empty, return the recent searches
      filteredSearches.assignAll(recentSearches);
    } else {
      try {
        print('Fetching suggestions for: $query');

        // API URL with query parameter
        final url =
            '$baseUrl/app/search/suggestions?keyword=$query&page=1&limit=10';
        final String token = Get.find<HomeController>().accessToken;
        // Making the HTTP GET request
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        print('Fetching suggestions for: ${response.body}');
        if (response.statusCode == 200) {
          // Parsing the response body
          final data = json.decode(utf8.decode(response.bodyBytes));

          // Extracting suggestions from the items list
          final List<dynamic> items = data['items'];

          // Mapping the suggestions and updating filteredSearches
          filteredSearches.assignAll(
            items
                .map((item) => item['suggestion'])
                .whereType<String>()
                .toList(),
          );

          print('Suggestions fetched: ${filteredSearches.length}');
        } else {
          print(
              'Failed to fetch suggestions. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching suggestions: $e');
      }
    }
  }

  Future<void> searchBooks(
      String? searchText,
      String? sortByArg,
      List<int>? evaluateArg,
      List<String>? formatArg,
      List<String>? authorArg,
      String? stateArg,
      List<String>? categoriesArg,
      double? fromPriceArg,
      double? toPriceArg,
      List<String>? publishersArg,
      List<String>? languagesArg,
      int? fromPublishYearArg,
      int? toPublishYearArg) async {
    try {
      // evaluateArg to 1-5
      final evaluate =
          (evaluateArg == null || evaluateArg.isEmpty) ? null : evaluateArg;
      final sortByArgs = (sortByArg == null || sortByArg.isEmpty)
          ? null
          : (sortByArg == 'Prevalence' ? 'Prevalence' : 'Alphabet');
      final format =
          (formatArg == null || formatArg.isEmpty) ? null : formatArg;
      final author =
          (authorArg == null || authorArg.isEmpty) ? null : authorArg;
      final state = (stateArg == null || stateArg.isEmpty) ? null : stateArg;
      final categories = (categoriesArg == null || categoriesArg.isEmpty)
          ? null
          : categoriesArg;
      final publisher = (publishersArg == null || publishersArg.isEmpty)
          ? null
          : publishersArg;
      final language =
          (languagesArg == null || languagesArg.isEmpty) ? null : languagesArg;

      final response = await _searchApiRepository.advanced_search_books(
          BookAdvancedSearchRequest(
            sortType: sortByArgs,
            starNumbers: evaluate,
            resourceTypes: format,
            authorNames: author,
            state: state,
            categories: categories,
            searchText:
                searchText == null || searchText.isEmpty ? ' ' : searchText,
            fromPrice: fromPriceArg == 0.1 ? null : fromPriceArg,
            toPrice: toPriceArg == 0.1 ? null : toPriceArg,
            publisherNames: publisher,
            languages: language,
            fromPublishYear:
                fromPublishYearArg == 1 ? null : fromPublishYearArg,
            toPublishYear: toPublishYearArg == 1 ? null : toPublishYearArg,
          ),
          20,
          1);
      listBooks.assignAll(response.body ?? []);
      print('Books found: ${listBooks.length}');
    } catch (e) {
      print('Error searching books: $e');
    } finally {
      update();
    }
  }

  // Future<void> searchBooks(
  //   try {
  //     final response =
  //         await _searchApiRepository.advanced_search_books(request, 20, 1);
  //     listBooks.assignAll(response.body ?? []);
  //     print('Books found: ${listBooks.length}');
  //   } catch (e) {
  //     print('Error searching books: $e');
  //   } finally {
  //     update();
  //   }
  // }

  Future<void> loadAuthors() async {
    try {
      final fetchedAuthors = await _authorApiRepository.get_authors(100, 1);
      listAuthor.assignAll(fetchedAuthors.body
              ?.map((author) => author.name)
              .whereType<String>()
              .toList() ??
          []);
    } catch (e) {
      print('Error loading authors: $e');
    } finally {
      update();
    }
  }

  Future<void> loadPublishers() async {
    try {
      final fetchedPublishers =
          await _publisherApiRepository.get_publishers(100, 1);
      listPublisher.assignAll(fetchedPublishers.body
              ?.map((publisher) => publisher.name)
              .whereType<String>()
              .toList() ??
          []);
    } catch (e) {
      print('Error loading publishers: $e');
    } finally {
      update();
    }
  }

  Future<void> loadCategories() async {
    try {
      final fetchedCategories = await _categoryApiRepository.get_categories();
      listCategories.assignAll(fetchedCategories.body
              ?.map((category) => category.name)
              .whereType<String>()
              .toList() ??
          []);
    } catch (e) {
      print('Error loading categories: $e');
    } finally {
      update();
    }
  }

  // Load recent searches from local storage
  void _loadRecentSearches() {
    final List<dynamic>? storedSearches =
        box.read<List<dynamic>>('recentSearches');
    if (storedSearches != null) {
      // Safely map dynamic items to String
      recentSearches
          .assignAll(storedSearches.map((item) => item.toString()).toList());
    }
  }

  // Save recent searches to local storage
  void _saveRecentSearches() {
    box.write('recentSearches', recentSearches);
  }

  @override
  void onClose() {
    searchController.value.dispose(); // Clean up the controller
    super.onClose();
  }

  String? calculateBookAge(int ageAverage) {
    if (ageAverage <= 0) {
      return null;
    } else {
      return '$ageAverage';
    }
  }
}
