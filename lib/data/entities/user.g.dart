// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String?,
      fullName: json['fullName'] as String,
      sex: json['sex'] as String,
      address: json['address'] as String?,
      idCertificateNumber: json['idCertificateNumber'] as String,
      password: json['password'] as String,
      status: json['status'] as String?,
      userRole: json['userRole'] as String,
      phoneFcmToken: json['phoneFcmToken'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'fullName': instance.fullName,
      'sex': instance.sex,
      'address': instance.address,
      'idCertificateNumber': instance.idCertificateNumber,
      'password': instance.password,
      'status': instance.status,
      'userRole': instance.userRole,
      'phoneFcmToken': instance.phoneFcmToken,
    };
