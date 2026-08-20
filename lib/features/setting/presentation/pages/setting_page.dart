import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/core/constants/app_colors.dart';
import 'package:login_biometrics_app/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:login_biometrics_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:login_biometrics_app/features/biometric_auth/presentation/bloc/biometric_bloc.dart';
import 'package:login_biometrics_app/service_locator.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late final String deviceId;
  late final String deviceModel;

  @override
  void initState() {
    _generateDeviceInfo();
    super.initState();
  }

  void _generateDeviceInfo() async {
    final dip = DeviceInfoPlugin();
    final deviceInfo = await dip.androidInfo;
    deviceId = deviceInfo.id;
    deviceModel = deviceInfo.model;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Setting"),
        ),
        body: BlocConsumer(
          listener: (context, state) {
            if (state is Unauthenticated) {
              sl<AppAuthBloc>().add(AppAuthLogoutRequested());
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text("Login Biometrik"),
                    leading: Icon(Icons.fingerprint, color: Theme.of(context).colorScheme.primary),
                    onTap: () {
                      sl<BiometricBloc>().add(RegisterBiometricEvent(deviceId, deviceModel, "123456"));
                    },
                  ),
                  ListTile(
                    title: const Text("Keluar"),
                    leading: const Icon(Icons.exit_to_app, color: AppColors.danger),
                    onTap: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                    },
                  )
                ],
              ),
            );
          },
        )
      ),
    );
  }
}