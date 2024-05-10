import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../widgets/custom_msg.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  Future<void> uploadImage(ImageSource source) async {
    var pickedImage = await _picker.pickImage(source: source);
    setState(() {
      selectedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 5.0,
        centerTitle: true,
        title: Text("Edit Profile", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              "Update Image",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  selectedImage == null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.person, size: 45, color: AppColors.primaryWhite),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(File(selectedImage!.path)),
                        ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            uploadImage(ImageSource.gallery);
                          },
                          child: selectedImage == null
                              ? Icon(Icons.camera_alt, size: 15, color: AppColors.primaryWhite)
                              : InkWell(
                                  onTap: () async {
                                    FirebaseStorage fs = FirebaseStorage.instance;
                                    Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
                                    await ref.putFile(File(selectedImage!.path));
                                    String url = await ref.getDownloadURL();
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .update({
                                      "image": url,
                                    });
                                    setState(() {
                                      selectedImage = null;
                                    });
                                  },
                                  child: Icon(Icons.check, size: 15, color: AppColors.primaryWhite),
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //todo codeRefactoring is Remain here
            SizedBox(height: 30),
            Text(
              "Update Email",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data!.data() as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.email, color: AppColors.primaryColor),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                color: AppColors.primaryWhite,
                              ),
                            ),
                            Text(
                              data['email'],
                              style: TextStyle(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.edit, size: 20, color: AppColors.grey),
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: AppColors.mainColor,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "Enter your email",
                                              style: TextStyle(
                                                color: AppColors.primaryWhite,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextFormField(
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                  hintText: "new email",
                                                  hintStyle: TextStyle(
                                                    color: AppColors.grey,
                                                  )),
                                              autofocus: true,
                                              style: TextStyle(
                                                color: AppColors.primaryWhite,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    var user = FirebaseAuth.instance.currentUser;
                                                    if (user != null) {
                                                      try {
                                                        var user = FirebaseAuth.instance.currentUser;
                                                        await user!.updateEmail(emailController.text);
                                                        await FirebaseFirestore.instance
                                                            .collection("users")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .update({
                                                          "email": emailController.text,
                                                        });
                                                        setState(() {
                                                          emailController.clear();
                                                        });
                                                        showCustomMsg(context: context, msg: "email updated Successfully");
                                                      } on FirebaseAuthException catch (e) {
                                                        showCustomMsg(context: context, msg: e.message);
                                                      }
                                                    }
                                                  },
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                        )
                      ],
                    ),
                  );
                }),

            SizedBox(height: 30),
            Text(
              "Update UserName",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data!.data() as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: AppColors.primaryColor),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "username",
                              style: TextStyle(color: AppColors.primaryWhite),
                            ),
                            Text(
                              data['userName'],
                              style: TextStyle(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.edit, size: 20, color: AppColors.grey),
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: AppColors.mainColor,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "Enter new username",
                                              style: TextStyle(
                                                color: AppColors.primaryWhite,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextFormField(
                                              controller: usernameController,
                                              decoration: InputDecoration(
                                                  hintText: "new name",
                                                  hintStyle: TextStyle(
                                                    color: AppColors.grey,
                                                  )),
                                              autofocus: true,
                                              style: TextStyle(
                                                color: AppColors.primaryWhite,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    try {
                                                      await FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update({
                                                        "userName": usernameController.text,
                                                      });
                                                      setState(() {
                                                        usernameController.clear();
                                                      });
                                                      showCustomMsg(context: context, msg: "username updated Successfully");
                                                    } on FirebaseException catch (e) {
                                                      showCustomMsg(context: context, msg: e.message);
                                                    }
                                                  },
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                        )
                      ],
                    ),
                  );
                }),
            SizedBox(height: 30),
            Text(
              "Update Contact",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data!.data() as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.phone, color: AppColors.primaryColor),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "phone",
                              style: TextStyle(
                                color: AppColors.primaryWhite,
                              ),
                            ),
                            Text(
                              data['phone'],
                              style: TextStyle(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.edit, size: 20, color: AppColors.grey),
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: AppColors.mainColor,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "Enter new username",
                                              style: TextStyle(
                                                color: AppColors.primaryWhite,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextFormField(
                                              controller: contactController,
                                              decoration: InputDecoration(
                                                  hintText: "contact",
                                                  hintStyle: TextStyle(
                                                    color: AppColors.grey,
                                                  )),
                                              autofocus: true,
                                              style: TextStyle(
                                                color: AppColors.primaryWhite,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    try {
                                                      await FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update({
                                                        "phone": contactController.text,
                                                      });
                                                      setState(() {
                                                        contactController.clear();
                                                      });
                                                      showCustomMsg(context: context, msg: "username updated Successfully");
                                                    } on FirebaseException catch (e) {
                                                      showCustomMsg(context: context, msg: e.message);
                                                    }
                                                  },
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
