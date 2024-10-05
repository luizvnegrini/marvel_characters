import 'package:design_system/design_system.dart';
import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

/// A widget that represents the splash screen of the application.
/// This widget extends [HookConsumerWidget] to utilize both hooks and
/// Riverpod's Consumer functionality.
/// It displays a loading screen or initial content when the app is launched.
class SplashScreenPage extends HookConsumerWidget {
  /// Creates a [SplashScreenPage] widget.
  /// The [key] parameter is optional and can be used to provide a unique
  ///  identifier for this widget.
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldWidget(
      backgroundColor: Colors.white,
      showAppBar: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Marvel Characters',
              style: TextStyle(color: Colors.black),
            ),
            const VGap.xxs(),
            CircularProgressIndicator(
              color: context.colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
