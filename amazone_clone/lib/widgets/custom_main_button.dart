import 'package:amazone_clone/utils/util.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPress;
  const CustomMainButton({
    Key? key,
    required this.child,
    required this.color,
    required this.isLoading,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color, fixedSize: Size(screenSize.width * 0.5, 40)),
      onPressed: onPress,
      child: !isLoading
          ? child
          : const Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
            child: AspectRatio(
              aspectRatio: 1/1,
              // A widget that shows progress along a circle.
              child: CircularProgressIndicator(
                  color: Colors.white,
                ),
            ),
          ),
    );
  }
}
