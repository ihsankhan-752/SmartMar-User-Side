import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/services/rating_services.dart';

class ShowRatingDialogBox extends StatelessWidget {
  final String productId;
  final String orderId;
  const ShowRatingDialogBox({super.key, required this.productId, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingController>(builder: (context, loadingController, child) {
      return RatingDialog(
        force: true,
        initialRating: 1.0,
        image: loadingController.isLoading
            ? Center(
                child: Text(
                "Review Submitting Please Wait...",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ))
            : SizedBox(),
        title: Text(
          'Rating Product',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        message: Text(
          'Its time for let the seller know about their product',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
        submitButtonText: 'Submit',
        commentHint: 'Write Something.....',
        onCancelled: () => print('cancelled'),
        onSubmitted: (response) async {
          RatingServices().addRating(
              context: context,
              orderId: orderId,
              productId: productId,
              comment: response.comment,
              rating: response.rating.toDouble());
        },
      );
    });
  }
}
