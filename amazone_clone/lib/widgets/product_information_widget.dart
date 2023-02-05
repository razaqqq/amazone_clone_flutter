import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:amazone_clone/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productname;
  final double cost;
  final String sellerName;

  const ProductInformationWidget(
      {super.key,
      required this.productname,
      required this.cost,
      required this.sellerName});

  @override
  Widget build(BuildContext context) {
    SizedBox space = const SizedBox(
      height: 7,
    );

    Size screenSize = Utils().getScreenSize();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        width: screenSize.width / 2,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                productname,
                maxLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    letterSpacing: 0.5,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            space,
            Align(
              alignment: Alignment.centerLeft,
              child: CostWiddget(color: Colors.black, cost: cost),
            ),
            space,
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Sold By",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: sellerName,
                      style: TextStyle(color: activeCyanColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            space,
          ],
        ),
      ),
    );
  }
}
