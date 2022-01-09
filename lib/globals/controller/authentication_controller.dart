import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthController extends GetxController {
  Rx<User?> user = null.obs;
  RxBool isLoding = false.obs;
  final authInstance = FirebaseAuth.instance;

  static FirebaseAuthController get to => Get.find();

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

  void authStateChangeStatus(User? user) {
    if (user != null) {
      user = user;
      update();
    } else
      return;
  }

  Future<void> signOut() async {
    authInstance.signOut();
  }
}
