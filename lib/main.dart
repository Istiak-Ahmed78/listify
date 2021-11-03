import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/auth/welcome_screen.dart';
import 'package:listify/views/screens/home_screen.dart';
import 'package:listify/views/styles/k_colors.dart';
import 'package:listify/views/styles/k_theme.dart';

import 'controller/authentication/authentication_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listify',
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: KTheme.darkMode() ? KColors.spaceCadet : KColors.white,
        scaffoldBackgroundColor: KTheme.darkMode() ? KColors.spaceCadet : KColors.white,
        brightness: KTheme.darkMode() ? Brightness.dark : Brightness.light,
        primaryColor: KColors.primary,
        accentColor: KColors.accent,
        primarySwatch: KColors.createMaterialColor(KColors.primary),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(size: 16),
            actionsIconTheme: IconThemeData(size: 16),
            backgroundColor: KColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.poppins(
              color: KColors.charcoal,
              fontWeight: FontWeight.w500,
            )),
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final asyncUser = watch(authStateChangesProvider);
    return asyncUser.when(
      data: (user) => user != null ? HomeScreen() : WelcomeScreen(),
      loading: () => WelcomeScreen(),
      error: (e, stackTrace) => ErrorWidget(),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
