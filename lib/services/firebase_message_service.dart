import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:stock_market_project/bloc/webview/webview_bloc.dart';

import '../data/static/enum/local_storage_enum.dart';
import '../main.dart';
import 'local_storage_service.dart';

class FirebaseMessageService {
  final BuildContext context;

  FirebaseMessageService(this.context);

  Future<void> initNotifications() async {
    // request for permission to get notifications from app
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    // get FCM token for this device
    final fcmToken = await firebaseMessaging.getToken();
    debugPrint('FCM token: $fcmToken');

    // cache phone fcm token
    LocalStorageService.setLocalStorageData(
      LocalStorageEnum.phoneToken.name,
      fcmToken,
    );

    // subscribe to a topic to get messages from that topic
    firebaseMessaging.subscribeToTopic('all');

    initPushFirebaseMessageNotifications();
    initLocalNotifications();

    debugPrint('Finish notification initiation');
  }

  Future initPushFirebaseMessageNotifications() async {
    try {
      // user for IOS, config foreground message options
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // event handler when application is opened from terminated state
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        debugPrint('Title: ${message?.notification?.title}');
        debugPrint('Body: ${message?.notification?.body}');
        debugPrint('Data: ${message?.data}');
      });

      // event handler when user press on the message
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        debugPrint('Title: ${message.notification?.title}');
        debugPrint('Body: ${message.notification?.body}');
        debugPrint('Data: ${message.data}');
      });

      // application gets a message when it is in the background or terminated
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

      // event handler when application gets a message on foreground
      FirebaseMessaging.onMessage.listen((message) async {
        final notification = message.notification;

        // get image from internet, then parse the base64 code the response to the notification for it to show the image
        Map<String, dynamic> msgMapData = message.data;

        String imgUrl = msgMapData['icon'] as String;
        String iconUrl = msgMapData['image'] as String;

        final http.Response imgResponse = await http.get(Uri.parse(imgUrl));
        final http.Response iconResponse = await http.get(Uri.parse(iconUrl));

        BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(
              imgResponse.bodyBytes,
            ),
          ),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(
              iconResponse.bodyBytes,
            ),
          ),
        );

        if (notification != null) {
          localNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                androidChannel.id,
                androidChannel.name,
                channelDescription: androidChannel.description,
                icon: '@drawable/ic_launcher',
                styleInformation: bigPictureStyleInformation,
              ),
              iOS: DarwinNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                  attachments: [
                    DarwinNotificationAttachment(
                      iconResponse.bodyBytes.toString(),
                    ),
                  ]),
            ),
            payload: jsonEncode(message.toMap()),
          );
        }
      });
    } catch (e, stackTrace) {
      debugPrint('Caught error: ${e.toString()} \n${stackTrace.toString()}');
    }
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const ios = DarwinInitializationSettings();
    const setting = InitializationSettings(android: android, iOS: ios);

    // init local notification settings for both platforms
    await localNotification.initialize(
      setting,
      // handle on press message event
      onDidReceiveNotificationResponse: (notiResponse) {
        Map<String, dynamic> jsonMap = jsonDecode(notiResponse.payload!);

        final message = RemoteMessage.fromMap(jsonMap);

        debugPrint('Pressed on pushed message');
        debugPrint('Title: ${message.notification?.title}');
        debugPrint('Body: ${message.notification?.body}');
        debugPrint('Data: ${message.data}');
        debugPrint('Payload: ${jsonDecode(notiResponse.payload!)}');

        context.read<WebviewBloc>().add(
              OnLoadWebviewEvent(message.data['link']),
            );
      },
    );

    final platform = localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(androidChannel);
  }

  static Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging
        .subscribeToTopic(topic)
        .then((value) => debugPrint('Subscribed to topic: $topic'));
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await firebaseMessaging
        .unsubscribeFromTopic(topic)
        .then((value) => debugPrint('Unsubscribed from topic: $topic'));
  }

  static Future<void> sendMessage({
    Map<String, dynamic>? data,
    required String title,
    required String content,
    String? receiverToken,
    String? topic,
  }) async {
    // if (token.isEmpty) {
    //   debugPrint('Unable to send FCM message, no token exists.');
    //   return;
    // }
    Map<String, dynamic> dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      'fromPhoneToken': await LocalStorageService.getLocalStorageData(
        LocalStorageEnum.phoneToken.name,
      ) as String,
    };

    if (data != null) {
      dataMap.addAll(data);
    }

    Map<String, dynamic> payload = {
      'data': dataMap,
      'notification': {
        'title': title,
        'body': content,
      },
    };

    if (receiverToken != null && receiverToken.isNotEmpty) {
      payload['to'] = receiverToken;
    } else if (topic != null && topic.isNotEmpty) {
      payload['to'] = '/topics/$topic';
    }

    String payloadString = payload.toString();
    debugPrint(payloadString);

    try {
      await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$webServerKey',
        }),
        data: payload,
      );

      debugPrint('FCM request for device sent!');
    } catch (e, stackTrace) {
      debugPrint('Caught ${e.toString()} \n${stackTrace.toString()}');
    }
  }
}
