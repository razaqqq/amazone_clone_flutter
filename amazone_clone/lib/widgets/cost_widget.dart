import 'dart:ui';

import "package:flutter/material.dart";

class CostWiddget extends StatelessWidget {
  final Color color;
  final double cost;
  const CostWiddget({
    super.key,
    required this.color,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "\$",
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontFeatures: [
              FontFeature.superscripts(),
            ],
          ),
        ),
        Text(
          cost.toInt().toString(),
          style: TextStyle(
              color: color, fontSize: 25, fontWeight: FontWeight.w800),
        ),
        Text(
          (cost - cost.toInt()).toString(),
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontFeatures: [
              FontFeature.superscripts(),
            ],
          ),
        ),
      ],
    );
  }
}
