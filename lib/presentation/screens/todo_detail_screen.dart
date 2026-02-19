import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_icons.dart';
import 'package:to_do_app/presentation/widgets/delete_todo_bottom_sheet.dart';
import 'package:to_do_app/presentation/widgets/edit_todo_bottom_sheet.dart';

class TodoDetailScreen extends StatelessWidget {
  const TodoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                SvgPicture.asset(AppIcons.clockDark, width: size.width * 0.05),
                SizedBox(width: size.width * 0.03),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const EditTodoBottomSheet(),
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
                      builder: (_) => DeleteTodoBottomSheet(
                        onDelete: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Todo deleted successfully"),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                            ),
                          );
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
                "Design UI App",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Make To-DO UI Design for NTI .",
                        style: TextStyle(fontSize: size.width * 0.04),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Text(
                        "Design List :",
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      ...[
                        "login",
                        "register",
                        "home",
                        "detail",
                        "add",
                        "edit",
                        "delete",
                        "profile",
                      ].map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.008),
                          child: Text(
                            "• $item",
                            style: TextStyle(fontSize: size.width * 0.038),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Center(
                child: Text(
                  "Created at 1 Sept 2021",
                  style: TextStyle(fontSize: size.width * 0.035),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
