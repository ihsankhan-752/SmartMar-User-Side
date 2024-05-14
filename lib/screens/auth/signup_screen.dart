import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/app_text_controller.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/screens/auth/widgets/auth_footer.dart';
import 'package:smart_mart_user_side/services/auth_services.dart';
import 'package:smart_mart_user_side/widgets/logo_widget.dart';

import '../../constants/colors.dart';
import '../../constants/navigations.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_text_fields.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordSecured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              LogoWidget(),
              Text(
                "Create New Account",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
              ),
              // ImageUploadingWidget(),
              SizedBox(height: 20),
              AuthTextInput(
                labelText: 'username',
                controller: AppTextController.usernameController,
                hintText: "test user",
              ),
              SizedBox(height: 15),
              AuthTextInput(
                labelText: 'E-Mail',
                controller: AppTextController.emailController,
                hintText: "test@gmail.com",
              ),
              SizedBox(height: 15),

              AuthTextInput(
                inputType: TextInputType.number,
                labelText: 'Contact',
                controller: AppTextController.contactController,
                hintText: "+92 1231231",
              ),
              SizedBox(height: 15),
              AuthTextInput(
                labelText: 'Password',
                isTextSecure: _isPasswordSecured,
                controller: AppTextController.passwordController,
                hintText: "******",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordSecured = !_isPasswordSecured;
                    });
                  },
                  child: Icon(_isPasswordSecured ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              SizedBox(height: 30),
              Consumer<LoadingController>(builder: (context, loadingController, child) {
                return loadingController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PrimaryButton(
                        onTap: () {
                          AuthServices()
                              .signUp(
                            context: context,
                            username: AppTextController.usernameController.text,
                            email: AppTextController.emailController.text,
                            contact: int.tryParse(AppTextController.contactController.text),
                            password: AppTextController.passwordController.text,
                          )
                              .whenComplete(() {
                            AppTextController().clear();
                          });
                        },
                        title: "Sign Up",
                      );
              }),
              SizedBox(height: 20),
              AuthFooter(
                onPressed: () {
                  navigateToPageWithPush(context, LoginScreen());
                },
                title: 'Already have an Account? ',
                screenName: 'Sign In',
              )
            ],
          ),
        ),
      ),
    );
  }
}
