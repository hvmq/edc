import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../resource/resource.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/color.dart';
import '../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../core/utils/resource/assets_constant/image_constant.dart';
import '../../features/library/_book_item.dart';
import '../../features/library/library_controller.dart';
import '../../features/library/see_more/see_more_controller.dart';

part '_banner.dart';
part '_books_on_promotion.dart';
part '_continue.dart';
part '_curriculum.dart';
part '_filter_book.dart';
part '_list_book.dart';
part '_new_books.dart';
part '_popular_books.dart';
part '_recommended_books.dart';
part '_religion.dart';
part '_search.dart';
part '_show_book_carouse.dart';
part '_topics.dart';

class LibraryScreen extends GetView<LibraryController> {
  final LibraryController libraryController;
  const LibraryScreen(this.libraryController, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _search(context),
              _filterBook(context),
              _showBookCarouse(context),
              _listBook(context),
              // _continue(context),
              _recommended_books(context),
              _banner(context),
              _curriculum(context),
              _topics(context),
              _popular_books(context),
              _new_books(context),
              _booksOnPromotion(context),
              _religion(context)
            ],
          ),
        ),
      ),
    );
  }
}
