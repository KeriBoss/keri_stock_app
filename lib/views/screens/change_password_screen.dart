import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_market_project/core/extension/number_extension.dart';

import '../../bloc/authorization/authorization_bloc.dart';
import '../../core/router/app_router_path.dart';
import '../../data/entities/user.dart';
import '../../utils/ui_render.dart';
import '../widgets/gradient_button.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.user});

  final User user;

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _changePassFormKey = GlobalKey<FormState>();
  final TextEditingController _changePasswordController =
      TextEditingController();

  String? _textFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Hãy nhập mật khẩu mới cuả bạn';
    } else if (value.contains(' ')) {
      return 'Mật khẩu không được chứa khoảng trống';
    }
    return null;
  }

  void _onPressBackButton() {
    context.router.pop();
  }

  void _onPressConfirmChangePassword() {
    context.read<AuthorizationBloc>().add(
          OnChangePasswordEvent(
            _changePasswordController.text,
            widget.user.phoneNumber,
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
      body: BlocListener<AuthorizationBloc, AuthorizationState>(
        listener: (context, state) {
          if (state is AuthorizationPasswordChangedState) {
            context.router.pushNamed(AppRouterPath.login);

            UiRender.showSnackBar(context, 'Đã đổi mật khẩu thành công!');
          }
        },
        child: Container(
          padding: EdgeInsets.all(10.size),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _changePassFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đôỉ mật khẩu',
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
                          controller: _changePasswordController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Nhập mật khâủ mới của bạn...',
                            border: InputBorder.none,
                          ),
                          validator: _textFieldValidator,
                        ),
                      ),
                    ],
                  ),
                ),
                GradientElevatedButton(
                  text: 'Xác nhận đổi mật khẩu',
                  buttonHeight: 50.height,
                  onPress: _onPressConfirmChangePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
