import 'package:amazone_clone/model/user_detail_model.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:flutter/material.dart';

class UserDetailProvider with ChangeNotifier {
  late UserDetailModel userDetails;
  UserDetailProvider() {
    userDetails = UserDetailModel(
      name: "loading",
      address: "Loading",
    );
  }

  Future getData() async {
    userDetails = await CloudFiresStoreClass().getNameAndAddress();
    notifyListeners();
  }
}
