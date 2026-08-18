import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:login_biometrics_app/core/widgets/minimalist_button.dart';
import 'package:login_biometrics_app/core/widgets/minimalist_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    _shakeController.dispose();
  }

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();
    final email = _emailController.text;
    final pwd = _pwdController.text;

    // Panggil event BLoC
    // context.read<AuthBloc>().add(LoginSubmitted(email: email, password: password));
  }

  void _onBiometricPressed() {

  }

  // void _authBlocListener(BuildContext context, AuthState state) {
  //   if (state is AuthSuccess) {
  //     // Pindah ke halaman Home
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } else if (state is AuthError) {
  //     // 1. Trigger animasi getar pada form
  //     _shakeController.forward(from: 0.0);
      
  //     // 2. Tampilkan pesan error yang rapi
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(state.message),
  //         backgroundColor: Colors.redAccent,
  //         behavior: SnackBarBehavior.floating,
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const .symmetric(horizontal: 24, vertical: 32),
            child: _buildForm(context, false), // 'false' replace with state BloC 'isLoading'
          ),
        )
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool isLoading) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      spacing: 8,
      children: [
        const Icon(Icons.lock_person_rounded, size: 64, color: Colors.blueAccent)
          .animate()
          .scale(delay: 200.ms, duration: 400.ms, curve: Curves.easeOutBack),
        const SizedBox(height: 16),
        Text(
          'Selamat Datang',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: .w700,
            color: Colors.black87,
          ),
          textAlign: .center,
        )
        .animate()
        .fadeIn(delay: 300.ms)
        .slideY(begin: .2),
        Text(
          "Masuk untuk melanjutkan",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey.shade600,
          ),
          textAlign: .center,
        )
        .animate()
        .fadeIn(delay: 400.ms)
        .slideY(begin: .2),
        const SizedBox(height: 40),
        Form(
          child: Column(
            spacing: 16,
            children: [
              MinimalistTextfield(
                controller: _emailController,
                hintText: "Username",
                validator: (value) {
                  if(value == null || value.isNotEmpty) {
                    return "Harap ini username";
                  }

                  return null;
                },
              ),
              MinimalistTextfield(
                controller: _pwdController,
                hintText: "Sandi",
                isPassword: true,
                validator: (value) {
                  if(value == null || value.isNotEmpty) {
                    return "Harap ini sandi";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              MinimalistButton(
                width: 500,
                label: "Masuk",
                isLoading: isLoading,
                onPressed: _onLoginPressed,
              )
              .animate()
              .fadeIn(delay: 600.ms)
              .scale(),
              const SizedBox(height: 8),
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
                padding: const .all(10),
                icon: Icon(Icons.fingerprint, size: 35),
                onPressed: () {},
              )
              .animate()
              .fadeIn(delay: 600.ms)
              .scale(),
            ],
          ),
        )
      ],
    );
  }
}