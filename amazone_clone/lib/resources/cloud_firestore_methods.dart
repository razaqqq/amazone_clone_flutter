import 'package:amazone_clone/model/order_request_model.dart';
import 'package:amazone_clone/model/product_modul.dart';
import 'package:amazone_clone/model/review_modul.dart';
import 'package:amazone_clone/model/user_detail_model.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:amazone_clone/widgets/simple_product_widtget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CloudFiresStoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNameAndAddressToDatabase({required UserDetailModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailModel userDetailModel = UserDetailModel.getModelFromJson(
      snapshot.data() as dynamic,
    );

    return userDetailModel;
  }

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = "Something Goes Wrong";

    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(
          image: image,
          uid: uid,
        );
        double cost = double.parse(rawCost);
        cost = (cost * (discount / 100));
        ProductModul productModul = ProductModul(
            url: url,
            productName: productName,
            cost: cost,
            discount: discount,
            uid: uid,
            sellerName: sellerName,
            sellerUid: sellerUid,
            rating: 5,
            noOfRating: 0);
        await firebaseFirestore.collection("products").doc(uid).set(
              productModul.getJson(),
            );
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please Fill Up Your Field";
    }

    return output;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      DocumentSnapshot docSnap = snapshot.docs[i];
      ProductModul modul =
          ProductModul.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(SimpleProductWidget(productModul: modul));
    }
    return children;
  }

  Future uploadReviewToDatabase(
      {required String productUid, required ReviewModul model}) async {
    await firebaseFirestore
        .collection('products')
        .doc(productUid)
        .collection('reviews')
        .add(
          model.getJson(),
        );
    await changeAverageRating(productUid: productUid, reviewModul: model);
  }

  Future addProductToCard({required ProductModul productModul}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(productModul.uid)
        .set(productModul.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(uid)
        .delete();
  }

  Future buyAllItemInCart({required UserDetailModel userDetail}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModul modul =
          ProductModul.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: modul, userDetail: userDetail);
      await deleteProductFromCart(uid: modul.uid);
    }
  }

  Future addProductToOrders(
      {required ProductModul model,
      required UserDetailModel userDetail}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('orders')
        .add(model.getJson());
    await sendOrderRequest(modul: model, userDetail: userDetail);
  }

  Future sendOrderRequest(
      {required ProductModul modul,
      required UserDetailModel userDetail}) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        orderName: modul.productName, buyersAddress: userDetail.address);
    await firebaseFirestore
        .collection('users')
        .doc(modul.sellerUid)
        .collection('orderRequest')
        .add(orderRequestModel.getJson());
  }

  Future changeAverageRating(
      {required String productUid, required ReviewModul reviewModul}) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection('products').doc(productUid).get();
    ProductModul modul =
        ProductModul.getModelFromJson(json: snapshot.data() as dynamic);
    int currenRating = modul.rating;
    int newRating = ((currenRating + reviewModul.rating) / 2).toInt();
    await firebaseFirestore.collection('products').doc(productUid).update({
      'rating': newRating,
    });
  }
}
