import 'package:amazone_clone/model/product_modul.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:amazone_clone/screens/product_screen.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:amazone_clone/widgets/custom_single_rounded_button.dart';
import 'package:amazone_clone/widgets/custom_square_butoon.dart';
import 'package:amazone_clone/widgets/product_information_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModul product;
  const CartItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(20),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          productModul: product,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: screenSize.width / 4,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.network(product.url),
                    ),
                  ),
                ),
                ProductInformationWidget(
                    productname: product.productName,
                    cost: product.cost,
                    sellerName: product.sellerName),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CostumSquareButton(
                    onPressed: () {},
                    color: Colors.grey[300]!,
                    dimension: 50,
                    child: const Icon(Icons.remove)),
                CostumSquareButton(
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 50,
                    child: const Text(
                      "99",
                      style: TextStyle(color: activeCyanColor),
                    )),
                CostumSquareButton(
                    onPressed: () async {
                      await CloudFiresStoreClass().addProductToCard(
                          productModul: ProductModul(
                              url: product.url,
                              productName: product.productName,
                              cost: product.cost,
                              discount: product.discount,
                              uid: Utils().getUid(),
                              sellerName: product.sellerName,
                              sellerUid: product.sellerUid,
                              rating: product.rating,
                              noOfRating: product.noOfRating));
                    },
                    color: Colors.grey[300]!,
                    dimension: 50,
                    child: const Icon(Icons.add)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSingleRoundedButton(
                          onPressed: () async {
                            CloudFiresStoreClass()
                                .deleteProductFromCart(uid: product.uid);
                          },
                          text: "Delete"),
                      const SizedBox(
                        width: 7,
                      ),
                      CustomSingleRoundedButton(
                          onPressed: () {}, text: "Save for later"),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See More Like This",
                        style: TextStyle(color: activeCyanColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
