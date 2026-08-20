import 'package:flutter/material.dart';
import 'package:login_biometrics_app/core/widgets/minimalist_checkbox.dart';

class RememberMeWidget extends StatefulWidget {
  const RememberMeWidget({
    super.key,
    required this.onChanged
  });

  final ValueChanged<bool?> onChanged;

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  bool isChecked = false;

  void _handleTap(bool? value) {
    if(value == null) {
      return;
    }

    setState(() {
      isChecked = value;
    });

    widget.onChanged(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleTap(!isChecked);
      },
      child: Row(
        mainAxisAlignment: .end,
        children: [
          const Text("Ingat Saya",
            style: TextStyle(
              fontSize: 16
            ),
          ),
          MinimalistCheckbox(
            value: isChecked,
            onChanged: _handleTap,
          ),
        ],
      ),
    );
  }
}