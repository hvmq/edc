import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import 'user_contact.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed(fromJson: true, toJson: true)
class User with _$User {
  const User._();

  factory User({
    required int id,
    required String firstName,
    required String lastName,
    String? email,
    String? phone,
    String? avatarPath,
    String? nickname,
    String? loginLocal,
    DateTime? fetchTime,
    UserContact? contact,
    bool? isActivated,
    String? webUserId,
    String? talkLanguage,
    String? linkedAddress,
    String? pinNumber,
    String? zoomId,
    String? birthDay,
    String? knowledge,
    String? job,
    String? hobbies,
    String? numberInApp,
    String? premium,
    bool? isSearchGlobal,
    bool? isShowEmail,
    bool? isShowPhone,
    bool? isShowBirthday,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json, {bool store = true}) {
    final user = _$UserFromJson(json);

    return user;
  }

  static List<User> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  factory User.deactivated([int? id]) => User(
        id: id ?? DateTime.now().millisecondsSinceEpoch,
        firstName: 'Deactivated',
        lastName: 'User',
        premium: 'free',
      );

  bool isDeactivated() => id > 0 && firstName == 'Deactivated';

  String get fullName => '$firstName $lastName';

  String get displayName =>
      (nickname ?? '').trim().isNotEmpty ? nickname ?? '' : fullName;

  String get contactName => contact?.fullName ?? displayName;
}
