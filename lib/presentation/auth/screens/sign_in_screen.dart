import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/routing/app_routes.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_icons.dart';
import 'package:to_do_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:to_do_app/presentation/auth/cubit/auth_state.dart';
import 'package:to_do_app/presentation/auth/screens/sign_up_screen.dart';
import 'package:to_do_app/presentation/widgets/custom_button.dart';
import 'package:to_do_app/presentation/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              children: [
                Text(
                  'Eng',
                  style: TextStyle(
                    color: AppColors.pink,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColors.pink,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is Authenticated) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.homeScreen, (route) => false);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Center(child: SvgPicture.asset(AppIcons.toDoList)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                Padding(
                  padding: const EdgeInsets.only(right: 18, left: 18),
                  child: CustomTextField(
                    hint: 'Email',
                    isPassword: false,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(right: 18, left: 18),
                  child: CustomTextField(
                    hint: 'Password',
                    isPassword: true,
                    controller: passController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          onTap: () {
                            if (emailController.text.isEmpty ||
                                passController.text.isEmpty) {
                              showError(context, "Email and password required");
                              return;
                            }
                            context.read<AuthCubit>().login(
                              emailController.text.trim(),
                              passController.text.trim(),
                            );
                          },
                          text: 'SIGN IN',
                        ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.signUp);
                      },
                      child: Text(
                        " Sign up",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
