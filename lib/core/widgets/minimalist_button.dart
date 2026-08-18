import 'package:flutter/material.dart';

enum MinimalButtonStyle {
  primary,
  secondary,
  outlined,
  text
}

class MinimalistButton extends StatelessWidget {
  const MinimalistButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = MinimalButtonStyle.primary,
    required this.isLoading,
    this.icon,
    this.width = double.infinity,
    this.height
  });

  final String label;
  final VoidCallback? onPressed;
  final MinimalButtonStyle type;
  final bool isLoading;
  final IconData? icon;
  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final action = isLoading ? null : onPressed;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: width,
        height: height,
        child: _buildButtonBody(context, primaryColor, action)
      ),
    );
  }

  Widget _buildButtonBody(BuildContext context, Color primaryColor, VoidCallback? onPressed) {
    if(type == .outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
          side: WidgetStatePropertyAll(BorderSide(
            color: onPressed == null && !isLoading ? Colors.grey.shade400 : primaryColor
          ))
        ),
        child: _buildChild(Colors.white),
      );
    }

    if(type == .text) {
      return TextButton(
        onPressed: onPressed,
        child: _buildChild(primaryColor)
      );
    }

    return ElevatedButton(
      key: ValueKey('primary_$isLoading'),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: type == .primary
          ? primaryColor
          : Theme.of(context).colorScheme.secondary,
      ),
      child: _buildChild(Colors.white),
    );
  }

  Widget _buildChild(Color contentColor) {
    if(isLoading) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(contentColor),
        ),
      );
    }

    if(icon != null) {
      return Row(
        mainAxisAlignment: .center,
        children: [
          Icon(icon, size: 20, color: contentColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w600,
              color: contentColor,
            ),
          ),
        ],
      );
    }

    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: .w600,
        color: contentColor,
      ),
    );
  }
}