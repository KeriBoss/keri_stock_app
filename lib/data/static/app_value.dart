import '../entities/user.dart';

class AppValue {
  static User? currentUser;
  static String? verificationId;
  // use this path to temporarily store images from FCM payload -> get the path and show in push notification
  static String iosPushNotificationImgFilePath = '/iosPushNotificationImages';
}
