import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_market_project/core/success/success.dart';
import 'package:stock_market_project/data/static/enum/database_table_enum.dart';
import 'package:stock_market_project/services/network_service.dart';

import '../../core/failure/failure.dart';
import '../../services/firebase_database_service.dart';
import '../../services/local_storage_service.dart';
import '../entities/user.dart';
import '../static/enum/firestore_enum.dart';
import '../static/enum/local_storage_enum.dart';

class AuthorizationRepository {
  Future<Either<Failure, User>> login(
    String phoneNumber,
    String password,
  ) async {
    try {
      User? user;

      await FirebaseDatabaseService.getObjectMap(
        collection: FireStoreCollectionEnum.users.name,
        document: phoneNumber,
      ).then((responseMap) async {
        if (responseMap != null) {
          if (responseMap['password'] != password) {
            return const Left(ApiFailure('Sai mật khẩu'));
          }

          String fcmToken = await LocalStorageService.getLocalStorageData(
            LocalStorageEnum.phoneToken.name,
          ) as String;

          await FirebaseDatabaseService.updateData(
            data: {
              'phoneFcmToken': fcmToken,
            },
            collection: FireStoreCollectionEnum.users.name,
            document: phoneNumber,
          );

          user = User.fromJson(responseMap);
        }
      });

      if (user != null) {
        String? rememberPass = await LocalStorageService.getLocalStorageData(
            LocalStorageEnum.rememberLogin.name) as String?;

        if (rememberPass != null && rememberPass == 'true') {
          LocalStorageService.setLocalStorageData(
            LocalStorageEnum.phoneNumber.name,
            user!.phoneNumber,
          );
          LocalStorageService.setLocalStorageData(
            LocalStorageEnum.password.name,
            user!.password,
          );
        }

        return Right(user!);
      } else {
        return const Left(ApiFailure('Tài khoản này không tồn tại'));
      }
    } catch (e, stackTrace) {
      debugPrint(
        'Caught login error: ${e.toString()} \n${stackTrace.toString()}',
      );

      return Left(ExceptionFailure(e.toString()));
    }
  }

  Future<Either<Failure, Success>> register(User newUser) async {
    bool isSuccess = false;

    try {
      // final responseMap = await FirebaseDatabaseService.getObjectMap(
      //   collection: FireStoreCollectionEnum.users.name,
      //   document: newUser.phoneNumber,
      // );

      final response = await NetworkService.get(
        queryParam: {
          'tablename': DatabaseTableEnum.tbl_users.name,
          'fieldname': 'phonenumber',
          'fieldvalue': newUser.phoneNumber,
        },
        url: '/list/',
      );

      response.fold(
        (failure) async {
          Map<String, dynamic> requestParam = {
            'tablename': DatabaseTableEnum.tbl_users.name,
            DatabaseActionEnum.submitnew.name:
                DatabaseActionEnum.submitnew.name,
          }..addAll(newUser.toJson());

          String fcmToken = await LocalStorageService.getLocalStorageData(
            LocalStorageEnum.phoneToken.name,
          ) as String;

          requestParam['phoneFcmToken'] = fcmToken;

          final res = await NetworkService.post(
            paramBody: requestParam,
            url: '/krud/',
          );

          res.fold(
            (failure) => isSuccess = false,
            (success) => isSuccess = true,
          );
        },
        (success) {
          isSuccess = false;
        },
      );

      return isSuccess
          ? const Right(ApiSuccessMessage('Đăng ký tài khoản mới thành công'))
          : const Left(ApiFailure('Tài khoản này đã tồn tại'));
    } catch (e, stackTrace) {
      debugPrint(
        'Caught register error: ${e.toString()} \n${stackTrace.toString()}',
      );

      return Left(ExceptionFailure(e.toString()));
    }
  }

  Future<Either<Failure, User>> getUserInfo(
    String phoneNumber,
  ) async {
    try {
      User? user;

      await FirebaseDatabaseService.getObjectMap(
        collection: FireStoreCollectionEnum.users.name,
        document: phoneNumber,
      ).then((responseMap) async {
        if (responseMap != null) {
          user = User.fromJson(responseMap);
        }
      });

      if (user != null) {
        return Right(user!);
      } else {
        return const Left(ApiFailure('Tài khoản này không tồn tại'));
      }
    } catch (e, stackTrace) {
      debugPrint(
        'Caught getting user info error: ${e.toString()} \n${stackTrace.toString()}',
      );
      return Left(ExceptionFailure(e.toString()));
    }
  }

  Future<Either<Failure, Success>> updateUser(
    Map<String, dynamic> data,
    String phoneNumber,
  ) async {
    String result = '';

    try {
      await FirebaseDatabaseService.updateData(
        data: data,
        collection: FireStoreCollectionEnum.users.name,
        document: phoneNumber,
      ).then((value) => result = 'Update user successfully');

      return Right(ApiSuccessMessage(result));
    } catch (e, stackTrace) {
      debugPrint(
        'Caught login error: ${e.toString()} \n${stackTrace.toString()}',
      );
      return Left(ExceptionFailure(e.toString()));
    }
  }
}
