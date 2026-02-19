import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/routing/app_routes.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                      SvgPicture.asset(AppIcons.profile),
                    ],
                  ),
                  SizedBox(height: size.height * 0.05),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: size.height * 0.02,
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, AppRoutes.todoDetail),
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
                                          'Design UI App $index',
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize:
                                            size.width * 0.04,
                                            fontWeight:
                                            FontWeight.w600,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          AppIcons.clock,
                                          width: size.width * 0.05,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: size.height * 0.01),
                                    Text(
                                      'Make To-DO UI Design for NTI.',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize:
                                        size.width * 0.035,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'Created at 1 Sept 2021',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize:
                                        size.width * 0.03,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                SvgPicture.asset(AppIcons.plus),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
