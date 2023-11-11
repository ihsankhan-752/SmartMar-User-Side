import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/styles/colors.dart';
import '../../utils/styles/text_styles.dart';

class ChatScreen extends StatefulWidget {
  final String? supplierId;
  const ChatScreen({Key? key, this.supplierId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  String enteredMsg = '';
  String? docId;
  String customerId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    if (customerId.hashCode > widget.supplierId.hashCode) {
      docId = customerId + widget.supplierId!;
    } else {
      docId = widget.supplierId! + customerId;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Direct Chat',
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chatbg.jpeg'),
            colorFilter: ColorFilter.mode(AppColors.primaryBlack.withOpacity(0.3), BlendMode.srcATop),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: double.infinity,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("chat")
                      .doc(docId)
                      .collection("messages")
                      .orderBy("createdAt", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No Previous Chat Found \nwith This Supplier",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          return Row(
                            mainAxisAlignment: data['uid'] == FirebaseAuth.instance.currentUser!.uid
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: data['uid'] == FirebaseAuth.instance.currentUser!.uid
                                      ? AppColors.primaryColor
                                      : AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    data['msg'],
                                    style: TextStyle(
                                      color: AppColors.primaryWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.mainColor,
                ),
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 05),
                    child: TextField(
                      style: TextStyle(
                        color: AppColors.primaryWhite,
                      ),
                      controller: controller,
                      onChanged: (v) {
                        setState(() {
                          enteredMsg = v;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message....",
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            try {
                              if ((await FirebaseFirestore.instance.collection("chat").doc(docId).get()).exists) {
                                FirebaseFirestore.instance.collection("chat").doc(docId).update({
                                  "msg": enteredMsg,
                                  // "ids": [widget.supplierId, customerId],
                                });
                              } else {
                                FirebaseFirestore.instance.collection("chat").doc(docId).set({
                                  "msg": enteredMsg,
                                  "ids": [widget.supplierId, customerId],
                                });
                              }
                              DocumentSnapshot user =
                                  await FirebaseFirestore.instance.collection("users").doc(customerId).get();
                              FirebaseFirestore.instance.collection("chat").doc(docId).collection("messages").add({
                                "createdAt": DateTime.now(),
                                "uid": FirebaseAuth.instance.currentUser!.uid,
                                // "customerId": customerId,
                                // "supplierId": widget.supplierId,
                                "msg": enteredMsg,
                                "customerName": user['userName'],
                                "customerImage": user['image'],
                                "customerPhone": user['phone'],
                              }).then((value) async {
                                controller.clear();
                                FocusScope.of(context).unfocus();
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          icon: Icon(FontAwesomeIcons.paperPlane, size: 25, color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
