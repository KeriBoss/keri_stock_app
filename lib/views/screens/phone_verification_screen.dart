import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market_project/bloc/authorization/authorization_bloc.dart';
import 'package:stock_market_project/core/extension/number_extension.dart';
import 'package:stock_market_project/data/static/app_value.dart';

import '../../core/router/app_router_path.dart';
import '../../data/entities/user.dart' as custom_user;
import '../../data/static/enum/phone_verify_purpose_enum.dart';
import '../../main.dart';
import '../../services/firebase_sms_service.dart';
import '../../utils/ui_render.dart';
import '../widgets/gradient_button.dart';

@RoutePage()
class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({
    super.key,
    required this.user,
    required this.purpose,
  });

  final custom_user.User user;
  final PhoneVerifyPurposeEnum purpose;

  @override
  State<StatefulWidget> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _verificationCodeController =
      TextEditingController();

  void _onPressBackButton() {
    context.router.pop();
  }

  String? _textFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Hãy nhập mã OTP';
    } else if (value.length != 6) {
      return 'Mã xác thực phải có 6 chữ số';
    }
    return null;
  }

  void _onPressVerifyButton() async {
    if (_formKey.currentState!.validate()) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: AppValue.verificationId ?? '',
          smsCode: _verificationCodeController.text,
        );

        if (widget.purpose == PhoneVerifyPurposeEnum.register) {
          await auth.signInWithCredential(credential).then((value) {
            BlocProvider.of<AuthorizationBloc>(context).add(
              OnRegisterEvent(widget.user),
            );

            UiRender.showSnackBar(
              context,
              'Chào mừng bạn, xin hãy đăng nhập để sử dụng ứng dụng',
            );

            context.router.pushNamed(AppRouterPath.login);
          });
        } else if (widget.purpose == PhoneVerifyPurposeEnum.changePassword) {
          // context.router.pushWidget(ChangePasswordScreen(user: widget.user));
        }
      } catch (e) {
        UiRender.showSnackBar(context, e.toString());
      }
    }
  }

  void _onPressResendButton() {
    FirebaseSmsService.verifyPhoneNumber(
      widget.user.phoneNumber,
    ).then(
      (value) => UiRender.showDialog(
        context,
        '',
        'Đã gửi mã OTP lại thành công, xin hãy kiểm tra tin nhắn!',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: _onPressBackButton,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.size),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Xác thực số điện thoại',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25.size,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              20.verticalSpace,
              Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 15.height),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.radius),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _verificationCodeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Nhập mã OTP từ tin nhăn điện thoại...',
                          border: InputBorder.none,
                        ),
                        validator: _textFieldValidator,
                      ),
                    ),
                  ],
                ),
              ),
              GradientElevatedButton(
                text: 'Xác thực',
                buttonHeight: 50.height,
                onPress: _onPressVerifyButton,
              ),
              TextButton(
                onPressed: _onPressResendButton,
                child: const Text(
                  'Chưa nhận mã?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
