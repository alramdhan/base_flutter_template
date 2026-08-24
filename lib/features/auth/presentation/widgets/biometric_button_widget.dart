import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:login_biometrics_app/core/services/biometric_service.dart';

class BiometricButtonWidget extends StatefulWidget {
  const BiometricButtonWidget(
    this.context, {
    super.key,
    required this.onBiometricAuth
  });

  final BuildContext context;
  final Function(bool) onBiometricAuth;

  @override
  State<BiometricButtonWidget> createState() => _BiometricButtonWidgetState();
}

class _BiometricButtonWidgetState extends State<BiometricButtonWidget> {
  
  late final BiometricService _biometricService;

  @override
  void initState() {
    super.initState();
    _biometricService = BiometricService();
  }

  void _onBiometricPressed() async {
    final isAuthenticate = await _biometricService.authenticate();

    if(isAuthenticate) {
      widget.onBiometricAuth(isAuthenticate);
    } else {
      print("gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
            Padding(
              padding: const .symmetric(horizontal: 16),
              child: Text('ATAU', style: TextStyle(color: Colors.grey.shade500, fontWeight: .w600)),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
          ],
        ).animate().fadeIn(delay: 700.ms),
        const SizedBox(height: 8),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white
          ),
          padding: const .all(10),
          icon: const Icon(Icons.fingerprint, size: 35),
          onPressed: _onBiometricPressed,
        ).animate()
          .fadeIn(delay: 600.ms)
          .scale(),
      ],
    );
  }
}