import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/widgets/custom_text_fields.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../controllers/loading_controller.dart';
import '../../../../controllers/visibility_controller.dart';
import '../../../../services/auth_services.dart';
import '../../../../widgets/buttons.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Change Password", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryBlack)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Center(child: Icon(Icons.lock_person_outlined, size: 60)),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Change your password for\nmore security!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Consumer<VisibilityController>(
                    builder: (context, passwordVisibilityController, child) {
                      return AuthTextInput(
                        isTextSecure: passwordVisibilityController.isOldPasswordVisible,
                        hintText: "Old Password",
                        controller: _oldPasswordController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            passwordVisibilityController.toggleOldPasswordVisibility();
                          },
                          child: Icon(
                            passwordVisibilityController.isOldPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<VisibilityController>(
                    builder: (context, confirmPasswordVisibilityController, child) {
                      return AuthTextInput(
                        isTextSecure: confirmPasswordVisibilityController.isPasswordVisible,
                        hintText: "New Password",
                        controller: _newPasswordController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            confirmPasswordVisibilityController.togglePasswordVisibility();
                          },
                          child: Icon(
                            confirmPasswordVisibilityController.isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<VisibilityController>(
                    builder: (context, confirmPasswordVisibilityController, child) {
                      return AuthTextInput(
                        isTextSecure: confirmPasswordVisibilityController.isConfirmPasswordVisible,
                        hintText: "Confirm",
                        controller: _confirmPasswordController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            confirmPasswordVisibilityController.toggleConfirmPasswordVisibility();
                          },
                          child: Icon(
                            confirmPasswordVisibilityController.isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  Consumer<LoadingController>(builder: (context, loadingController, child) {
                    return loadingController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PrimaryButton(
                            onTap: () async {
                              AuthServices.changeUserPasswordCreative(
                                context: context,
                                oldPassword: _oldPasswordController.text,
                                newPassword: _newPasswordController.text,
                                confirmPassword: _confirmPasswordController.text,
                              );
                              setState(() {
                                _oldPasswordController.clear();
                                _newPasswordController.clear();
                                _confirmPasswordController.clear();
                              });
                            },
                            title: "Change Password",
                          );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
