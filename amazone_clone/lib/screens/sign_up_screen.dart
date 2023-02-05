import 'dart:math';

import 'package:amazone_clone/resources/authentication_method.dart';
import 'package:amazone_clone/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../utils/util.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController addressControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  AuthenticationMethod authenticationMethod = AuthenticationMethod();
  Size screenSize = Utils().getScreenSize();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameControler.dispose();
    emailControler.dispose();
    addressControler.dispose();
    passwordControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                        height: screenSize.height * 0.85,
                        width: screenSize.width * 0.8,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sign-Up",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 33,
                              ),
                            ),
                            TextFieldWidget(
                              title: "name",
                              controller: nameControler,
                              obscureText: false,
                              hintText: "Input Your Name",
                            ),
                            TextFieldWidget(
                              title: "Address",
                              controller: addressControler,
                              obscureText: false,
                              hintText: "Input Your Address",
                            ),
                            TextFieldWidget(
                              title: "Email",
                              controller: emailControler,
                              obscureText: false,
                              hintText: "Input Your Email",
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
                                  setState(
                                    () {
                                      isLoading = true;
                                    },
                                  );
                                  String output =
                                      await authenticationMethod.signUpUser(
                                    name: nameControler.text.toString(),
                                    address: addressControler.text.toString(),
                                    email: emailControler.text.toString(),
                                    password: passwordControler.text.toString(),
                                  );
                                  setState(
                                    () {
                                      isLoading = false;
                                    },
                                  );
                                  print(output);

                                  if (output == "success") {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignInScreen(),
                                      ),
                                    );
                                  } else {
                                    Utils().showSnackBar(
                                        context: context, content: output);
                                  }
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      letterSpacing: 0.6, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                CustomMainButton(
                  color: Colors.grey[400]!,
                  isLoading: false,
                  onPress: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignInScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Back",
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
