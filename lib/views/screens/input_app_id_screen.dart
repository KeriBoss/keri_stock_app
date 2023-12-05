import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_project/core/extension/number_extension.dart';
import 'package:stock_market_project/data/static/enum/local_storage_enum.dart';
import 'package:stock_market_project/services/local_storage_service.dart';
import 'package:stock_market_project/views/screens/register_screen.dart';
import 'package:stock_market_project/views/screens/webview_screen.dart';
import 'package:stock_market_project/views/widgets/gradient_button.dart';

import '../../bloc/webview/webview_bloc.dart';
import '../../core/router/app_router_config.dart';
import '../../services/firebase_message_service.dart';

@RoutePage()
class InputAppIdScreen extends StatefulWidget {
  const InputAppIdScreen({super.key});

  @override
  State<InputAppIdScreen> createState() => _InputAppIdScreenState();
}

class _InputAppIdScreenState extends State<InputAppIdScreen> {
  TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<String?> _getAppIdFromLocal() async {
    return await LocalStorageService.getLocalStorageData(
      LocalStorageEnum.appId.name,
    );
  }

  Future<void> _setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    context
        .read<WebviewBloc>()
        .add(OnLoadWebviewEvent(message.data['link1'].toString()));

    context.router.replaceAll([
      WebViewRoute(url: message.data['link1'].toString()),
    ]);
  }

  @override
  void initState() {
    FirebaseMessageService(context).initNotifications();

    //Load code form storage
    _getAppIdFromLocal().then((currentCode) {
      if (currentCode != null && currentCode.isNotEmpty) {
        context.router.pushWidget(
          WebViewScreen(
            code: currentCode,
          ),
        );
      }
    });

    super.initState();

    _setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
              padding: EdgeInsets.all(10.size),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: codeController,
                    decoration: const InputDecoration(
                      hintText: "Nhập App ID",
                    ),
                    validator: ((value) {
                      if (value != null) {
                        return null;
                      }
                      return "Vui lòng nhập mã";
                    }),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        LocalStorageService.setLocalStorageData(
                          LocalStorageEnum.appId.name,
                          codeController.text,
                        );

                        context.router.pushWidget(WebViewScreen(
                          code: codeController.text,
                        ));
                      }
                    },
                    child: const Text('Tra Cứu'),
                  ),
                  GradientElevatedButton(
                    text: 'Đăng ký tài khoản',
                    onPress: () => context.router.pushWidget(
                      const RegisterScreen(
                        isShipper: false,
                      ),
                    ),
                    buttonMargin: EdgeInsets.only(top: 20.height),
                    buttonHeight: 40.height,
                    buttonWidth: MediaQuery.of(context).size.width / 2,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
