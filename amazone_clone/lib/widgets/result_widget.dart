import 'package:amazone_clone/model/product_modul.dart';
import 'package:amazone_clone/screens/product_screen.dart';
import 'package:amazone_clone/screens/rating_star_widget.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:amazone_clone/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final ProductModul product;
  const ResultWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModul: product),
          ),
        );
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, top: 10, bottom: 10, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 3,
              height: 180,
              child: Image.network(
                product.url,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Text(
                product.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                SizedBox(
                    width: screenSize.width / 5,
                    child: FittedBox(
                        child: RatingStarWidget(rating: product.rating))),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    product.rating.toString(),
                    style: TextStyle(color: activeCyanColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWiddget(
                  color: const Color.fromARGB(255, 147, 33, 25),
                  cost: product.cost,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
