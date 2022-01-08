import 'package:flutter/material.dart';
import 'package:listify/controller/authentication_controller.dart';
import 'package:listify/controller/task_controller.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/details/widget/sub_task_card.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_app_bar.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widget/task_details_card.dart';

class DetailsScreen extends StatefulWidget {
  final Todo todo;
  const DetailsScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        titleText: "Task Details",
        onTap: () => Navigation.pop(context),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: KSize.getHeight(40)),
              // TaskDetailsCard(),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: widget.todo.subTask?.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text('Sub task'),
                    );
                    // return SubTaskCard(key: UniqueKey(), index: index);
                  }),
              KTextButton.iconText(
                  buttonText: 'Add Task',
                  assetIcon: KAssets.add,
                  onPressed: () {
                    // TasksController.to.update(FirebaseAuthController.to.user.value.uid);
                    // TasksController.to.updateSubTask();
                  }),
              SizedBox(height: KSize.getHeight(90)),
              KFilledButton(
                buttonText: "Complete Task",
                onPressed: () async {
                  await TasksController.to
                      .completeTask(FirebaseAuthController.to.user.value!.uid);
                  Navigation.pop(context);
                },
              ),
              SizedBox(height: KSize.getHeight(22)),
              KOutlinedButton(
                buttonText: "Delete Task",
                textStyle: KTextStyle.buttonText(fontWeight: FontWeight.w500)
                    .copyWith(color: KColors.red.withOpacity(0.8)),
                borderColor: KColors.red.withOpacity(0.8),
                onPressed: () async {
                  await TasksController.to
                      .removeTodo(FirebaseAuthController.to.user.value!.uid);
                  Navigation.pop(context);
                },
              ),
              SizedBox(height: KSize.getHeight(90)),
            ],
          ),
        ),
      ),
    );
  }
}
