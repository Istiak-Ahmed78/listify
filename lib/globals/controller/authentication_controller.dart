import 'package:firebase_auth/firebase_auth.dart';
import 'package:listify/services/firebase.dart';
import 'package:get/get.dart';

class FirebaseAuthController extends GetxController {
  Rx<User?> user = null.obs;
  RxBool isLoding = false.obs;
  final authInstance = FirebaseAuth.instance;

  static FirebaseAuthController get to => Get.find();
  @override
  void onReady() {
    user = Rx<User?>(authInstance.currentUser);
    user.bindStream(authInstance.authStateChanges());
    ever(user, authStateChangeStatus);
  }

  Future<void> signIn({required String email, password}) async {
    try {
      isLoding.value = true;
      update();
      User? _user = (await authInstance.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      authStateChangeStatus(_user);
      isLoding.value = false;
      update();
    } on FirebaseAuthException catch (e) {}
  }

  Future<void> signInWithGoogle() async {
    isLoding.value = true;
    update();
    try {
      User? _user = (await authInstance.loginWithGoogle())?.user;
      isLoding.value = false;
      authStateChangeStatus(_user);
    } on FirebaseAuthException catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> signUp({required String email, password}) async {
    try {
      isLoding.value = true;
      update();
      User? _user = (await authInstance.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      authStateChangeStatus(_user);
      isLoding.value = false;
      update();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  void authStateChangeStatus(User? rawUser) {
    if (rawUser != null) {
      user = Rx<User>(rawUser);
      refresh();
      print('User name: ${rawUser.displayName}');
      update();
    } else
      print('No user found');
    return;
  }

  Future<void> signOut() async {
    authInstance.signOut();
    authStateChangeStatus(null);
    update();
  }
}
