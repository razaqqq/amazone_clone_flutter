import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:flutter/material.dart';

class ProductShowCaseListView extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductShowCaseListView(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double height = screenSize.height / 4;
    double titleHeight = 25;
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: height,
      width: screenSize.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Show More",
                    style: const TextStyle(color: activeCyanColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenSize.width,
              height: height - (titleHeight + 15),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: children,
              ),
            )
          ],
        ),
      ),
    );
  }
}
