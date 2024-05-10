import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/screens/auth/signup_screen.dart';

import '../../constants/colors.dart';
import '../../constants/navigations.dart';
import '../../controllers/loading_controller.dart';
import '../../services/auth_services.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_text_fields.dart';
import '../../widgets/logo_widget.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loadingController = Provider.of<LoadingController>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 140),
                LogoWidget(),
                SizedBox(height: 20),
                Text(
                  "Welcome Back!",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Login to your account using email",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 20),
                AuthTextInput(
                  labelText: "E-Mail",
                  controller: emailController,
                  hintText: "test@gmail.com",
                ),
                SizedBox(height: 20),
                AuthTextInput(
                  labelText: "Password",
                  isTextSecure: true,
                  controller: passwordController,
                  hintText: "******",
                  isSuffixReq: true,
                  suffixIcon: Icon(
                    Icons.visibility_off,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    navigateToPageWithPush(context, ForgotPasswordScreen());
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                loadingController.isLoading
                    ? Center(child: CircularProgressIndicator(color: AppColors.orange))
                    : PrimaryButton(
                        onTap: () async {
                          await AuthServices().signIn(
                            context,
                            emailController.text,
                            passwordController.text,
                          );
                        },
                        title: "Sign In",
                      ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => navigateToPageWithPush(context, SignUpScreen()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
