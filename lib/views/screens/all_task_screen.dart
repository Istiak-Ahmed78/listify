import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/task_controller.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_app_bar.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:listify/views/widgets/task_card.dart';

import 'create_task_screen.dart';

class AllTasksScreen extends ConsumerWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: KAppBar(
          titleText: "All Tasks",
          onTap: () => Navigation.pop(context),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: KSize.getHeight(20)),
                Expanded(
                  child: StreamBuilder(
                    builder: (contect, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Text('Data');
                              //   return TaskCard(
                              //     backgroundColor: KColors.accent,
                              //     borderOutline: false,
                              // todo: ,
                              // );
                            });
                      } else
                        return ErrorWidget('Data is not avaible');
                    },
                  ),
                ),
                //    pendingTasksStream.when(
                //       loading: () => Container(),
                //       error: (e, stackTrace) => ErrorWidget(stackTrace),
                //       data: (snapshot) {
                // return ListView.builder(
                //     physics: BouncingScrollPhysics(),
                //     itemCount: snapshot.length,
                //     itemBuilder: (context, index) {
                //       return ProviderScope(
                //         overrides: [
                //           taskProvider
                //               .overrideWithValue(snapshot[index]),
                //         ],
                //         child: TaskCard(
                //           backgroundColor: KColors.accent,
                //           borderOutline: false,
                //         ),
                //       );
                //     });
                //       }),
                // ),
                SizedBox(height: KSize.getHeight(20)),

                /// Create Task / Project
                Padding(
                  padding: EdgeInsets.only(
                      bottom: Platform.isAndroid ? KSize.getHeight(50) : 0),
                  child: KFilledButton.iconText(
                      icon: Icons.add,
                      buttonText: 'Create New Task',
                      onPressed: () {
                        CreateTaskScreen().push(context);
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
