import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/constants/text_styles.dart';
import 'package:smart_mart_user_side/controllers/image_controller.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/controllers/user_controller.dart';
import 'package:smart_mart_user_side/services/user_profile_services.dart';
import 'package:smart_mart_user_side/widgets/buttons.dart';
import 'package:smart_mart_user_side/widgets/custom_text_fields.dart';

import '../../../constants/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context).userModel;
    final imageController = Provider.of<ImageController>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: AppTextStyles().H2.copyWith(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (imageController.selectedImage == null && userController!.image == "")
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.mainColor,
                        child: Icon(Icons.person, size: 45, color: AppColors.primaryWhite),
                      )
                    else if (imageController.selectedImage == null && userController!.image != "")
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.mainColor,
                        backgroundImage: NetworkImage(userController.image!),
                      )
                    else
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.mainColor,
                        backgroundImage: FileImage(File(imageController.selectedImage!.path)),
                      ),
                    Positioned(
                      bottom: 0,
                      right: -10,
                      child: GestureDetector(
                        onTap: () {
                          imageController.uploadPhoto(ImageSource.gallery);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                          child: Center(
                            child: Icon(Icons.camera_alt, size: 20, color: AppColors.primaryWhite),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text("Profile Information", style: AppTextStyles().H2.copyWith(fontSize: 16)),
              SizedBox(height: 20),
              Text("Name", style: AppTextStyles().H2.copyWith(fontSize: 14)),
              SizedBox(height: 10),
              AuthTextInput(
                controller: _nameController,
                hintText: userController!.username!,
              ),
              SizedBox(height: 20),
              Text("Contact", style: AppTextStyles().H2.copyWith(fontSize: 14)),
              SizedBox(height: 10),
              AuthTextInput(
                inputType: TextInputType.number,
                controller: _phoneController,
                hintText: userController.phone.toString(),
              ),
              SizedBox(height: 50),
              Consumer<LoadingController>(builder: (context, loadingController, child) {
                return loadingController.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : PrimaryButton(
                        onTap: () {
                          UserProfileServices.updateProfileInformation(
                            context: context,
                            newName: _nameController.text.isEmpty ? userController.username : _nameController.text,
                            phone: int.tryParse(_phoneController.text),
                            image: imageController.selectedImage,
                          );
                          imageController.removeUploadPhoto();
                        },
                        title: "Save Changes",
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
