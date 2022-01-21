import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:listify/globals/controller/authentication_controller.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/auth/sign_up_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:listify/views/widgets/k_textfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ref.listen(firebaseAuthProvider, (_, state) {
    //   if (state is FirebaseAuthSuccessState) {
    //     HomeScreen().pushAndRemoveUntil(context);
    //   } else if (state is FirebaseAuthErrorState) {
    //     snackBar(context, title: state.message, backgroundColor: KColors.charcoal);
    //   }
    // });

    return GetBuilder<FirebaseAuthController>(builder: (authController) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: KSize.getHeight(332)),
                Container(
                  width: KSize.getWidth(315),
                  child: Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: KTextStyle.headLine3,
                  ),
                ),
                SizedBox(height: KSize.getHeight(63)),
                KTextFormField(
                  hintText: 'Your email address',
                  controller: emailController,
                ),
                SizedBox(height: KSize.getHeight(37)),
                KTextFormField(
                  hintText: 'Password',
                  controller: passwordController,
                  isPasswordField: true,
                ),
                SizedBox(height: KSize.getHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot your password?',
                      style: KTextStyle.bodyText2()
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(height: KSize.getHeight(61)),
                KFilledButton(
                  buttonText:
                      authController.isLoding.value ? 'Please wait' : 'Login',
                  buttonColor: authController.isLoding.value
                      ? KColors.spaceCadet
                      : KColors.primary,
                  onPressed: () {
                    // if (!(authState is FirebaseAuthLoadingState)) {
                    //   if (emailController.text.trim().isNotEmpty && passwordController.text.isNotEmpty) {
                    //     hideKeyboard(context);
                    //     ref.read(firebaseAuthProvider.notifier).signIn(
                    //           email: emailController.text,
                    //           password: passwordController.text,
                    //         );
                    //   } else {

                    //   }
                    // }
                  },
                ),
                SizedBox(height: KSize.getHeight(66)),
                Text(
                  "Or",
                  textAlign: TextAlign.center,
                  style: KTextStyle.bodyText1(),
                ),
                SizedBox(height: KSize.getHeight(72)),
                KOutlinedButton.iconText(
                  buttonText: 'Login with Google',
                  assetIcon: KAssets.google,
                  onPressed: () {},
                ),
                SizedBox(height: KSize.getHeight(37)),
                KOutlinedButton.iconText(
                  buttonText: 'Login with Facebook',
                  assetIcon: KAssets.facebook,
                  onPressed: () {},
                ),
                SizedBox(height: KSize.getHeight(131)),
                Text(
                  "Don't have an account?",
                  textAlign: TextAlign.center,
                  style: KTextStyle.bodyText3(),
                ),
                SizedBox(height: KSize.getHeight(6)),
                KTextButton(
                    buttonText: "Create account",
                    onPressed: () {
                      SignupScreen().pushReplacement(context);
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
