import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiRender {
  const UiRender._();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context,
    String content,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  static LinearGradient generalLinearGradient() {
    return const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xff8D8D8C), Color(0xff000000)],
    );
  }

  static Widget loadingCircle(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  static Image convertBase64ToImage(String base64) {
    Uint8List bytesImage;

    bytesImage = const Base64Decoder().convert(base64);

    return Image.memory(bytesImage);
  }

  static Future<bool> showConfirmDialog(
    BuildContext context,
    String title,
    String message, {
    TextAlign textAlign = TextAlign.center,
    String confirmText = 'OK',
  }) async {
    bool result = await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: title.isNotEmpty ? Text(title) : null,
          content: message.isNotEmpty
              ? Text(
                  message,
                  textAlign: textAlign,
                )
              : null,
          actions: [
            // The "Yes" button
            CupertinoDialogAction(
              onPressed: () {
                context.router.pop(true);
              },
              isDefaultAction: true,
              child: Text(
                confirmText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            // The "No" button
            CupertinoDialogAction(
              onPressed: () {
                context.router.pop(false);
              },
              isDestructiveAction: true,
              child: const Text('Huỷ'),
            ),
          ],
        );
      },
    );

    return false;
  }

  static Future<void> showDialog(
    BuildContext context,
    String title,
    String message, {
    TextAlign textAlign = TextAlign.center,
  }) async {
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: title.isNotEmpty ? Text(title) : null,
          content: message.isNotEmpty
              ? Text(
                  message,
                  textAlign: textAlign,
                )
              : null,
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                context.router.pop(true);
              },
              isDefaultAction: true,
              child: Text(
                'Xác nhận',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showWidgetDialog(
    BuildContext context, {
    String title = '',
    required Widget child,
    String confirmText = 'OK',
  }) async {
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: title.isNotEmpty ? Text(title) : null,
          content: child,
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                context.router.pop(true);
              },
              isDefaultAction: true,
              child: Text(
                'Xác nhận',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> showWidgetConfirmDialog(
    BuildContext context, {
    String title = '',
    required Widget child,
    String confirmText = 'Xác nhận',
  }) async {
    bool result = await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: title.isNotEmpty ? Text(title) : null,
          content: child,
          actions: [
            // The "Yes" button
            CupertinoDialogAction(
              onPressed: () {
                context.router.pop(true);
              },
              isDefaultAction: true,
              child: Text(
                confirmText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            // The "No" button
            CupertinoDialogAction(
              onPressed: () {
                context.router.pop(false);
              },
              isDestructiveAction: true,
              child: const Text('Huỷ'),
            ),
          ],
        );
      },
    );

    return false;
  }
}
