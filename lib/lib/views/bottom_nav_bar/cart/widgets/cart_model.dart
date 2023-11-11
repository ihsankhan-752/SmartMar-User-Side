import 'package:flutter/material.dart';

import '../../../../utils/styles/colors.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 5.0,
      color: AppColors.primaryWhite,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        leading: Container(
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red, width: 1),
          ),
        ),
        title: Text("Product Name", style: TextStyle(fontSize: 14)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Women/Men/kid",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 05),
            Container(
              height: 25,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.grey.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.add, size: 15),
                  Text("1"),
                  Icon(Icons.remove, size: 15),
                ],
              ),
            )
          ],
        ),
        trailing: Text(
          "\$15",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
