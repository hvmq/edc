import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  final int id;
  final String code;
  final String name;
  final String type;
  final int priceMonthly;
  final int priceYearly;
  final String description;

  Subscription({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.priceMonthly,
    required this.priceYearly,
    required this.description,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    final value = _$SubscriptionFromJson(json);

    return value;
  }

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  static List<Subscription> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => Subscription.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
