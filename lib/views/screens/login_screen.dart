import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market_project/bloc/authorization/authorization_bloc.dart';
import 'package:stock_market_project/core/extension/number_extension.dart';
import 'package:stock_market_project/services/firebase_message_service.dart';
import 'package:stock_market_project/views/screens/register_screen.dart';

import '../../data/static/enum/local_storage_enum.dart';
import '../../services/local_storage_service.dart';
import '../../utils/ui_render.dart';
import '../widgets/gradient_button.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  bool _isPasswordObscure = true;
  bool _rememberPassword = false;

  Future<void> _initLocalStorageValues() async {
    _phoneNumberTextEditingController.text =
        await LocalStorageService.getLocalStorageData(
      LocalStorageEnum.phoneNumber.name,
    ) as String;

    _passwordTextEditingController.text =
        await LocalStorageService.getLocalStorageData(
      LocalStorageEnum.password.name,
    ) as String;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (_phoneNumberTextEditingController.text != '' &&
            _passwordTextEditingController.text != '') {
          _rememberPassword = true;
        }
      });
    });
  }

  final String? Function(String?) _phoneNumberAndPasswordValidator =
      (String? value) {
    if (value!.trim().contains(' ')) {
      return 'Số điện thoại và mật khẩu không được chứa khoảng trống';
    }

    return null;
  };

  void _onPressPasswordEyeButton() {
    setState(() {
      _isPasswordObscure = !_isPasswordObscure;
    });
  }

  void _onChangeRememberPasswordCheckbox(bool? value) {
    setState(() {
      if (value == true &&
          (_phoneNumberTextEditingController.text != '' &&
              _passwordTextEditingController.text != '')) {
        LocalStorageService.setLocalStorageData(
          LocalStorageEnum.phoneNumber.name,
          _phoneNumberTextEditingController.text,
        );

        LocalStorageService.setLocalStorageData(
          LocalStorageEnum.password.name,
          _passwordTextEditingController.text,
        );

        _rememberPassword = true;

        LocalStorageService.setLocalStorageData(
          LocalStorageEnum.rememberLogin.name,
          _rememberPassword,
        );
      } else if (_phoneNumberTextEditingController.text == '' ||
          _passwordTextEditingController.text == '') {
        UiRender.showDialog(
          context,
          '',
          'Hãy điền đầy đủ số điện thoại và mật khẩu!',
        );
        _rememberPassword = false;
      } else {
        _rememberPassword = false;

        LocalStorageService.removeLocalStorageData(
          LocalStorageEnum.phoneNumber.name,
        );

        LocalStorageService.removeLocalStorageData(
          LocalStorageEnum.password.name,
        );

        LocalStorageService.removeLocalStorageData(
          LocalStorageEnum.rememberLogin.name,
        );
      }
    });
  }

  String? _textFieldValidator(
    String? value,
    String? Function(String?)? additionalValidator,
  ) {
    if (value == null || value.isEmpty) {
      return 'Không được để trống!';
    } else if (additionalValidator != null) {
      return additionalValidator(value);
    }
    return null;
  }

  void _onPressedLoginButton() async {
    if (_loginFormKey.currentState!.validate()) {
      context.read<AuthorizationBloc>().add(
            OnLoginEvent(
              _phoneNumberTextEditingController.text,
              _passwordTextEditingController.text,
            ),
          );
    }
  }

  void _onPressedRegisterButton(bool isShipper) {
    context.router.pushWidget(RegisterScreen(isShipper: isShipper));
  }

  void _onPressForgotPassword() {
    if (_phoneNumberTextEditingController.text.isNotEmpty) {
      context.read<AuthorizationBloc>().add(
            OnGetUserInfoEvent(
              _phoneNumberTextEditingController.text,
            ),
          );
    } else {
      UiRender.showDialog(context, '', 'Xin hãy điền số điện thoại của bạn!');
    }
  }

  @override
  void initState() {
    _initLocalStorageValues();
    FirebaseMessageService(context).initNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.size),
        child: Form(
          key: _loginFormKey,
          child: BlocConsumer<AuthorizationBloc, AuthorizationState>(
            listener: (context, state) {
              if (state is AuthorizationRegisteredState) {
                UiRender.showSnackBar(
                  context,
                  'Chào mừng bạn, xin hãy đăng nhập để sử dụng ứng dụng',
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  300.verticalSpace,
                  _customTextField(
                    controller: _phoneNumberTextEditingController,
                    hintText: 'Số điện thoại',
                    additionalValidator: _phoneNumberAndPasswordValidator,
                    keyboardType: TextInputType.number,
                  ),
                  _customTextField(
                    controller: _passwordTextEditingController,
                    hintText: 'Mật khẩu',
                    isPassword: true,
                    isObscure: _isPasswordObscure,
                  ),
                  10.verticalSpace,
                  _rememberPasswordCheckBox('Ghi nhớ mật khẩu'),
                  10.verticalSpace,
                  GradientElevatedButton(
                    text: 'Đăng nhập',
                    buttonHeight: 50.height,
                    onPress: _onPressedLoginButton,
                  ),
                  TextButton(
                    onPressed: _onPressForgotPassword,
                    child: const Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () => _onPressedRegisterButton(true),
                  //   child: const Text(
                  //     'Đăng ký dành cho Shipper',
                  //     style: TextStyle(
                  //       color: Colors.grey,
                  //       fontStyle: FontStyle.italic,
                  //     ),
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () => _onPressedRegisterButton(false),
                    child: const Text(
                      'Đăng ký dành cho Khách hàng',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool isObscure = false,
    String? Function(String?)? additionalValidator,
  }) {
    return Container(
      padding: const EdgeInsets.all(7),
      margin: EdgeInsets.symmetric(vertical: 15.height),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 5.width),
              ),
              validator: (value) => _textFieldValidator(
                value,
                additionalValidator,
              ),
              obscureText: isObscure,
            ),
          ),
          !isPassword
              ? const SizedBox()
              : IconButton(
                  icon: Icon(
                    isObscure
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _onPressPasswordEyeButton,
                ),
        ],
      ),
    );
  }

  Widget _rememberPasswordCheckBox(String content) {
    return Row(
      children: [
        SizedBox(
          width: 24.width,
          height: 24.height,
          child: Checkbox(
            activeColor: Theme.of(context).colorScheme.secondary,
            checkColor: Theme.of(context).colorScheme.primary,
            value: _rememberPassword,
            onChanged: _onChangeRememberPasswordCheckbox,
          ),
        ),
        Text(
          ' $content',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15.size,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        )
      ],
    );
  }
}
