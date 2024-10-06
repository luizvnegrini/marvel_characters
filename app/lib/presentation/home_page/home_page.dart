import 'package:design_system/design_system.dart';
import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../utils/utils.dart';
import 'home_page_providers.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget? loadingWidget;

    return HookConsumer(
      builder: (context, ref, __) {
        final state = useHomeState(ref);

        if (state.errorMessage.isNotEmpty) {
          _handleError(
            context,
            ref,
            state.errorMessage,
          );
        }

        loadingWidget = state.isLoading
            ? const ScaffoldWidget(
                showAppBar: false,
                body: Center(child: CircularProgressIndicator()),
              )
            : null;

        return loadingWidget ??
            ScaffoldWidget(
              showAppBar: false,
              body: Center(
                child: Column(
                  children: [
                    const Text(
                      'Characters',
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.go(Routes.details, extra: 199);
                        },
                        child: const Text('navigate to details'))
                  ],
                ),
              ),
            );
      },
    );
  }

  void _handleError(BuildContext context, WidgetRef ref, String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final scaffoldMessenger = useScaffoldMessenger(ref);
        scaffoldMessenger.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: context.colors.unhealthy,
            padding: const EdgeInsets.symmetric(horizontal: kSpacingXXS),
            showCloseIcon: true,
            content: Text(message),
            duration: const Duration(seconds: 2), // Duração da Snackbar
          ),
        );
      },
    );
  }
}
