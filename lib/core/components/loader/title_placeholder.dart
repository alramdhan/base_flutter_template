import 'package:flutter/material.dart';

class TitlePlaceholder extends StatelessWidget {
  const TitlePlaceholder({
    super.key,
    this.words,
    this.width
  });

  final int? words;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ((words ?? 1) * 50),
      height: 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40)
      ),
    );
  }
}