import 'package:amazone_clone/providers/user_detail_provider.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  changePage(int page) {
    pageController.jumpToPage(page);
    setState(
      () {
        currentPage = page;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CloudFiresStoreClass().getNameAndAddress();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailProvider>(context).getData();
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: PageView(
            controller: pageController,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey[400]!,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              indicator: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: activeCyanColor,
                    width: 4,
                  ),
                ),
              ),
              onTap: changePage,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home_outlined,
                    color: currentPage == 0 ? activeCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: currentPage == 1 ? activeCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: currentPage == 2 ? activeCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.menu,
                    color: currentPage == 3 ? activeCyanColor : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
