import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_project/core/extension/number_extension.dart';
import 'package:stock_market_project/data/static/enum/local_storage_enum.dart';
import 'package:stock_market_project/services/local_storage_service.dart';
import 'package:stock_market_project/views/screens/register_screen.dart';
import 'package:stock_market_project/views/screens/webview_screen.dart';

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
  String? currentCode = "";

  Future<void> _getAppIdFromLocal() async {
    currentCode = await LocalStorageService.getLocalStorageData(
      LocalStorageEnum.appId.name,
    );
  }

  @override
  void initState() {
    FirebaseMessageService(context).initNotifications();
    //Load code form storage
    _getAppIdFromLocal();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentCode != null && currentCode!.isNotEmpty
            ? WebViewScreen(
                code: codeController.text.isNotEmpty
                    ? codeController.text
                    : currentCode!,
              )
            : Center(
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

                                setState(() {
                                  currentCode = codeController.text;
                                  context.router.pushWidget(WebViewScreen(
                                    code: currentCode!,
                                  ));
                                });
                              }
                            },
                            child: const Text('Tra Cứu'),
                          ),
                          TextButton(
                            onPressed: () => context.router.pushWidget(
                              const RegisterScreen(
                                isShipper: false,
                              ),
                            ),
                            child: const Text(
                              'Đăng ký dành cho Khách hàng',
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ));
  }
}
