import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'phoneNumber')
  String phoneNumber;
  String? email;
  String fullName;
  String? address;
  String idCertificateNumber;
  String password;
  String? phoneFcmToken;

  User({
    required this.phoneNumber,
    this.email,
    required this.fullName,
    this.address,
    required this.idCertificateNumber,
    required this.password,
    this.phoneFcmToken,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        phoneNumber: json['sodienthoai'] as String,
        password: json['matkhau'] as String,
        phoneFcmToken: json['phonefcmtoken'] as String?,
        fullName: json['tennhanvien'] as String,
        email: json['email'] as String,
        idCertificateNumber: json['cmndcccd'] as String,
        address: json['diachi'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sodienthoai': phoneNumber,
        'matkhau': password,
        'phonefcmtoken': phoneFcmToken,
        "diachi": address,
        "cmndcccd": idCertificateNumber,
        'tennhanvien': fullName,
        'email': email,
      };

  // String getRole() {
  //   return userRole == RoleEnum.admin.name
  //       ? 'Quản trị viên'
  //       : userRole == RoleEnum.client.name
  //           ? 'Khách hàng'
  //           : userRole == RoleEnum.loaner.name
  //               ? 'Bên cho vay'
  //               : 'Không xác định';
  // }
}
