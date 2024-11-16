import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../features/reading_pdf/reading_pdf_controller.dart';

class ReadingPdfScreen extends GetView<ReadingPdfController> {
  const ReadingPdfScreen({super.key});
  void _showBookmarksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bookmarks'),
          content: Obx(() {
            if (controller.bookmarks.isEmpty) {
              return const Text('No bookmarks added.');
            } else {
              return ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300, // Set maximum height for scrollable list
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: controller.bookmarks.map((page) {
                      return ListTile(
                        title: Text('Page $page'),
                        onTap: () {
                          controller.goToPage(page);
                          Navigator.of(context).pop();
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            controller
                                .removeBookmark(page); // Remove the bookmark
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }
          }),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Add Bookmark Button
                IconButton(
                  icon: const Icon(Icons.bookmark_add, color: Colors.blue),
                  onPressed: () {
                    controller.addBookmark('', controller.currentPage.value);
                    Navigator.of(context).pop(); // Close dialog after adding
                  },
                ),
                // Close Button
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.pageview),
            onPressed: () {
              _showGoToPageDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              // controller.pdfViewerKey.currentState?.openBookmarkView();
              _showBookmarksDialog(context);
            },
          ),
          // Nút tăng zoom
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              controller.increaseZoom(); // Tăng zoom
            },
          ),
          // Nút giảm zoom
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              controller.decreaseZoom(); // Giảm zoom
            },
          ),
          // Nút đổi màu nền
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              _showColorPicker(context); // Đổi màu nền
            },
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              controller.toggleScrollDirection(); // Chuyển đổi hướng cuộn
            },
          ),
        ],
      ),
      body: Obx(() => Container(
          color: controller.backgroundColor.value, // Màu nền của PDF
          child: Column(
            children: [
              Expanded(
                  child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  controller
                      .backgroundColor.value, // Lọc màu để tạo hiệu ứng sáng
                  BlendMode.difference, // Thay đổi kiểu blend để tạo dark mode
                ),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.pdfData.value != null) {
                    return SfPdfViewer.memory(
                      controller.pdfData.value!,
                      key: controller.pdfViewerKey,
                      controller: controller.pdfViewerController,
                    );
                  } else // Display EPUB viewer if EPUB data is loaded
                    return EpubView(
                      controller: controller.epubController,
                    );
                }),
              )),
              Container(
                decoration:
                    BoxDecoration(color: controller.backgroundColor.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_left),
                      onPressed: () {
                        final newPage = controller.currentPage.value - 1;
                        if (newPage >= 0) {
                          controller.goToPage(newPage);
                        }
                      },
                    ),
                    Text(
                      '${controller.currentPage.value + 1} / ${controller.totalPages.value}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () {
                        final newPage = controller.currentPage.value + 1;
                        if (newPage < controller.totalPages.value) {
                          controller.goToPage(newPage);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ))),
    );
  }

  void _showColorPicker(BuildContext context) {
    Color selectedColor = controller.backgroundColor.value;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn màu nền'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              availableColors: const [
                Colors.white,
                Colors.black,
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.orange,
                Colors.purple,
                Colors.brown,
                Colors.grey,
                Colors.pink,
                Colors.teal,
                Color(0xFF123456),
                Color(0xFF654321),
              ],
              onColorChanged: (Color color) {
                selectedColor = color;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Xác nhận'),
              onPressed: () {
                controller.changeBackgroundColor(selectedColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showGoToPageDialog(BuildContext context) {
    final TextEditingController pageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chuyển đến Trang'),
          content: TextField(
            controller: pageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Nhập số trang'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Xác nhận'),
              onPressed: () {
                final int? pageNumber = int.tryParse(pageController.text);
                if (pageNumber != null &&
                    pageNumber > 0 &&
                    pageNumber <= controller.totalPages.value) {
                  controller.goToPage(
                      pageNumber - 1); // Chuyển đến trang, 0-based index
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
