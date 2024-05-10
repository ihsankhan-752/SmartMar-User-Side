import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/alert_dilog.dart';
import '../home/widgets/cart/bottom_card.dart';
import '../home/widgets/cart/item_information_card.dart';

class CartScreen extends StatefulWidget {
  final List pdtIds;
  const CartScreen({Key? key, required this.pdtIds}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: AppColors.mainColor,
        iconTheme: IconThemeData(
          color: AppColors.primaryWhite,
        ),
        actions: [
          IconButton(
              onPressed: () {
                customAlertDialogBox(
                  context: context,
                  title: "Wait !!",
                  content: "Do You Want To Clear Your Cart ?",
                  negativeBtnClicked: () {
                    Navigator.pop(context);
                  },
                  plusBtnClicked: () {
                    Navigator.of(context).pop();
                  },
                );
              },
              icon: Icon(Icons.delete_forever, color: Colors.red)),
        ],
        centerTitle: true,
        title: Text("My Cart", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
          itemCount: widget.pdtIds.length,
          itemBuilder: (context, index) {
            return ItemInformationCard(index: index, pdtIds: widget.pdtIds);
          },
        ),
      ),
      bottomSheet: BottomCard(
        pdtId: widget.pdtIds,
      ),
    );
  }
}
