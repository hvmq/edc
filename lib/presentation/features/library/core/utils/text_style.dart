import 'package:flutter/material.dart';

import '../../core/utils/color.dart';
import '../../core/utils/common/common.dart';

class TextAppStyle {
  static const String appFont = 'OpenSans';

  TextStyle appBarTitle() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: 14,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle appBarTitleLight() {
    return TextStyle(
        color: AppColor.textWhileColor,
        fontSize: 14,
        fontFamily: CommonContants.bold);
  }

  TextStyle normalTextStyleExtraSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.medium);
  }

  TextStyle normalTextStyleSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.medium);
  }

  TextStyle normalTextStyle() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.medium);
  }

  TextStyle normalTextStyleTheme(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.medium);
  }

  TextStyle normalTextStyleLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.medium);
  }

  TextStyle normalTextStyleExtraLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.medium);
  }

  // light-text
  TextStyle normalTextStyleExtraSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.medium);
  }

  TextStyle normalTextStyleSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.medium);
  }

  TextStyle normalTextStyleLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.medium);
  }

  TextStyle normalTextStyleLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.medium);
  }

  TextStyle normalTextStyleExtraLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.medium);
  }

  //*ThinText: FontWeight: W400, fontsize: 10,12,14,16,18, color: Black
  TextStyle thinTextStyleExtraSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.light);
  }

  TextStyle thinTextStyleSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.light);
  }

  TextStyle thinTextStyle() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.light);
  }

  TextStyle thinTextStyleLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.light);
  }

  TextStyle thinTextStyleExtraLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.light);
  }

//light_text
  TextStyle thinTextStyleExtraSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.light);
  }

  TextStyle thinTextStyleSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.light);
  }

  TextStyle thinTextStyleLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.light);
  }

  TextStyle thinTextStyleLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.light);
  }

  TextStyle thinTextStyleExtraLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.light);
  }

  //*Semibold: FontWeight: SemiBold, fontsize: 10,12,14,16,18, color: Black
  TextStyle semiBoldTextStyleExtraSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.semibold);
  }

  TextStyle semiBoldTextStyleSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.semibold);
  }

  TextStyle semiBoldTextStyle() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.semibold);
  }

  TextStyle semiBoldTextStyleLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.semibold);
  }

  TextStyle semiBoldTextStyleExtraLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.semibold);
  }

//light-text
  TextStyle semiBoldTextStyleExtraSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.semibold);
  }

  TextStyle semiBoldTextStyleSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.semibold);
  }

  TextStyle semiBoldTextStyleLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.semibold);
  }

  TextStyle semiBoldTextStyleLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.semibold);
  }

  TextStyle semiBoldTextStyleExtraLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.semibold);
  }

  //*titleText: FontWeight: Bold, fontsize: 10,12,14,16,18, color: Black
  TextStyle titleStyleExtraSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.bold);
  }

  TextStyle titleStyleSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.bold);
  }

  TextStyle titleStyle() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.bold);
  }

  TextStyle titleStyleLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.bold);
  }

  TextStyle titleStyleExtraLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.bold);
  }

  //light-text
  TextStyle titleStyleExtraSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.bold);
  }

  TextStyle titleStyleSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.bold);
  }

  TextStyle titleStyleLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.bold);
  }

  TextStyle titleStyleLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.bold);
  }

  TextStyle titleStyleExtraLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.bold);
  }

  //*superText: FontWeight: ExtraBold, fontsize: 10,12,14,16,18, color: Black
  TextStyle superStyleExtraSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyleSmall() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyle() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyleLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyleExtraLarge() {
    return TextStyle(
        color: AppColor.textBlackColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.extrabold);
  }

//light-text
  TextStyle superStyleExtraSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraSmallText,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyleSmallLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.smallText,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyleLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.mediumText,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyleLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyleExtraLargeLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraLargeText,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyleExtraLargeTitleLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.extraLargeTitle,
        fontFamily: CommonContants.extrabold);
  }

  TextStyle superStyleLargeTitleLight() {
    return TextStyle(
        color: AppColor.textColor,
        fontSize: CommonContants.largeText,
        fontFamily: CommonContants.extrabold);
  }
}
