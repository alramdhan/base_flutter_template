import 'package:flutter/material.dart';

class MinimalistTextfield extends StatefulWidget {
  const MinimalistTextfield({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.isPassword = false,
    this.errorText,
    this.validator,
    this.onEditingComplete
  });

  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final bool isPassword;
  final String? errorText;
  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;

  @override
  State<MinimalistTextfield> createState() => _MinimalistTextfieldState();
}

class _MinimalistTextfieldState extends State<MinimalistTextfield> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      onEditingComplete: widget.onEditingComplete,
      autovalidateMode: AutovalidateMode.onUserInteractionIfError,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon != null 
          ? Icon(
            widget.prefixIcon,
            color: widget.errorText != null ? errorColor : Colors.grey.shade500,
            size: 22,
          )
          : null,
        suffixIcon: widget.isPassword
          ? IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            icon: Icon(
              _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.grey.shade500,
              size: 22,
            ),
            onPressed: _togglePasswordVisibility,
            splashRadius: 24, // Efek sentuhan yang lebih rapi
          ) : null,
      ),
    );
  }
}