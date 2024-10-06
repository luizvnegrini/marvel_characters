import 'package:design_system/design_system.dart';
import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends HookConsumerWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldWidget(
      showAppBar: false,
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.webp',
              package: 'design_system',
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
