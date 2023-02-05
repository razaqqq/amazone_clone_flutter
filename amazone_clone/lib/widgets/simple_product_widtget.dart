import 'package:amazone_clone/model/product_modul.dart';
import 'package:amazone_clone/screens/product_screen.dart';
import "package:flutter/material.dart";

class SimpleProductWidget extends StatelessWidget {
  final ProductModul productModul;
  const SimpleProductWidget({
    super.key,
    required this.productModul,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModul: productModul),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(productModul.url),
          ),
        ),
      ),
    );
  }
}
