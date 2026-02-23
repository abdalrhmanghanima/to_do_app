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
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is Authenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.homeScreen,
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                Center(child: SvgPicture.asset(AppIcons.toDoList)),

                SizedBox(height: MediaQuery.of(context).size.height * 0.12),

                /// ================= EMAIL FIELD =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomTextField(
                    hint: 'Email',
                    isPassword: false,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),

                const SizedBox(height: 16),

                /// ================= PASSWORD FIELD =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomTextField(
                    hint: 'Password',
                    isPassword: true,
                    controller: passController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= EMAIL LOGIN BUTTON =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                    onTap: () {
                      if (emailController.text.isEmpty ||
                          passController.text.isEmpty) {
                        showError(
                            context, "Email and password required");
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

                const SizedBox(height: 25),

                /// ================= ADDED: Divider =================
                /// ✨ جديد: خط فاصل بين العادي وجوجل
                Row(
                  children: [
                    const Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR",
                        style: TextStyle(color: AppColors.gray),
                      ),
                    ),
                    const Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                const SizedBox(height: 25),

                /// ================= ADDED: GOOGLE SIGN IN BUTTON =================
                /// ✨ جديد: زرار تسجيل الدخول بجوجل
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: state is AuthLoading
                      ? const SizedBox()
                      : CustomButton(
                    onTap: () {
                      /// ✨ جديد: استدعاء Google Sign In من الكيوبيت
                      context.read<AuthCubit>().signInWithGoogle();
                    },
                    text: 'Sign in with Google',
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= SIGN UP =================
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