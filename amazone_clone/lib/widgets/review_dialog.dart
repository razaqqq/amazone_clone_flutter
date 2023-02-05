import 'package:amazone_clone/model/review_modul.dart';
import 'package:amazone_clone/model/user_detail_model.dart';
import 'package:amazone_clone/providers/user_detail_provider.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({super.key, required this.productUid});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      // your app's name?
      title: const Text(
        'Type Review for This Product!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      submitButtonText: 'Send',
      commentHint: 'Type Here',
      onSubmitted: (RatingDialogResponse response) async {
        CloudFiresStoreClass().uploadReviewToDatabase(
          productUid: productUid,
          model: ReviewModul(
            senderName: Provider.of<UserDetailProvider>(context, listen: false)
                .userDetails!
                .name,
            description: response.comment,
            rating: response.rating.toInt(),
          ),
        );
      },
    );
  }
}
