part of 'search_detail_screen.dart';

extension Filter on SearchDetailScreen {
  Widget _filter(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.filter.length,
        itemBuilder: (context, index) {
          return Obx(() {
            String displayedText;
            switch (index) {
              case 0:
                displayedText = controller.sortBy.value.isEmpty
                    ? 'Sort by'
                    : controller.sortBy.value; // Sort type (sortType in JSON)
                break;
              case 1:
                displayedText = controller.evaluate.value.isEmpty
                    ? 'Evaluate'
                    : controller.evaluate.value
                        .join(', '); // Star ratings (starNumbers in JSON)
                break;
              case 2:
                displayedText = controller.format.value.isEmpty
                    ? 'Format'
                    : controller.format.value
                        .join(', '); // Resource types (resourceTypes in JSON)
                break;
              case 3:
                displayedText = controller.fromPrice.value != 0.1 &&
                        controller.toPrice.value != 0.1
                    ? '${controller.fromPrice.value} - ${controller.toPrice.value} '
                    : 'Price';
                break;
              case 4:
                displayedText = controller.author.value.isEmpty
                    ? 'Author'
                    : controller.author.value
                        .join(', '); // Author names (authorNames in JSON)
                break;
              case 5:
                displayedText = controller.state.value.isEmpty
                    ? 'State'
                    : controller.state.value; // State (state in JSON)
                break;
              case 6:
                displayedText = controller.categories.value.isEmpty
                    ? 'Categories'
                    : controller.categories.value
                        .join(', '); // Categories (categories in JSON)
                break;
              case 7:
                displayedText = controller.publishers.value.isEmpty
                    ? 'Publishers'
                    : controller.publishers.value
                        .join(', '); // Publishers (publishers in JSON)
                break;
              case 8:
                displayedText = controller.languages.value.isEmpty
                    ? 'Languages'
                    : controller.languages.value
                        .join(', '); // Languages (languages in JSON)
                break;
              case 9: // Publication year
                displayedText = controller.fromPublicationYear.value != 1 &&
                        controller.toPublicationYear.value != 1
                    ? '${controller.fromPublicationYear.value} - ${controller.toPublicationYear.value} '
                    : 'Publication Year';
                break;
              default:
                displayedText = controller.filter[index];
            }

            return GestureDetector(
              onTap: () {
                _showSelectionDialog(context, index);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 4, left: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.blueColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColor.blueColor_1,
                    width: 2.0,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: displayedText,
                    style: TextStyle(color: AppColor.textColor),
                    children: [
                      const WidgetSpan(child: SizedBox(width: 4)),
                      WidgetSpan(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: AppColor.textColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  void _showSelectionDialog(BuildContext context, int index) {
    RxList<String> selectedOptions = <String>[].obs;
    List<String> options;
    bool isSingleSelection = false;

    switch (index) {
      case 0:
        options = [
          'Alphabet (A-Z)',
          'Prevalence'
        ]; // Sort options for sortType in JSON
        isSingleSelection = true;
        selectedOptions.value = [controller.sortBy.value];
        break;
      // case 1:
      //   options = controller
      //       .listEvalutes; // Star rating options for starNumbers in JSON
      // break;
      case 2:
        options = controller
            .listFormat; // Resource type options for resourceTypes in JSON
        break;
      // case 3:
      //   options = [
      //     'Low to High',
      //     'High to Low'
      //   ]; // Price sorting options for sortPriceType in JSON
      //   isSingleSelection = true;
      //   selectedOptions.value = [controller.price.value];
      //   break;
      case 4:
        options =
            controller.listAuthor; // Author options for authorNames in JSON
        break;
      case 5:
        options = ['New', 'Old']; // State options for state in JSON
        isSingleSelection = true;
        selectedOptions.value = [controller.state.value];
        break;
      case 6:
        options = controller
            .listCategories; // Category options for categories in JSON
        break;
      case 7:
        options = controller
            .listPublisher; // Publisher options for publishers in JSON
        break;
      case 8:
        options =
            controller.listLanguages; // Language options for languages in JSON
        break;

      default:
        options = [];
    }

    if (index == 1) {
      Navigator.of(context).push(SlideRightDialogRoute(
        page: EvaluateDialog(
            index: 1,
            onRatingSelected: (index, selectedRating) {
              selectedOptions.value = selectedRating.map((e) => '$e').toList();
              _onMultipleOptionsSelected(1, selectedOptions);
            }),
      ));
    } else if (index == 3) {
      Navigator.of(context).push(SlideRightDialogRoute(
        page: PriceFilterDialog(
          index: index,
          title: "Price",
          unit: "LP",
          rangeMax: 100000,
          rangeMin: 0,
          onPriceSelected: (fromPrice, toPrice) {
            controller.fromPrice.value = fromPrice;
            controller.toPrice.value = toPrice;
            _onMultipleOptionsSelected(index, selectedOptions);
          },
        ),
      ));
    } else if (index == 9) {
      Navigator.of(context).push(SlideRightDialogRoute(
        page: PriceFilterDialog(
          index: index,
          title: "Publish Year",
          unit: "",
          rangeMax: 2024,
          rangeMin: 1901,
          onPriceSelected: (fromPrice, toPrice) {
            controller.fromPublicationYear.value = fromPrice.toInt();
            controller.toPublicationYear.value = toPrice.toInt();
            _onMultipleOptionsSelected(index, selectedOptions);
          },
        ),
      ));
    } else {
      // _onMultipleOptionsSelected(int index, RxList<String> selectedOptions)
      Navigator.of(context).push(SlideRightDialogRoute(
          page: FilterDialog(
        (index, selectedOptions) {
          print('Selected options: $selectedOptions');
          return _onMultipleOptionsSelected(index, selectedOptions);
        },
        index: index,
        title: controller.filter[index],
        options: options,
        isSingleSelection: isSingleSelection,
        selectedOptions: selectedOptions,
      )));
    }
  }

  void _onMultipleOptionsSelected(int index, RxList<String> selectedOptions) {
    // Update the filter values to fit the JSON structure
    switch (index) {
      case 0:
        controller.sortBy.value =
            selectedOptions.isNotEmpty ? selectedOptions.first : '';
        break;
      case 1:
        controller.evaluate.value =
            selectedOptions.map((e) => int.parse(e)).toList(); // Star ratings
        break;
      case 2:
        controller.format.value = selectedOptions; // Resource types
        break;
      // case 3:
      //   controller.price.value = selectedOptions.isNotEmpty
      //       ? selectedOptions.first
      //       : ''; // Single selection for price sorting
      //   break;
      case 4:
        controller.author.value = selectedOptions; // Author names
        break;
      case 5:
        controller.state.value = selectedOptions.isNotEmpty
            ? selectedOptions.first
            : ''; // Single selection for state
        break;
      case 6:
        controller.categories.value = selectedOptions; // Categories
        break;
      case 7:
        controller.publishers.value = selectedOptions; // Publishers
        break;
      case 8:
        controller.languages.value = selectedOptions; // Languages
        break;
    }

    // Trigger search with updated filters
    controller.searchBooks(
      controller.searchController.value.text,
      controller.sortBy.value,
      controller.evaluate.value,
      controller.format.value,
      controller.author.value,
      controller.state.value,
      controller.categories.value,
      controller.fromPrice.value,
      controller.toPrice.value,
      controller.publishers.value,
      controller.languages.value,
      controller.fromPublicationYear.value,
      controller.toPublicationYear.value,
    );
  }
}

class SlideRightDialogRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideRightDialogRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
