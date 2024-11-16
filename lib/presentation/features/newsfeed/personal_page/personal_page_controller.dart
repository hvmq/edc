import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/all.dart';
import '../../../../models/enums/mission_mana_type_enum.dart';
import '../../../../models/mana_mission/mana.dart';
import '../../../../models/mana_mission/mana_mission.dart';
import '../../../base/all.dart';
import '../../all.dart';

class PersonalPageController extends BaseController with ScrollMixin {
  final homeController = Get.find<HomeController>();
  final Rx<ManaMissionTypeEnum> _manaMissionType =
      ManaMissionTypeEnum.daily.obs;
  RxString phoneNumber = ''.obs;
  final Rxn<Mana> _mana = Rxn();
  RxList<Post> posts = <Post>[].obs;
  final RxList<ManaMission> _manaMissions = <ManaMission>[].obs;

  static const _pageSize = 20;
  int pageKey = 1;
  RxBool isLoadingLoadMore = false.obs;
  RxBool hasMorePage = false.obs;

  RxString codeRx = ''.obs;

  RxBool showCard = false.obs;

  RxString shareLink = ''.obs;
  RxString idShareLink = ''.obs;

  RxBool isLoadingInit = true.obs;

  @override
  void onReady() {
    Future.delayed(Duration.zero, () async {
      update();
    });

    super.onReady();
  }

  void setCodeRx() {
    codeRx.value = 'not_match';
  }

  void setShowCard(bool value) {
    showCard.value = value;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getSharedLink();
    isLoadingInit.value = false;
    ever(_manaMissionType, (callback) {
      getManaMissionDay();
    });
    // posts.clear();
    // pageKey = 1;

    // await Future.wait([
    //   // getPostPersonalPage(),
    // ]);
    await getManaMissionDay();

    // Future<void> getPhoneNumber() async {
    //   phoneNumber.value = await PhoneNumberUtil.formatPhoneNumber(
    //     currentUserRx.value?.phone ?? '',
    //   );
    //   update();
  }

  Future<void> getPostPersonalPageRepository({
    bool isLoadMore = false,
    bool isRefresh = false,
  }) async {}

  Future<void> getPostPersonalPage() async {
    await runAction(
      action: () async {
        pageKey = 1;
        posts.clear();
        await getPostPersonalPageRepository();
      },
    );
  }

  var isLoadingMisson = false.obs;
  Future<void> getManaMissionDay() async {
    isLoadingMisson.value = true;
    update();

    isLoadingMisson.value = false;
    update();
  }

  Future<void> onRefreshPostPersonalPage() async {
    await runAction(
      handleLoading: false,
      action: () async {
        pageKey = 1;

        await getPostPersonalPageRepository(isRefresh: true);
      },
    );
  }

  Future<void> loadMorePostPersonalPage() async {
    await runAction(
      handleLoading: false,
      action: () async {
        if (!hasMorePage.value) return;

        isLoadingLoadMore.value = true;

        pageKey++;
        await getPostPersonalPageRepository(isLoadMore: true);

        isLoadingLoadMore.value = false;
      },
      onError: (exception) {
        isLoadingLoadMore.value = false;
      },
    );
  }

  List<ManaMission> get manaMissions => _manaMissions.toList();

  set manaMissions(List<ManaMission> value) {
    _manaMissions.assignAll(value);
  }

  ManaMissionTypeEnum get manaMissionType => _manaMissionType.value;

  set manaMissionType(ManaMissionTypeEnum value) {
    _manaMissionType.value = value;
  }

  Rx<ManaMissionTypeEnum> get rxMissionManaType => _manaMissionType;

  Mana? get mana => _mana.value;

  set mana(Mana? value) {
    _mana.value = value;
  }

  void onRefreshManaMission() {
    getManaMissionDay();
  }

  @override
  Future<void> onEndScroll() async {
    await loadMorePostPersonalPage();
  }

  @override
  Future<void> onTopScroll() async {
    if (scroll.hasClients) {
      await scroll.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  RxBool isLoadingBtnDeleteAccount = false.obs;
  TextEditingController deleteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> deleteAccount() async {
    isLoadingBtnDeleteAccount.value = true;
    update();

    try {} catch (e) {
      ViewUtil.showToast(
        title: l10n.global__error_title,
        message: l10n.global__error_has_occurred,
      );
    } finally {
      Future.delayed(const Duration(milliseconds: 500), () {
        isLoadingBtnDeleteAccount.value = false;
        update();
      });
    }
  }

  Future<void> getSharedLink() async {
    late String getsharedLink;
  }

  void updatePrivacy(UpdatePrivacyType type) {}
}

enum UpdatePrivacyType {
  globalSearch,
  showEmail,
  showPhone,
  showBirthDay,
}
