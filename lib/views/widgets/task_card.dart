import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listify/controller/task_controller.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/details/details_screen.dart';
import 'package:listify/views/styles/styles.dart';

class TaskCard extends StatelessWidget {
  final Animation<double>? animation;
  final Color backgroundColor;
  final bool borderOutline;
  final Todo todo;

  TaskCard(
      {this.animation,
      required this.todo,
      this.backgroundColor = KColors.white,
      this.borderOutline = true});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TasksController>(builder: (taskController) {
      return GestureDetector(
        onTap: () {
          if (!(todo.isCompleted ?? false)) {
            DetailsScreen(
              todo: todo,
            ).push(context);
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: KSize.getHeight(19)),
          child: Dismissible(
            key: UniqueKey(),
            background: Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete),
              color: KColors.lightRed,
            ),
            onDismissed: (direction) async {
              taskController.removeTodo(todo.uid);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: KSize.getHeight(15)),
              decoration: BoxDecoration(
                color: backgroundColor,
                border:
                    borderOutline ? Border.all(color: KColors.charcoal) : null,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: KSize.getWidth(22)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: KSize.getWidth(22)),
                                      child: Icon(
                                        Icons.brightness_1_sharp,
                                        color: todo.priority == "Low"
                                            ? Colors.green
                                            : todo.priority == "Medium"
                                                ? Colors.orange
                                                : Colors.red,
                                        size: KSize.getWidth(16),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        todo.title ?? 'Unvaible',
                                        style: KTextStyle.bodyText2().copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                if (todo.description != null)
                                  if (todo.description!.length > 0)
                                    Column(
                                      children: [
                                        SizedBox(height: KSize.getHeight(5)),
                                        Text(
                                          todo.description ?? 'Unavailable',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: KTextStyle.bodyText3(),
                                        ),
                                        SizedBox(height: KSize.getHeight(10)),
                                      ],
                                    ),
                                Text(todo.dateTime ?? 'Unavailable',
                                    style: KTextStyle.bodyText2().copyWith(
                                      color: KColors.charcoal.withOpacity(0.70),
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!(todo.isCompleted ?? false))
                        await taskController.completeTask(todo.uid);
                      else
                        await taskController.undoCompleteTask(todo.uid);
                    },
                    child: Container(
                      margin: EdgeInsets.all(KSize.getWidth(36)),
                      child: Icon(
                        todo.isCompleted ?? false
                            ? Icons.brightness_1
                            : Icons.brightness_1_outlined,
                        color: KColors.primary,
                        size: KSize.getWidth(24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
