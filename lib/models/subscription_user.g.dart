// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionUser _$SubscriptionUserFromJson(Map<String, dynamic> json) =>
    SubscriptionUser(
      id: json['id'] as int,
      subscriptionId: json['subscription_id'] as int,
      payAmount: json['pay_amount'] as int,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      cycle: json['cycle'] as int,
      isCurrent: json['is_current'] as int,
      status: json['status'] as String,
      isRenewable: json['is_renewable'] as int,
      isUpgraded: json['is_upgraded'] as int,
      subscription: json['subscription'] == null
          ? null
          : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
      isExpired: json['is_expired'] as bool?,
    );

Map<String, dynamic> _$SubscriptionUserToJson(SubscriptionUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subscription_id': instance.subscriptionId,
      'pay_amount': instance.payAmount,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'cycle': instance.cycle,
      'is_current': instance.isCurrent,
      'status': instance.status,
      'is_renewable': instance.isRenewable,
      'is_upgraded': instance.isUpgraded,
      'subscription': instance.subscription?.toJson(),
      'is_expired': instance.isExpired,
    };
