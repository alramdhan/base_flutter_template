import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/core/helpers/secure_storage_helper.dart';
import 'package:login_biometrics_app/core/widgets/minimalist_button.dart';
import 'package:login_biometrics_app/core/widgets/minimalist_textfield.dart';
import 'package:login_biometrics_app/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:login_biometrics_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:login_biometrics_app/features/auth/presentation/widgets/remember_me.dart';
import 'package:login_biometrics_app/service_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  bool hasBiometricEnabled = false;
  bool rememberMe = false;

  late AnimationController _shakeController;

  @override
  void initState() {
    _initLocalStorage();
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

  void _initLocalStorage() async {
    hasBiometricEnabled = await sl<SecureStorageHelper>().getBiometricStatus();
  }

  void _onLoginPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    final email = _emailController.text;
    final pwd = _pwdController.text;
    print("remember $rememberMe");

    // Panggil event BLoC
    context.read<AuthBloc>().add(
      LoginRequested(
        login: email,
        password: pwd,
        isRememberMe: rememberMe
      )
    );
  }

  void _onBiometricPressed() {

  }

  void _authBlocListener(BuildContext context, AuthState state) {
    switch (state) {
      case AuthSuccess(user: final user):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selamat data, ${user.name}'))
        );

        context.read<AppAuthBloc>().add(AppAuthLoggedIn());
        break;
      case AuthFailure(message: final msg):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: Theme.of(context).colorScheme.error,
          )
        );
        break;

      case Unauthenticated():
      case AuthInitial():
      case AuthLoading():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const .symmetric(horizontal: 24, vertical: 32),
              child: _buildForm(context, false), // 'false' replace with state BloC 'isLoading'
            ),
          )
        ),
      )
    );
  }

  Widget _buildForm(BuildContext context, bool isLoading) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: _authBlocListener,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          spacing: 8,
          children: [
            const Icon(Icons.lock_person_rounded, size: 72, color: Colors.blueAccent)
              .animate()
              .scale(delay: 200.ms, duration: 400.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 16),
            Text(
              'Selamat Datang',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: .w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: .center,
            ).animate()
              .fadeIn(delay: 300.ms)
              .slideY(begin: .2),
            Text(
              "Masuk untuk melanjutkan",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: .center,
            ).animate()
              .fadeIn(delay: 400.ms)
              .slideY(begin: .2),
            const SizedBox(height: 40),
            Form(
              child: Column(
                spacing: 16,
                children: [
                  MinimalistTextfield(
                    controller: _emailController,
                    hintText: "Email atau Username",
                    validator: (value) {
                      if(value == null || value.isNotEmpty) {
                        return "Harap ini email atau username";
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
                  RememberMeWidget(onChanged: (value) => rememberMe = value ?? false),
                  const SizedBox(height: 8),
                  MinimalistButton(
                    width: 500,
                    label: "Masuk",
                    isLoading: isLoading,
                    onPressed: state is AuthLoading ? null : () => _onLoginPressed(context),
                  ).animate()
                    .fadeIn(delay: 600.ms)
                    .scale(),
                  const SizedBox(height: 8),
                  if(hasBiometricEnabled)
                    _buildFingerPrintLogin()
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildFingerPrintLogin() {
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