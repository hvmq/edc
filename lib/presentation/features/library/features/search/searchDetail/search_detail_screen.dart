import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/color.dart';
import '../../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../../features/library/_book_item.dart';
import '../../../features/search/searchDetail/_evaluate_dialog.dart';
import '../../../features/search/searchDetail/_filter_dialog.dart';
import '../../../features/search/searchDetail/_price_filter_dialog.dart';
import '../search_controller.dart';

part '_content.dart';
part '_filter.dart';
part '_list_book.dart';
part '_search_detail.dart';

class SearchDetailScreen extends GetView<MySearchController> {
  const SearchDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColor.textColor,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        const WidgetSpan(
                            child: SizedBox(
                          width: 12,
                        )),
                        TextSpan(
                          text: 'Result'.tr,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchDetail(context),
            _filter(context),
            _content(context),
            _listBook(context),
          ],
        ),
      ),
    );
  }
}
