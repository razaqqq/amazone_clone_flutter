import 'package:amazone_clone/screens/result_screen.dart';
import 'package:amazone_clone/screens/search_screen.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/constants.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:flutter/material.dart';

class SearchbarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  SearchbarWidget(
      {super.key, required this.isReadOnly, required this.hasBackButton})
      : preferredSize = const Size.fromHeight(kAppBarHeight);

  @override
  final Size preferredSize;

  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: Colors.grey, width: 1));

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Container(
      height: kAppBarHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: backgroundGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                )
              : Container(),
          SizedBox(
            width: screenSize.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: Offset(0, 5))
                ],
              ),
              child: TextField(
                onSubmitted: (String query) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultScreen(query: query)));
                },
                readOnly: isReadOnly,
                onTap: () {
                  if (isReadOnly) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  }
                },
                decoration: InputDecoration(
                    hintText: "Search Something in Amazon.com",
                    fillColor: Colors.white,
                    filled: true,
                    border: border,
                    focusedBorder: border),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.mic_none_outlined))
        ],
      ),
    );
  }
}
