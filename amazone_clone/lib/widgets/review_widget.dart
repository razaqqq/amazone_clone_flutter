import 'package:amazone_clone/model/review_modul.dart';
import 'package:amazone_clone/screens/rating_star_widget.dart';
import 'package:amazone_clone/utils/constants.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModul reviewModul;
  const ReviewWidget({super.key, required this.reviewModul});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reviewModul.senderName),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: screenSize.width / 4,
                  child: FittedBox(
                    child: RatingStarWidget(
                      rating: reviewModul.rating,
                    ),
                  ),
                ),
                Text(
                  keyOfRating[reviewModul.rating - 1],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Text(
            reviewModul.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
