enum SubscriptionTypePeriodEnum {
  monthly,
  yearly,
}

extension SubscriptionTypePeriodEnumString on SubscriptionTypePeriodEnum {
  String toShortString() {
    return toString().split('.').last;
  }
}

enum SubscriptionUserStatusEnum {
  pending,
  completed,
}

extension SubscriptionUserStatusEnumString on SubscriptionUserStatusEnum {
  String toShortString() {
    return toString().split('.').last;
  }
}

enum SubscriptionTypeEnum {
  personal,
  business,
}

extension SubscriptionTypeEnumString on SubscriptionTypeEnum {
  String toShortString() {
    return toString().split('.').last;
  }
}

