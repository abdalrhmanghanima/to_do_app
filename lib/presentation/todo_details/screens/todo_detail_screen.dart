import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_icons.dart';
import 'package:to_do_app/core/utils/date_formatter.dart';
import 'package:to_do_app/data/home/model/to_do_model.dart';
import 'package:to_do_app/presentation/home/cubit/to_do_cubit.dart';
import 'package:to_do_app/presentation/todo_details/widgets/delete_todo_bottom_sheet.dart';
import 'package:to_do_app/presentation/todo_details/widgets/edit_todo_bottom_sheet.dart';

class TodoDetailScreen extends StatelessWidget {
  const TodoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final todo = ModalRoute.of(context)!.settings.arguments as TodoModel;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .doc(todo.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>?;

        if (data == null) {
          Future.microtask(() {
            Navigator.pop(context);
          });

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final updatedTodo = TodoModel.fromJson(data, todo.id);

        return Scaffold(
          backgroundColor: AppColors.primary,
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.gray,
                size: size.width * 0.05,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: size.width * 0.04),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.clockDark,
                      width: size.width * 0.05,
                    ),
                    SizedBox(width: size.width * 0.03),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) =>
                              EditTodoBottomSheet(todo: updatedTodo),
                        );
                      },
                      child: SvgPicture.asset(
                        AppIcons.edit,
                        width: size.width * 0.05,
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          barrierColor: Colors.black.withOpacity(0.4),
                          backgroundColor: Colors.transparent,
                          builder: (sheetContext) => DeleteTodoBottomSheet(
                            onDelete: () async {
                              await context.read<TodoCubit>().deleteTodo(
                                updatedTodo.id,
                              );
                              Navigator.pop(sheetContext);
                            },
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        AppIcons.trash,
                        width: size.width * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
                vertical: size.height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    updatedTodo.title,
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        updatedTodo.description,
                        style: TextStyle(fontSize: size.width * 0.04),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          "Created at ${formatDate(updatedTodo.createdAt)}",
                          style: TextStyle(fontSize: size.width * 0.035),
                        ),
                      ),

                      SizedBox(height: size.height * 0.01),

                      if (updatedTodo.deadline != null)
                        Center(
                          child: Text(
                            "Deadline ${formatDate(updatedTodo.deadline!)}",
                            style: TextStyle(
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.w600,
                              color:
                                  updatedTodo.deadline!.isBefore(DateTime.now())
                                  ? Colors.redAccent
                                  : Colors.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
