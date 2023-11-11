import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/styles/colors.dart';

class ItemInformationCard extends StatefulWidget {
  final dynamic pdtIds;
  final int index;
  const ItemInformationCard({Key? key, this.pdtIds, required this.index}) : super(key: key);

  @override
  State<ItemInformationCard> createState() => _ItemInformationCardState();
}

class _ItemInformationCardState extends State<ItemInformationCard> {
  int quantity = 0;

  getProduct() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("mycart").doc(widget.pdtIds[widget.index]).get();

    setState(() {
      quantity = snap['quantity'];
    });
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 80,
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("products").doc(widget.pdtIds[widget.index]).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var pdtData = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        pdtData['productImages'][0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pdtData['pdtName'],
                        style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 07),
                      Text(
                        "\$ ${pdtData['price']}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.5), borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        quantity < 1
                            ? InkWell(
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection("mycart")
                                      .doc(widget.pdtIds[widget.index])
                                      .delete();
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                      .update({
                                    "cart": FieldValue.arrayRemove([widget.pdtIds[widget.index]]),
                                  });
                                  setState(() {});
                                },
                                child: Icon(Icons.delete_forever, size: 18, color: Colors.red[900]),
                              )
                            : InkWell(
                                onTap: () async {
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection("mycart")
                                        .doc(widget.pdtIds[widget.index])
                                        .update({
                                      "quantity": quantity--,
                                    });
                                  });
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Center(
                                    child: Icon(Icons.remove, size: 15, color: AppColors.primaryWhite),
                                  ),
                                ),
                              ),
                        SizedBox(width: 5),
                        StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("mycart")
                                .doc(widget.pdtIds[widget.index])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              var cartData = snapshot.data!.data() as Map<String, dynamic>;
                              return Text(
                                cartData['quantity'].toString(),
                                style: TextStyle(
                                  color: AppColors.primaryWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              FirebaseFirestore.instance.collection("mycart").doc(widget.pdtIds[widget.index]).update({
                                "quantity": quantity++,
                              });
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Icon(Icons.add, size: 15, color: AppColors.primaryWhite),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
