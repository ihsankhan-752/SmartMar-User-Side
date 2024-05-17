import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_mart_user_side/constants/colors.dart';
import 'package:smart_mart_user_side/constants/text_styles.dart';
import 'package:smart_mart_user_side/screens/chat/chat_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/seller_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Chat List", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryBlack)),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 15),
          //   child: SearchTextInput(
          //     onChange: (v) {
          //       setState(() {});
          //     },
          //     controller: _searchController,
          //   ),
          // ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .where('ids', arrayContains: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "No User Found!",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var chatData = snapshot.data!.docs[index];
                    String otherUserId = chatData['ids'].firstWhere((id) => id != FirebaseAuth.instance.currentUser!.uid);

                    return StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('sellers').doc(otherUserId).snapshots(),
                      builder: (context, snap) {
                        if (!snap.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        SellerModel sellerModel = SellerModel.fromDocument(snap.data!);

                        if (_searchController.text.isEmpty ||
                            sellerModel.sellerName!.toLowerCase().contains(_searchController.text)) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.to(() => ChatScreen(supplierId: sellerModel.uid!));
                                },
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: Text(sellerModel.sellerName![0].toUpperCase(), style: TextStyle(fontSize: 20)),
                                ),
                                title: Text(
                                  sellerModel.sellerName!,
                                  style: AppTextStyles().H2.copyWith(fontSize: 14),
                                ),
                                subtitle: Text(chatData['msg'], style: TextStyle(fontSize: 12)),
                                trailing: Text(
                                  timeago.format(chatData['createdAt'].toDate()),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(height: 0.1, thickness: 0.4),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
