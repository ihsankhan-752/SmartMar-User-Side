import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_mart_user_side/lib/views/auth/sign_in_screen.dart';

import '../../custom_widgets/buttons.dart';
import '../../custom_widgets/custom_msg.dart';
import '../../custom_widgets/custom_text_fields.dart';
import '../../custom_widgets/logo_widget.dart';
import '../../services/auth_services.dart';
import '../../utils/functions/functions.dart';
import '../../utils/styles/colors.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  File? selectedImage;
  ImagePicker _picker = ImagePicker();
  Future<void> uploadImage(ImageSource source) async {
    XFile? uploadImage = await _picker.pickImage(source: source);
    if (uploadImage != null) {
      setState(() {
        selectedImage = File(uploadImage.path);
      });
    }
  }

  void signUp() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty ||
        selectedImage == null) {
      showCustomMsg(context: context, msg: "Some Filled Are Missing");
    } else {
      setState(() {
        isLoading = true;
      });
      String res = await AuthServices().signUp(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        selectedImage: selectedImage,
      );
      setState(() {
        isLoading = false;
        emailController.clear();
        passwordController.clear();
        usernameController.clear();
        selectedImage = null;
      });
      if (res == 'success') {
        showCustomMsg(context: context, msg: "User is Created Successfully");
      } else {
        showCustomMsg(context: context, msg: "User is Not Created Yet");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
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
                SizedBox(height: 100),
                LogoWidget(),
                SizedBox(height: 20),
                Text(
                  "Create New Account",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryWhite,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Look like you don't have an account",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 30),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    selectedImage == null
                        ? CircleAvatar(
                            radius: 45,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(Icons.person, size: 45),
                          )
                        : CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.purple,
                            backgroundImage: FileImage(selectedImage!),
                          ),
                    Positioned(
                      bottom: 0,
                      right: -5,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grey,
                        ),
                        child: Center(
                            child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return SimpleDialog(
                                    children: [
                                      SimpleDialogOption(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            await uploadImage(ImageSource.gallery);
                                          },
                                          child: Text("Gallery")),
                                      Divider(),
                                      SimpleDialogOption(
                                          onPressed: () async {
                                            Navigator.of(context).pop();

                                            await uploadImage(ImageSource.camera);
                                          },
                                          child: Text("Camera")),
                                      Divider(),
                                      SimpleDialogOption(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel")),
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.camera_alt, size: 15, color: AppColors.primaryWhite),
                        )),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                AuthTextInput(
                  controller: usernameController,
                  hintText: "username",
                ),
                SizedBox(height: 15),
                AuthTextInput(
                  controller: emailController,
                  hintText: "Email",
                ),
                SizedBox(height: 15),
                AuthTextInput(
                  isTextSecure: true,
                  controller: passwordController,
                  hintText: "Password",
                  isSuffixReq: true,
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                SizedBox(height: 30),
                isLoading
                    ? Center(child: CircularProgressIndicator(color: AppColors.orange))
                    : PrimaryButton(
                        onTap: () {
                          signUp();
                        },
                        title: "Sign Up",
                      ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => navigateToPageWithPush(context, LoginScreen()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
