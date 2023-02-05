import 'package:amazone_clone/model/user_detail_model.dart';
import 'package:amazone_clone/providers/user_detail_provider.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/constants.dart';
import 'package:amazone_clone/utils/util.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class UserDetailBar extends StatelessWidget {
  final double offset;

  const UserDetailBar({
    super.key,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    UserDetailModel? userDetailModel =
        Provider.of<UserDetailProvider>(context).userDetails;
    return Positioned(
      top: -offset / 5,
      child: Container(
        height: kAppBarHeight / 2,
        width: screenSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: lightBackgroundaGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  "Deliver to ${userDetailModel!.name} - ${userDetailModel!.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
