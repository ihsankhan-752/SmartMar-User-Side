import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mart_user_side/lib/custom_widgets/custom_msg.dart';

import '../../custom_widgets/buttons.dart';
import '../../custom_widgets/custom_text_fields.dart';
import '../../custom_widgets/logo_widget.dart';
import '../../utils/styles/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  void resetPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      setState(() {
        isLoading = false;
        emailController.clear();
      });
      Navigator.pop(context);
      showCustomMsg(context: context, msg: "Reset your Password and Login Again");
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      showCustomMsg(context: context, msg: e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(),
            SizedBox(height: 20),
            Text(
              "Forgot Your Password?",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryWhite,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "use your email to update your password",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: 20),
            AuthTextInput(
              controller: emailController,
              hintText: "Email",
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator(color: AppColors.orange))
                : PrimaryButton(
                    onTap: () {
                      if (emailController.text.isEmpty) {
                        showCustomMsg(context: context, msg: "Email must be filled");
                      } else {
                        resetPassword();
                      }
                    },
                    title: "Reset",
                  ),
          ],
        ),
      ),
    );
  }
}
