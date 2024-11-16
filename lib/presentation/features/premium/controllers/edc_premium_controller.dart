import 'package:get/get.dart';

import '../../../../core/all.dart';
import '../../../../models/enums/subscription_type_enum.dart';
import '../../../../models/subscription.dart';
import '../../../../models/subscription_user.dart';
import '../../../base/all.dart';

class EDCPremiumController extends BaseController {
  final RxList<Subscription> subscriptionsPersonal = <Subscription>[].obs;
  final RxList<Subscription> subscriptionsBusiness = <Subscription>[].obs;
  final RxList<SubscriptionUser> historySubscriptions =
      <SubscriptionUser>[].obs;
  final Rx<String> currentQRCode = ''.obs;
  late Rx<SubscriptionUser?> currentSubscription = Rx<SubscriptionUser?>(null);
  late Rx<PackageStatusEnum?> currentSubscriptionStatus =
      Rx<PackageStatusEnum?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    onRefresh();
  }

  void onRefresh() {
    getListSubscription();
    getCurrentSubscription();
  }

  Future<void> getListSubscription() async {
    await runAction(
      action: () async {},
      onError: (exception) {
        ViewUtil.showToast(
          title: l10n.global__error_title,
          message: l10n.global__error_has_occurred,
        );
      },
    );
  }

  Future<void> purchaseSubscription(
      String subscriptionCode, SubscriptionTypePeriodEnum type) async {}

  Future<void> getCurrentSubscription() async {}

  Future<void> getHistorySubscription() async {}

  Future<void> upgradeSubscription(
    String subscriptionCode,
    SubscriptionTypePeriodEnum type,
  ) async {
    if (currentSubscription.value == null) {
      return;
    }
  }

  Future<void> cancelSubscription() async {
    if (currentSubscription.value == null) {
      return;
    }
  }

  Future<void> getPayment() async {
    if (currentSubscription.value == null) {
      return;
    }
  }

  Future<void> updateUserPremium() async {
    if (currentSubscription.value == null) {
      return;
    }
    if (currentSubscription.value!.status !=
        SubscriptionUserStatusEnum.completed.toShortString()) {
      return;
    }

    final premiumValue = currentSubscription.value!.subscription!.name;

    if (currentUser.premium == premiumValue) {
      return;
    }
  }

  PackageStatusEnum getPackageStatus(SubscriptionUser package) {
    if (package.isExpired!) {
      return PackageStatusEnum.expired;
    }
    if (package.isRenewable == 0) {
      return PackageStatusEnum.cancel;
    }
    if (package.status == SubscriptionUserStatusEnum.pending.toShortString()) {
      return PackageStatusEnum.paymentRequired;
    }
    if (package.status ==
        SubscriptionUserStatusEnum.completed.toShortString()) {
      return PackageStatusEnum.valid;
    }
    return PackageStatusEnum.view;
  }
}

enum PackageStatusEnum {
  expired,
  cancel,
  paymentRequired,
  valid,
  view,
}
