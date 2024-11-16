import 'package:freezed_annotation/freezed_annotation.dart';

import 'subscription.dart';

part 'subscription_user.g.dart';

@JsonSerializable()
class SubscriptionUser {
  final int id;
  final int subscriptionId;
  final int payAmount;
  final DateTime startDate;
  final DateTime endDate;
  final int cycle;
  final int isCurrent;
  final String status;
  final int isRenewable;
  final int isUpgraded;

  final Subscription? subscription;
  final bool? isExpired;

  SubscriptionUser({
    required this.id,
    required this.subscriptionId,
    required this.payAmount,
    required this.startDate,
    required this.endDate,
    required this.cycle,
    required this.isCurrent,
    required this.status,
    required this.isRenewable,
    required this.isUpgraded,
    this.subscription,
    this.isExpired,
  });

  factory SubscriptionUser.fromJson(Map<String, dynamic> json) {
    final value = _$SubscriptionUserFromJson(json);

    return value;
  }

  Map<String, dynamic> toJson() => _$SubscriptionUserToJson(this);

  static List<SubscriptionUser> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => SubscriptionUser.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
