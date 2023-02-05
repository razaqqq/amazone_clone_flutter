import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/constants.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:flutter/material.dart';

class BannerAddWidget extends StatefulWidget {
  const BannerAddWidget({super.key});

  @override
  State<BannerAddWidget> createState() => _BannerAddWidgetState();
}

class _BannerAddWidgetState extends State<BannerAddWidget> {
  int currentAdd = 0;
  Size screenSize = Utils().getScreenSize();

  @override
  Widget build(BuildContext context) {
    double smallHeigt = screenSize.width / 5;
    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAdd == (largeAds.length - 1)) {
          currentAdd = -1;
        }
        setState(() {
          currentAdd++;
        });
      },
      child: Column(
        children: [
          // Image Width Gradient
          Stack(
            children: [
              Image.network(
                largeAds[currentAdd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        backgroundColor,
                        backgroundColor.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            color: backgroundColor,
            width: screenSize.width,
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getSmallAdsFromIndex(0, smallHeigt),
                getSmallAdsFromIndex(1, smallHeigt),
                getSmallAdsFromIndex(2, smallHeigt),
                getSmallAdsFromIndex(3, smallHeigt),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getSmallAdsFromIndex(int index, double height) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: height,
        height: 120,
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(smallAds[index]),
              const SizedBox(
                height: 5,
              ),
              Text(adItemNames[index]),
            ],
          ),
        ),
      ),
    );
  }
}
