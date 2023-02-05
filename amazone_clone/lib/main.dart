import 'package:amazone_clone/layout/screen_layout.dart';
import 'package:amazone_clone/model/product_modul.dart';
import 'package:amazone_clone/providers/user_detail_provider.dart';
import 'package:amazone_clone/screens/product_screen.dart';
import 'package:amazone_clone/screens/result_screen.dart';
import 'package:amazone_clone/screens/sell_screen.dart';
import 'package:amazone_clone/screens/sign_in_screen.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAfgSNsXiCpixS8eY9jMakqH0YFFRMakUQ",
            authDomain: "clone-flutter-f6ea5.firebaseapp.com",
            projectId: "clone-flutter-f6ea5",
            storageBucket: "clone-flutter-f6ea5.appspot.com",
            messagingSenderId: "974904225538",
            appId: "1:974904225538:web:12dee3c6225fdd2fe9dc1b"));
  } else {
    await Firebase.initializeApp();
  }
  return runApp(const AmazoneClone());
}

class AmazoneClone extends StatelessWidget {
  const AmazoneClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserDetailProvider(),
        ),
      ],
      child: MaterialApp(
        title: "Amazone Clone",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else if (user.hasData) {
              return const ScreenLayout();
            } else {
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
