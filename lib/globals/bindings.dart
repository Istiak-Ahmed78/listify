import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:listify/globals/controller/authentication_controller.dart';
import 'package:listify/globals/controller/task_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseAuthController());
    Get.put(TasksController());
  }
}
