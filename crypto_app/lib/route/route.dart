import 'package:flutter/material.dart';

// Define Routes
import 'package:crypto_app/views/home.dart';
import 'package:crypto_app/views/login.dart';
import 'package:crypto_app/views/settings.dart';

// Route Names
const String loginPage = 'login';
const String homePage = 'home';
const String settingsPage = 'settings';

// Controling the page flow with pre-setup routes
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    default:
      throw ('This route name does not exit');
  }
}
