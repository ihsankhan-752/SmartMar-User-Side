import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/app_text_controller.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/services/auth_services.dart';

import '../../constants/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_text_fields.dart';
import '../../widgets/logo_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: AppColors.grey,
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
              labelText: "E-Mail",
              controller: AppTextController.emailController,
              hintText: "test@gmail.com",
            ),
            SizedBox(height: 20),
            Consumer<LoadingController>(builder: (context, loadingController, child) {
              return loadingController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : PrimaryButton(
                      onTap: () {
                        AuthServices().resetPassword(context, AppTextController.emailController.text).whenComplete(() {
                          AppTextController().clear();
                        });
                      },
                      title: "Reset",
                    );
            }),
          ],
        ),
      ),
    );
  }
}
