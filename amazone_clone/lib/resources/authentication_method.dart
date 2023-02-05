import 'package:amazone_clone/model/user_detail_model.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethod {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFiresStoreClass cloudFiresStoreClass = CloudFiresStoreClass();

  Future<String> signUpUser(
      {required String name,
      required String address,
      required String email,
      required String password}) async {
    name.trim();
    address.trim();
    email.trim();
    password.trim();
    String output = "Something Went Wrong";
    if (name != "" && address != "" && email != "" && password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetailModel user = UserDetailModel(name: name, address: address);
        await cloudFiresStoreClass.uploadNameAndAddressToDatabase(user: user);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "please Fill Up All The Field";
    }
    return output;
  }

  Future<String> signIpUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();

    String output = "Something Went Wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "please Fill Up All The Field";
    }

    return output;
  }
}
