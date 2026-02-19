import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_icons.dart';
import 'package:to_do_app/presentation/widgets/custom_button.dart';
import 'package:to_do_app/presentation/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmController = TextEditingController();

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
                const SizedBox(width: 4),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),

                SvgPicture.asset(AppIcons.toDoList, height: size.height * 0.2),

                SizedBox(height: size.height * 0.08),

                CustomTextField(
                  hint: "Current Password",
                  isPassword: true,
                  controller: oldPasswordController,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  hint: "New Password",
                  isPassword: true,
                  controller: newPasswordController,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  hint: "Confirm Password",
                  isPassword: true,
                  controller: confirmController,
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(height: 30),

                CustomButton(
                  text: "CHANGE PASSWORD",
                  onTap: () async {
                    final oldPass = oldPasswordController.text.trim();
                    final newPass = newPasswordController.text.trim();
                    final confirm = confirmController.text.trim();

                    if (oldPass.isEmpty || newPass.isEmpty || confirm.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fill all fields")),
                      );
                      return;
                    }

                    if (newPass != confirm) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords not match")),
                      );
                      return;
                    }

                    try {
                      final user = FirebaseAuth.instance.currentUser;

                      if (user == null) return;

                      final email = user.email;

                      if (email == null) return;

                      final cred = EmailAuthProvider.credential(
                        email: email,
                        password: oldPass,
                      );

                      await user.reauthenticateWithCredential(cred);

                      await user.updatePassword(newPass);

                      if (context.mounted) {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password updated successfully"),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      String message = "Something went wrong";

                      if (e.code == 'wrong-password') {
                        message = "Wrong current password";
                      } else if (e.code == 'weak-password') {
                        message = "Password is too weak";
                      } else if (e.code == 'requires-recent-login') {
                        message = "Please login again";
                      }

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
