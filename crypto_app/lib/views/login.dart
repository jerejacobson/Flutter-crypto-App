import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:crypto_app/views/home.dart';

//Login static credentials to "show off" login capabilites.
const users = {
  'jerejacobson@protonmail.com': 'Password!',
  'jeremiah@direbyte.com': 'Password123!',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const inputBorder = BorderRadius.vertical(
    bottom: Radius.circular(10.0),
    top: Radius.circular(20.0),
  );
  Duration get loginTime => const Duration(milliseconds: 2250);

// Would implement auth sign-in and pin access for repeate logins.
  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

//User Signup shard
  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

//recover Password Shard
  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "null";
    });
  }

//Build Widget for login.
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Crypto App',
      theme: LoginTheme(
        primaryColor: const Color(0xFF221F33),
        accentColor: Colors.white,
        errorColor: const Color(0xffF24236),
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        buttonTheme: const LoginButtonTheme(
          splashColor: Color(0xFF473F73),
          backgroundColor: Color(0xFF473F73),
          highlightColor: Colors.white,
          elevation: 9.0,
          highlightElevation: 6.0,
        ),
      ),
      logo: const AssetImage('assets/images/transparent_logomark.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
