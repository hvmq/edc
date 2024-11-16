// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      avatarPath: json['avatar_path'] as String?,
      nickname: json['nickname'] as String?,
      loginLocal: json['login_local'] as String?,
      fetchTime: json['fetch_time'] == null
          ? null
          : DateTime.parse(json['fetch_time'] as String),
      contact: json['contact'] == null
          ? null
          : UserContact.fromJson(json['contact'] as Map<String, dynamic>),
      isActivated: json['is_activated'] as bool?,
      webUserId: json['web_user_id'] as String?,
      talkLanguage: json['talk_language'] as String?,
      linkedAddress: json['linked_address'] as String?,
      pinNumber: json['pin_number'] as String?,
      zoomId: json['zoom_id'] as String?,
      birthDay: json['birth_day'] as String?,
      knowledge: json['knowledge'] as String?,
      job: json['job'] as String?,
      hobbies: json['hobbies'] as String?,
      numberInApp: json['number_in_app'] as String?,
      premium: json['premium'] as String?,
      isSearchGlobal: json['is_search_global'] as bool?,
      isShowEmail: json['is_show_email'] as bool?,
      isShowPhone: json['is_show_phone'] as bool?,
      isShowBirthday: json['is_show_birthday'] as bool?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'avatar_path': instance.avatarPath,
      'nickname': instance.nickname,
      'login_local': instance.loginLocal,
      'fetch_time': instance.fetchTime?.toIso8601String(),
      'contact': instance.contact?.toJson(),
      'is_activated': instance.isActivated,
      'web_user_id': instance.webUserId,
      'talk_language': instance.talkLanguage,
      'linked_address': instance.linkedAddress,
      'pin_number': instance.pinNumber,
      'zoom_id': instance.zoomId,
      'birth_day': instance.birthDay,
      'knowledge': instance.knowledge,
      'job': instance.job,
      'hobbies': instance.hobbies,
      'number_in_app': instance.numberInApp,
      'premium': instance.premium,
      'is_search_global': instance.isSearchGlobal,
      'is_show_email': instance.isShowEmail,
      'is_show_phone': instance.isShowPhone,
      'is_show_birthday': instance.isShowBirthday,
    };
