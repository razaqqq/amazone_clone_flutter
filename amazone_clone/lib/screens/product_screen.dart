import 'package:amazone_clone/model/product_modul.dart';
import 'package:amazone_clone/model/review_modul.dart';
import 'package:amazone_clone/model/user_detail_model.dart';
import 'package:amazone_clone/providers/user_detail_provider.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:amazone_clone/screens/rating_star_widget.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/constants.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:amazone_clone/widgets/cost_widget.dart';
import 'package:amazone_clone/widgets/custom_main_button.dart';
import 'package:amazone_clone/widgets/custom_single_rounded_button.dart';
import 'package:amazone_clone/widgets/review_dialog.dart';
import 'package:amazone_clone/widgets/review_widget.dart';
import 'package:amazone_clone/widgets/search_bar_widget.dart';
import 'package:amazone_clone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final ProductModul productModul;
  const ProductScreen({super.key, required this.productModul});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    const SizedBox space15 = SizedBox(
      height: 15,
    );
    return SafeArea(
      child: Scaffold(
        appBar: SearchbarWidget(isReadOnly: true, hasBackButton: true),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: kAppBarHeight / 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.productModul.productName,
                                  style: const TextStyle(
                                      color: activeCyanColor, fontSize: 15),
                                ),
                              ),
                              Text(widget.productModul.productName),
                            ],
                          ),
                          RatingStarWidget(rating: widget.productModul.rating),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: screenSize.height / 3,
                        child: FittedBox(
                          child: Image.network(widget.productModul.url),
                        ),
                      ),
                    ),
                    space15,
                    CostWiddget(
                      color: Colors.black,
                      cost: widget.productModul.cost,
                    ),
                    space15,
                    CustomMainButton(
                      color: Colors.orange,
                      isLoading: false,
                      onPress: () async {
                        await CloudFiresStoreClass().addProductToOrders(
                            model: widget.productModul,
                            userDetail: Provider.of<UserDetailProvider>(context,
                                    listen: false)
                                .userDetails);
                        Utils().showSnackBar(context: context, content: "Done");
                      },
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    space15,
                    CustomMainButton(
                      color: yellowColor,
                      isLoading: false,
                      onPress: () async {
                        await CloudFiresStoreClass().addProductToCard(
                            productModul: widget.productModul);
                        Utils().showSnackBar(
                            context: context, content: "Added to Cart");
                      },
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    space15,
                    CustomSingleRoundedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ReviewDialog(
                            productUid: widget.productModul.uid,
                          ),
                        );
                      },
                      text: "Add Review For This Product",
                    ),
                    SizedBox(
                      height: screenSize.height,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("products")
                              .doc(widget.productModul.uid)
                              .collection("reviews")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  ReviewModul reviewModul =
                                      ReviewModul.getModulFromJson(
                                    json: snapshot.data!.docs[index].data(),
                                  );
                                  return ReviewWidget(reviewModul: reviewModul);
                                },
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            const UserDetailBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
