import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/image_controller.dart';

import '../../constants/colors.dart';

class ImageUploadingWidget extends StatelessWidget {
  const ImageUploadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        imageController.selectedImage == null
            ? CircleAvatar(
                radius: 45,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.person, size: 45, color: AppColors.primaryWhite),
              )
            : CircleAvatar(
                radius: 45,
                backgroundColor: Colors.purple,
                backgroundImage: FileImage(imageController.selectedImage!),
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
                              await imageController.uploadPhoto(ImageSource.gallery);
                            },
                            child: Text("Gallery"),
                          ),
                          Divider(),
                          SimpleDialogOption(
                            onPressed: () async {
                              Navigator.of(context).pop();

                              await imageController.uploadPhoto(ImageSource.camera);
                            },
                            child: Text("Camera"),
                          ),
                          Divider(),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.camera_alt, size: 15, color: AppColors.primaryWhite),
            )),
          ),
        )
      ],
    );
  }
}
