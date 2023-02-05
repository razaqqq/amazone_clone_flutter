import 'package:amazone_clone/resources/authentication_method.dart';
import 'package:amazone_clone/screens/sign_up_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../utils/util.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  AuthenticationMethod authenticationMethod = AuthenticationMethod();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailControler.dispose();
    passwordControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  amazonLogo,
                  height: screenSize.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenSize.height * 0.6,
                      width: screenSize.width * 0.8,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sign-In",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 33),
                          ),
                          TextFieldWidget(
                            title: "Email",
                            controller: emailControler,
                            obscureText: false,
                            hintText: "Input Your Image",
                          ),
                          TextFieldWidget(
                            title: "Password",
                            controller: passwordControler,
                            obscureText: true,
                            hintText: "Input Your Password",
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomMainButton(
                              color: yellowColor,
                              isLoading: isLoading,
                              onPress: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                Future.delayed(Duration(seconds: 1));
                                String output =
                                    await authenticationMethod.signIpUser(
                                  email: emailControler.text,
                                  password: passwordControler.text,
                                );
                                setState(
                                  () {
                                    isLoading = false;
                                  },
                                );
                                if (output == "success") {
                                } else {
                                  Utils().showSnackBar(
                                      context: context, content: output);
                                }
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    letterSpacing: 0.6, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "New to Amazon",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomMainButton(
                  color: Colors.grey[400]!,
                  isLoading: false,
                  onPress: () {
                    print("Anjing");
                    FirebaseDatabase.instance
                        .ref("User")
                        .set({"name": "HelloWorld"});
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Create an Amazon Account",
                    style: TextStyle(letterSpacing: 0.6, color: Colors.black),
                    textAlign: TextAlign.center,
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
