import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_market_project/data/static/app_value.dart';

class LocalStorageService {
  const LocalStorageService._();

  static void setLocalStorageData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value.toString());
  }

  static Future<dynamic> getLocalStorageData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key) ?? '';
  }

  static Future<void> removeLocalStorageData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<String?> downloadAndSavePicture({
    String? url,
    String? fileName,
  }) async {
    if (url == null) return null;
    final Directory directory = await getApplicationDocumentsDirectory();
    final Directory iosPushNotiImgDir = Directory(
      '${directory.path}${AppValue.iosPushNotificationImgFilePath}',
    );

    if (!(await iosPushNotiImgDir.exists())) {
      await iosPushNotiImgDir.create(recursive: true);
      debugPrint('New folder has just been created: $iosPushNotiImgDir');
    } else {
      debugPrint('This folder has been existed: $iosPushNotiImgDir');
    }

    final String filePath =
        '${iosPushNotiImgDir.path}/${fileName ?? url.substring(url.lastIndexOf('/') + 1)}';

    final http.Response response = await http.get(Uri.parse(url));

    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    debugPrint('Saved image ${file.path}');

    return filePath;
  }
}
