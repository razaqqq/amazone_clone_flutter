import 'package:amazone_clone/model/user_detail_model.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:amazone_clone/screens/categories_list_view_bar.dart';
import 'package:amazone_clone/utils/constants.dart';
import 'package:amazone_clone/widgets/banner_add_widget.dart';
import 'package:amazone_clone/widgets/loading_widget.dart';
import 'package:amazone_clone/widgets/product_showcase_list_view.dart';
import 'package:amazone_clone/widgets/search_bar_widget.dart';
import 'package:amazone_clone/widgets/simple_product_widtget.dart';
import 'package:amazone_clone/widgets/user_details_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  double offset = 0;
  List<Widget>? discount80;
  List<Widget>? discount60;
  List<Widget>? discount40;
  List<Widget>? discount0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    scrollController.addListener(
      () {
        setState(
          () {
            offset = scrollController.position.pixels;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  void getData() async {
    List<Widget> temp80 =
        await CloudFiresStoreClass().getProductFromDiscount(80);
    List<Widget> temp60 =
        await CloudFiresStoreClass().getProductFromDiscount(60);
    List<Widget> temp40 =
        await CloudFiresStoreClass().getProductFromDiscount(40);
    List<Widget> temp0 = await CloudFiresStoreClass().getProductFromDiscount(0);

    setState(() {
      discount80 = temp80;
      discount60 = temp60;
      discount40 = temp40;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchbarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: discount80 != null &&
              discount60 != null &&
              discount40 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: kAppBarHeight / 2,
                      ),
                      const CategoriesHorizontalListView(),
                      const BannerAddWidget(),
                      ProductShowCaseListView(
                          title: "Upto 80% off", children: discount80!),
                      ProductShowCaseListView(
                          title: "Upto 60% off", children: discount60!),
                      ProductShowCaseListView(
                          title: "Upto 40% off", children: discount40!),
                      ProductShowCaseListView(
                          title: "Free", children: discount0!),
                    ],
                  ),
                ),
                UserDetailBar(
                  offset: offset,
                ),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
