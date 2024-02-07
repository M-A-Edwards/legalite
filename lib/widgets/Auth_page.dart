import 'package:flutter/material.dart';
import 'package:legalite/widgets/llogin_widget.dart';
import 'package:legalite/widgets/login_widget.dart';
import 'package:legalite/widgets/lsignup_widget.dart';
import 'package:legalite/widgets/signup_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  bool isClient = true;
  @override
  Widget build(BuildContext context) {
    return isLogin
        ? (isClient
            ? LoginWidget(onClickedSignUp: toggle, onClickedLLogin: taggle)
            : LLoginWidget(onClickedLSignUp: toggle, onClickedSignIn: taggle))
        : (isClient
            ? SignUpWidget(
                onClickedSignIn: toggle,
                onClickedLSignUp: taggle,
              )
            : LSignUpWidget(onClickedSignUp: taggle, onClickedLLogin: toggle));
  }

  void toggle() => setState(() => isLogin = !isLogin);
  void taggle() => setState(() => isClient = !isClient);
}
