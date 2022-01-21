import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listify/globals/controller/authentication_controller.dart';
import 'package:listify/views/screens/home_screen.dart';
import 'package:listify/views/screens/startup/welcome_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<FirebaseAuthController>(builder: (authController) {
      return authController.user.value != null ? HomeScreen() : WelcomeScreen();
    });
  }
}
