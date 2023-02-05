import 'package:amazone_clone/model/product_modul.dart';
import 'package:amazone_clone/model/user_detail_model.dart';
import 'package:amazone_clone/providers/user_detail_provider.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:amazone_clone/widgets/cart_item_widget.dart';
import 'package:amazone_clone/widgets/custom_main_button.dart';
import 'package:amazone_clone/widgets/search_bar_widget.dart';
import 'package:amazone_clone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchbarWidget(isReadOnly: true, hasBackButton: false),
        body: Center(
          child: Column(
            children: [
              UserDetailBar(
                offset: 0,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("cart")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomMainButton(
                            color: yellowColor,
                            isLoading: true,
                            onPress: () {},
                            child: const Text(
                              'Loading',
                              style: TextStyle(color: Colors.black),
                            ));
                      } else {
                        return CustomMainButton(
                            color: yellowColor,
                            isLoading: false,
                            onPress: () async {
                              await CloudFiresStoreClass().buyAllItemInCart(
                                  userDetail: Provider.of<UserDetailProvider>(
                                          context,
                                          listen: false)
                                      .userDetails);
                              Utils().showSnackBar(
                                  context: context, content: "Done");
                            },
                            child: Text(
                              'Proceed To Buy (${snapshot.data!.docs.length}) items',
                              style: const TextStyle(color: Colors.black),
                            ));
                      }
                    },
                  )),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("cart")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ProductModul modul = ProductModul.getModelFromJson(
                            json: snapshot.data!.docs[index].data());
                        return CartItemWidget(product: modul);
                      },
                    );
                  }
                },
              ))
            ],
          ),
        ));
  }
}
