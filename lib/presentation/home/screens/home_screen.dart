import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/routing/app_routes.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_icons.dart';
import 'package:to_do_app/core/utils/date_formatter.dart';
import 'package:to_do_app/data/home/model/to_do_model.dart';
import 'package:to_do_app/presentation/home/cubit/to_do_cubit.dart';
import 'package:to_do_app/presentation/home/widgets/add_todo_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().listenToTodos();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
                vertical: size.height * 0.02,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(AppIcons.logoIcon),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.profile);
                        },
                        child: SvgPicture.asset(AppIcons.profile),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.05),
                  Expanded(
                    child: BlocBuilder<TodoCubit, List<TodoModel>>(
                      builder: (context, todos) {
                        if (todos.isEmpty) {
                          return Center(child: Text("No tasks yet"));
                        }
                        return ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: size.height * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.todoDetail,
                                  arguments: todo,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: size.height * 0.16,
                                  decoration: BoxDecoration(
                                    color: AppColors.pink,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.04,
                                      vertical: size.height * 0.01,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              todo.title,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: size.width * 0.04,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SvgPicture.asset(
                                              AppIcons.clock,
                                              width: size.width * 0.05,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text(
                                          todo.description,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: size.width * 0.035,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Created at ${formatDate(todo.createdAt)}",
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: size.width * 0.03,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.05,
            right: size.width * 0.06,
            child: Column(
              children: [
                SvgPicture.asset(AppIcons.circle),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => AddTodoBottomSheet(),
                    );
                  },
                  child: SvgPicture.asset(AppIcons.plus),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
