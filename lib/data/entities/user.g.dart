// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      phoneNumber: json['phonenumber'] as String,
      email: json['email'] as String?,
      fullName: json['fullname'] as String,
      sex: json['sex'] as String,
      address: json['address'] as String?,
      idCertificateNumber: json['idcertificatenumber'] as String,
      password: json['password'] as String,
      status: json['status'] as String?,
      userRole: json['userrole'] as String,
      phoneFcmToken: json['phonefcmtoken'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'phonenumber': instance.phoneNumber,
      'email': instance.email,
      'fullname': instance.fullName,
      'sex': instance.sex,
      'address': instance.address,
      'idcertificatenumber': instance.idCertificateNumber,
      'password': instance.password,
      'status': instance.status,
      'userrole': instance.userRole,
      'phonefcmtoken': instance.phoneFcmToken,
    };
