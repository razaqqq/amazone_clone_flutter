import "package:flutter/material.dart";

class CostumSquareButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double dimension;
  const CostumSquareButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.color,
    required this.dimension,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: dimension,
        height: dimension,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
