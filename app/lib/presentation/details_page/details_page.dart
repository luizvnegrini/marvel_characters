import 'package:design_system/design_system.dart';
import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'details_page_providers.dart';

class DetailsPage extends HookConsumerWidget {
  final int characterId;

  const DetailsPage({super.key, required this.characterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget? loadingWidget;

    return HookConsumer(
      builder: (context, ref, __) {
        final state = useDetailsState(ref);

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
            const ScaffoldWidget(
              showAppBar: false,
              body: Center(
                child: Text(
                  'Character details',
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
