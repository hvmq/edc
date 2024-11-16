import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../features/publicbook/public_book_controller.dart';
import '../../generated_code/openapi.models.swagger.dart';

class PublicBookScreen extends GetView<PublicBookController> {
  PublicBookScreen({super.key});

  // Form Key to validate inputs
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: _buildAppBar(),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey, // Wrap the form in a Form widget
                child: Column(
                  children: [
                    _buildBookImagesSection(),
                    const SizedBox(height: 10),
                    Obx(() => controller.bookImages.isEmpty
                        ? Container()
                        : _buildUploadButton()),
                    const SizedBox(height: 20),
                    _buildInputField(
                      'Book Name',
                      controller.bookNameController,
                      hintText: 'Enter the book name',
                      validator: _requiredValidator,
                      keyboardType: TextInputType.text,
                    ),
                    Obx(() {
                      return _buildSearchableDropdownField<Category>(
                        title: 'Topics',
                        selectedItem: controller.selectedTopicObj.value,
                        items: (String query) async {
                          return controller.categories.value;
                        },
                        onChanged: (Category? val) {
                          if (val != null) {
                            controller.selectedTopicObj.value = val;
                          }
                        },
                        hintText: 'Select a topic',
                        itemAsString: (Category item) =>
                            item.name ?? 'Select a topic',
                        compareFn: (Category a, Category b) => a.id == b.id,
                      );
                    }),
                    Obx(() {
                      return _buildSearchableDropdownField<Author>(
                        title: 'Authors',
                        selectedItem: controller.selectedAuthorObj.value,
                        items: (String query) async {
                          return controller.authors.value;
                        },
                        onChanged: (Author? val) {
                          if (val != null) {
                            controller.selectedAuthorObj.value = val;
                          }
                        },
                        hintText: 'Select a author',
                        itemAsString: (Author item) =>
                            item.name ?? 'Select a author',
                        compareFn: (Author a, Author b) => a.id == b.id,
                      );
                    }),
                    Obx(() {
                      return _buildSearchableDropdownField<Publisher>(
                        title: 'Publisher',
                        selectedItem: controller.selectedPublisherObj.value,
                        items: (String query) async {
                          return controller.publishers.value;
                        },
                        onChanged: (Publisher? val) {
                          if (val != null) {
                            controller.selectedPublisherObj.value = val;
                          }
                        },
                        hintText: 'Select a publisher',
                        itemAsString: (Publisher item) =>
                            item.name ?? 'Unknown Publisher',
                        compareFn: (Publisher a, Publisher b) => a.id == b.id,
                      );
                    }),

                    Obx(() => _buildDropdownField(
                          'Age Limit',
                          controller.selectedAgeLimit.value,
                          controller.ageLimits.map(_buildDropdownItem).toList(),
                          (val) => controller.selectedAgeLimit.value = val!,
                          hintText: 'Select age limit',
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => _buildDropdownField(
                                'Year of Publication',
                                controller.selectedYear.value,
                                controller.years
                                    .map(_buildDropdownItem)
                                    .toList(),
                                (val) => controller.selectedYear.value = val!,
                                hintText: 'Select year',
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() => _buildDropdownField(
                                'Language',
                                controller.selectedLanguage.value,
                                controller.languages
                                    .map(_buildDropdownItem)
                                    .toList(),
                                (val) =>
                                    controller.selectedLanguage.value = val!,
                                hintText: 'Select language',
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => _buildDropdownField(
                                'Format',
                                controller.isVideo.value
                                    ? controller.selectedFormatVideo.value
                                    : controller.selectedFormat.value,
                                controller.isVideo.value
                                    ? controller.formatVideo
                                        .map(_buildDropdownItem)
                                        .toList()
                                    : controller.formats
                                        .map(_buildDropdownItem)
                                        .toList(),
                                (val) => controller.isVideo.value
                                    ? null
                                    : controller.selectedFormat.value = val!,
                                hintText: 'Select format',
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildInputField(
                            'Price (Loyalty Points)',
                            controller.priceController,
                            hintText: 'Enter price in loyalty points',
                            validator: _requiredValidator,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // _buildUploadBookSection(),
                    _buildChapterSection(), // New section for chapters
                    const SizedBox(height: 20),
                    // _buildUploadAudioBookSection(),
                    // const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            'Time (Audio or Video)',
                            controller.timeController,
                            hintText: 'Enter time duration',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildInputField(
                            'Number of Chapters',
                            controller.numberOfChaptersController,
                            hintText: 'Enter number of chapters',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTextFile(
                      textEditingController: controller.introduceController,
                      title: 'Introduce',
                      maxLines: 3,
                      hintText: 'Enter introduction for the book',
                    ),
                    _buildTextFile(
                      textEditingController: controller.excerptController,
                      title: 'Excerpt',
                      maxLines: 3,
                      hintText: 'Enter an excerpt from the book',
                    ),
                    _buildTextFile(
                      textEditingController:
                          controller.authorEvaluateController,
                      title: 'Author\'s Evaluation',
                      maxLines: 3,
                      hintText: 'Enter author\'s evaluation',
                    ),
                    _buildTextFile(
                      textEditingController: controller.keywordsController,
                      title: 'Keywords',
                      maxLines: 3,
                      hintText: 'Enter keywords',
                    ),
                    _buildTextFile(
                      textEditingController: controller.isbnController,
                      title: 'ISBN',
                      maxLines: 1,
                      hintText: 'Enter ISBN number',
                    ),
                    const SizedBox(height: 20),
                    _buildUpload(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            if (controller.isLoading.value)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.textColor),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Required field validator
  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Required dropdown validator
  String? _requiredDropdownValidator<T>(T? value) {
    if (value == null) {
      return 'Please select an option';
    }
    return null;
  }

  // Updated input field with placeholder
  Widget _buildInputField(
    String title,
    TextEditingController controller, {
    String? hintText,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTile(title: title),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType, // Allow only numeric input
            validator: (value) {
              // Validation logic
              if (value == null || value.isEmpty) {
                return 'Price is required';
              }
              // Check if the input is a valid number
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null; // No error
            },
            decoration: _inputDecoration(hintText: hintText), // Add hintText
            style: _textStyle(),
            cursorColor: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Updated dropdown field with placeholder
  Widget _buildDropdownField<T>(String title, T? value,
      List<DropdownMenuItem<T>> items, ValueChanged<T?> onChanged,
      {String? hintText, FormFieldValidator<T>? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTile(title: title),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonFormField<T>(
            value: value,
            items: items,
            onChanged: onChanged,
            validator: validator,
            decoration: _inputDecoration(hintText: hintText), // Add hintText
            style: _textStyle(),
            dropdownColor: AppColor.blueColor,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSearchableDropdownField<T>({
    required String title,
    required T? selectedItem,
    required Future<List<T>> Function(String)? items,
    required ValueChanged<T?> onChanged,
    required String hintText,
    required String Function(T) itemAsString,
    bool Function(T, T)? compareFn,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTile(title: title),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownSearch<T>(
            selectedItem: selectedItem,
            asyncItems: items, // Async function to load items list
            itemAsString: itemAsString,
            onChanged: onChanged,
            compareFn: compareFn ?? (a, b) => a == b,
            dropdownBuilder: (context, selectedItem) => Text(
              selectedItem != null ? itemAsString(selectedItem) : '',
              style: TextStyle(color: AppColor.greyColor),
            ),
            // dropdownBuilderSupportsNullItem: true,
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                style: TextStyle(color: AppColor.greyColor),
                decoration: InputDecoration(
                  hintText: 'Search $title...',
                  hintStyle: TextStyle(color: AppColor.greyColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: AppColor.blueColor,
                ),
              ),
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text(
                  itemAsString(item),
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColor.greyColor,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                tileColor: isSelected ? AppColor.blueColor : null,
              ),
              menuProps: MenuProps(
                barrierColor: Colors.black.withOpacity(0.5),
                backgroundColor: AppColor.blueColor,
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: _inputDecoration(hintText: hintText),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Updated TextField builder with hintText
  Widget _buildTextFile(
      {required TextEditingController textEditingController,
      required String title,
      required int maxLines,
      String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTile(title: title),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: TextFormField(
            controller: textEditingController,
            maxLines: maxLines,
            decoration: _inputDecoration(hintText: hintText), // Add hintText
            style: _textStyle(),
          ),
        ),
      ],
    );
  }

  // Common Input Decoration with hintText support
  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      filled: true,
      fillColor: AppColor.primaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: AppColor.greyColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: AppColor.greyColor,
          width: 2.0,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      hintText: hintText, // Set the hint text
      hintStyle: _textStyle(color: AppColor.greyColor.withOpacity(0.4)),
    );
  }

  // AppBar
  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.primaryColor,
      centerTitle: true,
      title: _buildBackButton(),
    );
  }

  Widget _buildBackButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Row(
          children: [
            Icon(Icons.arrow_back, color: AppColor.textColor),
            const SizedBox(width: 12),
            Text('Back'.tr, style: _textStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  // Image Upload Section
  Widget _buildBookImagesSection() {
    return Obx(() => controller.bookImages.isEmpty
        ? _buildImagePlaceholder()
        : _buildImageCarousel());
  }

  Widget _buildImagePlaceholder() {
    return GestureDetector(
      onTap: controller.pickBookImages,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: 204,
        height: 363,
        decoration: BoxDecoration(
          color: AppColor.button_6.withOpacity(0.16),
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              width: 57,
              height: 57,
              child: Image.asset(IconConstants.iconAddBook),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Text('Add Book image',
                  textAlign: TextAlign.center,
                  style: _textStyle(fontSize: 16, color: AppColor.blueColor_4)),
            ),
            Text('(Can upload more than 1 image)',
                textAlign: TextAlign.center,
                style: _textStyle(fontSize: 12, color: AppColor.greyColor))
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(controller.bookImages.length, (index) {
            return _buildImageCard(index);
          }),
        ),
      );
    });
  }

  Widget _buildImageCard(int index) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          width: 220, // Ensure it's half of the screen width
          height: 363, // Adjust height to be reasonable
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: FileImage(controller.bookImages[index]),
              fit:
                  BoxFit.cover, // Use BoxFit.cover to scale the image correctly
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: GestureDetector(
            onTap: () => controller.removeImage(index),
            child: _buildCancelButton(),
          ),
        ),
      ],
    );
  }

  Widget _buildCancelButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.textColor,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(Icons.cancel, color: AppColor.textWhileColor),
    );
  }

  // Upload Button
  Widget _buildUploadButton() {
    return GestureDetector(
      onTap: controller.pickBookImages,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.button_6.withOpacity(0.16),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        width: Get.width - 20,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Upload more image',
                style: _textStyle(color: AppColor.greyColor)),
            const SizedBox(width: 10),
            Icon(Icons.file_upload_outlined,
                color: AppColor.greyColor, size: 20),
          ],
        ),
      ),
    );
  }

  // Upload Book Section
  Widget _buildUploadBookSection() {
    return Obx(() => controller.uploadedBookPath.value.isEmpty
        ? GestureDetector(
            onTap: controller.pickBookFile,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.blueColor_1,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              width: Get.width - 20,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Upload Book', style: _textStyle()),
                  const SizedBox(width: 10),
                  const Icon(Icons.file_upload_outlined, size: 20),
                ],
              ),
            ),
          )
        : Text('Uploaded: ${controller.uploadedBookPath.value}'));
  }

  // Upload AudioBook Section
  Widget _buildUploadAudioBookSection() {
    return Obx(() => controller.uploadedAudiobookPath.value.isEmpty
        ? GestureDetector(
            onTap: controller.pickAudiobookFile,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.blueColor_1,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              width: Get.width - 20,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Upload Audio Book', style: _textStyle()),
                  const SizedBox(width: 10),
                  const Icon(Icons.file_upload_outlined, size: 20),
                ],
              ),
            ),
          )
        : Text('Uploaded: ${controller.uploadedAudiobookPath.value}'));
  }

  // Common Tile for Titles
  Widget _buildTile({required String title}) {
    return Container(
      margin: const EdgeInsets.only(left: 8, bottom: 4),
      child: Text(
        title,
        style: _textStyle(color: AppColor.textColor),
      ),
    );
  }

  // Common Dropdown Item Builder
  DropdownMenuItem<String> _buildDropdownItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value, style: _textStyle(color: AppColor.greyColor)),
    );
  }

  // Common TextStyle
  TextStyle _textStyle({double fontSize = 14, Color? color}) {
    return TextStyle(
      color: color ?? AppColor.textColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  // Chapter section where users can add chapters dynamically
  Widget _buildChapterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTile(title: 'Chapters'),
        Obx(() => Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = controller.chapters[index];
                    return _buildChapterItem(index, chapter);
                  },
                ),
                _buildAddChapterButton(), // Button to add new chapter
              ],
            )),
      ],
    );
  }

  Widget _buildChapterItem(int index, Chapter chapter) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: AppColor.blueColor_3,
            width: 1.5,
          ),
          color: AppColor.blueColor_1.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Chapter ${index + 1}', // Display chapter number
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    // Remove chapter from the list
                    controller.removeChapter(index);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    chapter.isLocked.value
                        ? 'Locked'
                        : 'Unlocked', // Lock status
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: chapter.isLocked.value ? Colors.red : Colors.green,
                      fontSize: 14,
                    ),
                  ),
                ),
                Obx(() => Switch(
                      value: chapter.isLocked.value,
                      onChanged: (val) {
                        chapter.isLocked.value = val;
                      },
                      activeColor: Colors.redAccent,
                      inactiveThumbColor: Colors.green,
                      inactiveTrackColor: Colors.green.withOpacity(0.5),
                    )),
              ],
            ),
            const SizedBox(height: 8),
            _buildInputField(
              'Chapter Name',
              chapter.nameController,
              hintText: 'Enter chapter name',
              keyboardType: TextInputType.text,
            ),
            _buildInputField(
              'Chapter Description',
              chapter.descriptionController,
              hintText: 'Enter chapter description',
              keyboardType: TextInputType.text,
            ),
            _buildUploadChapterFileButton(index),
          ],
        ),
      ),
    );
  }

  // Button to upload a file for a specific chapter
  Widget _buildUploadChapterFileButton(int index) {
    return GestureDetector(
      onTap: () {
        if (controller.isVideo.value) {
          controller
              .pickChapterFileVideo(index); // Pick a video file for the chapter
        } else if (controller.selectedFormat.value == 'eBook') {
          controller.pickChapterFileEbook(index); // Pick a file for the chapter
        } else {
          controller.pickChapterFileAudio(
              index); // Pick an audio file for the chapter
        }
      },
      child: Obx(() => Container(
          decoration: BoxDecoration(
            color: AppColor.blueColor_1,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          width: Get.width - 20,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.chapters[index].fileName.value.isNotEmpty
                      ? 'Uploaded: ${controller.chapters[index].fileName.value}'
                      : 'Upload Chapter File',
                  style: _textStyle(),
                  overflow: TextOverflow.ellipsis, // Prevent overflow
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.file_upload_outlined, size: 20),
            ],
          ))),
    );
  }

  // Button to add new chapter
  Widget _buildAddChapterButton() {
    return GestureDetector(
      onTap: () {
        controller.addChapter(); // Add a new chapter entry
      },
      child: Container(
        alignment: Alignment.center,
        width: Get.width - 20,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColor.button_6.withOpacity(0.16),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Add Chapter',
          style: _textStyle(),
        ),
      ),
    );
  }

  Widget _buildUpload() {
    return GestureDetector(
      onTap: () {
        controller.uploadBook();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.blueColor_2,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        width: Get.width - 20,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Upload', style: _textStyle(color: AppColor.greyColor)),
            const SizedBox(width: 10),
            Icon(Icons.file_upload_outlined,
                color: AppColor.greyColor, size: 20),
          ],
        ),
      ),
    );
  }
}
