import 'package:amazone_clone/providers/user_detail_provider.dart';
import 'package:amazone_clone/resources/cloud_firestore_methods.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:amazone_clone/utils/util.dart';
import 'package:amazone_clone/widgets/custom_main_button.dart';
import 'package:amazone_clone/widgets/loading_widget.dart';
import 'package:amazone_clone/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellsScreen extends StatefulWidget {
  const SellsScreen({super.key});

  @override
  State<SellsScreen> createState() => _SellsScreenState();
}

class _SellsScreenState extends State<SellsScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<int> keyForDiscount = [0, 80, 60, 40];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: !isLoading
            ? SingleChildScrollView(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              image == null
                                  ? Image.network(
                                      "https://cdn.vectorstock.com/i/preview-1x/32/12/default-avatar-profile-icon-vector-39013212.jpg",
                                      height: screenSize.height / 10,
                                    )
                                  : Image.memory(
                                      image!,
                                      height: screenSize.height / 10,
                                    ),
                              IconButton(
                                onPressed: () async {
                                  Uint8List? temp = await Utils().pickImage();
                                  if (temp != null) {
                                    setState(
                                      () {
                                        image = temp;
                                      },
                                    );
                                  }
                                },
                                icon: Icon(Icons.file_upload),
                              )
                            ],
                          ),
                          Container(
                            height: screenSize.height * 0.7,
                            width: screenSize.width * 0.7,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Item Details",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                TextFieldWidget(
                                    title: "Name",
                                    controller: nameController,
                                    obscureText: false,
                                    hintText: "Enter The Name of The Item"),
                                TextFieldWidget(
                                    title: "Cost",
                                    controller: costController,
                                    obscureText: false,
                                    hintText: "Enter The Cost of The Item"),
                                const Text(
                                  "Discount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                ListTile(
                                  title: Text("None"),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text("80%"),
                                  leading: Radio(
                                    value: 2,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text("60%"),
                                  leading: Radio(
                                    value: 3,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text("40%"),
                                  leading: Radio(
                                    value: 4,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomMainButton(
                            child: Text(
                              "Sell",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: yellowColor,
                            isLoading: isLoading,
                            onPress: () async {
                              String output = await CloudFiresStoreClass()
                                  .uploadProductToDatabase(
                                image: image,
                                productName: nameController.text,
                                rawCost: costController.text,
                                discount: keyForDiscount[selected - 1],
                                sellerName: Provider.of<UserDetailProvider>(
                                        context,
                                        listen: false)
                                    .userDetails!
                                    .name,
                                sellerUid:
                                    FirebaseAuth.instance.currentUser!.uid,
                              );
                              if (output == "success") {
                                Utils().showSnackBar(
                                    context: context,
                                    content: "Posted Product");
                              } else {
                                Utils().showSnackBar(
                                    context: context, content: output);
                              }
                            },
                          ),
                          CustomMainButton(
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.grey[200]!,
                            isLoading: false,
                            onPress: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const LoadingWidget(),
      ),
    );
  }
}
