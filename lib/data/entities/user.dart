import 'package:json_annotation/json_annotation.dart';

import '../static/enum/role_enum.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'phoneNumber')
  String phoneNumber;
  String? email;
  String fullName;
  String sex;
  String? address;
  String idCertificateNumber;
  String password;
  String? status;
  String role;
  String? phoneFcmToken;

  User({
    required this.phoneNumber,
    this.email,
    required this.fullName,
    required this.sex,
    this.address,
    required this.idCertificateNumber,
    required this.password,
    this.status,
    required this.role,
    this.phoneFcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String getRole() {
    return role == RoleEnum.admin.name
        ? 'Quản trị viên'
        : role == RoleEnum.client.name
            ? 'Khách hàng'
            : role == RoleEnum.loaner.name
                ? 'Bên cho vay'
                : 'Không xác định';
  }

  String getSex() {
    return sex == 'male'
        ? 'Nam'
        : sex == 'female'
            ? 'Nữ'
            : 'Khác';
  }

  @override
  String toString() {
    return 'User{phoneNumber: $phoneNumber, email: $email, fullName: $fullName, sex: $sex, address: $address, idCertificateNumber: $idCertificateNumber, password: $password, status: $status, role: $role, phoneFcmToken: $phoneFcmToken}';
  }
}
