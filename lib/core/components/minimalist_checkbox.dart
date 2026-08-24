import 'package:flutter/material.dart';

class MinimalistCheckbox extends StatefulWidget {
  const MinimalistCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 40.0,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final double size;
  // final Color activeColor;
  // final Color inactiveColor;
  // final Color checkColor;
  // final double borderRadius;

  @override
  State<MinimalistCheckbox> createState() => _MinimalistCheckboxState();
}

class _MinimalistCheckboxState extends State<MinimalistCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox.adaptive(
        value: widget.value,
        onChanged: widget.onChanged
      ),
    );
  }
}