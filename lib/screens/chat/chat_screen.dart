import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/models/message_model.dart';
import 'package:smart_mart_user_side/services/chat_services.dart';
import 'package:smart_mart_user_side/widgets/custom_text_fields.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Direct Chat',
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
            color: AppColors.primaryBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                        MessageModel messageModel = MessageModel.fromMap(snapshot.data!.docs[index]);
                        return Row(
                          mainAxisAlignment: messageModel.senderId == FirebaseAuth.instance.currentUser!.uid
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.6,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                decoration: BoxDecoration(
                                  color: messageModel.senderId == FirebaseAuth.instance.currentUser!.uid
                                      ? AppColors.grey
                                      : AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    messageModel.msg!,
                                    style: TextStyle(
                                      color: AppColors.primaryWhite,
                                    ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: AuthTextInput(
                controller: controller,
                hintText: 'Type Something....',
                suffixIcon: Consumer<LoadingController>(builder: (context, loadingController, child) {
                  return IconButton(
                    onPressed: () {
                      ChatServices()
                          .sendMessages(
                        context: context,
                        msg: controller.text,
                        docId: docId!,
                        otherUserId: widget.supplierId!,
                      )
                          .then((value) {
                        controller.clear();
                        FocusScope.of(context).unfocus();
                      });
                    },
                    icon: loadingController.isLoading
                        ? CircularProgressIndicator()
                        : Icon(FontAwesomeIcons.paperPlane, size: 25, color: AppColors.primaryColor),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
