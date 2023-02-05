import 'package:amazone_clone/model/order_request_model.dart';
import 'package:amazone_clone/model/product_modul.dart';
import 'package:amazone_clone/model/user_detail_model.dart';
import 'package:amazone_clone/providers/user_detail_provider.dart';
import 'package:amazone_clone/screens/sell_screen.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/constants.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:amazone_clone/widgets/account_screen_app_bar.dart';
import 'package:amazone_clone/widgets/custom_main_button.dart';
import 'package:amazone_clone/widgets/product_showcase_list_view.dart';
import 'package:amazone_clone/widgets/simple_product_widtget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Size screenSize = Utils().getScreenSize();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AccountScreenAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height - (kAppBarHeight / 3),
            width: screenSize.width,
            child: Column(
              children: [
                IntroductionWidgetAccountScreen(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CustomMainButton(
                    color: Colors.orange,
                    isLoading: false,
                    onPress: () {
                      FirebaseAuth.instance.signOut();
                      print("Log Out");
                    },
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CustomMainButton(
                      color: yellowColor,
                      isLoading: false,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SellsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sell",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('orders')
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        List<Widget> children = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          ProductModul model = ProductModul.getModelFromJson(
                              json: snapshot.data!.docs[i].data());
                          children
                              .add(SimpleProductWidget(productModul: model));
                        }
                        return ProductShowCaseListView(
                            title: 'Your Orders', children: children);
                      }
                    }),
                const Padding(
                  padding: const EdgeInsets.all(15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Order Request",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('orderRequest')
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
                              OrderRequestModel model =
                                  OrderRequestModel.getModelFromJson(
                                      json: snapshot.data!.docs[index].data());
                              return ListTile(
                                title: Text(
                                  "Order: ${model.orderName}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  "Address: ${model.buyersAddress}",
                                  style: TextStyle(color: Colors.black),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('orderRequest')
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  },
                                  icon: Icon(Icons.check),
                                ),
                              );
                            });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailModel? userDetailModel =
        Provider.of<UserDetailProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.00000001)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello, ",
                      style: TextStyle(color: Colors.grey[800], fontSize: 27),
                    ),
                    TextSpan(
                      text: userDetailModel?.name,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                right: 20,
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/236x/aa/72/dd/aa72dda46f8dc411ec7c693d07d5eb79.jpg"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
