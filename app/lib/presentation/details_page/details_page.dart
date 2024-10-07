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
    const textColor = Colors.white;
    const textStyle = TextStyle(
      color: textColor,
      fontWeight: FontWeight.bold,
    );
    const descriptionStyle = TextStyle(
      color: textColor,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = readDetailsViewModel(ref);
      vm.fetchCharacter(characterId);
    });

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
                backgroundColor: Colors.black,
                body: Loader(color: Colors.white),
              )
            : null;

        return loadingWidget ??
            ScaffoldWidget(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CharacterTile(
                          height: MediaQuery.of(context).size.height * 0.3,
                          shadowHeight:
                              MediaQuery.of(context).size.height * 0.08,
                          imagePath: state.character?.thumbnailUrl ?? '',
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(1),
                              Colors.black.withOpacity(.8),
                              Colors.black.withOpacity(.6),
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          )).animate().fadeIn(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kSpacingXXXS,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const VGap.xxxs(),
                            Text(
                              state.character?.name ?? '',
                              style: textStyle.copyWith(fontSize: 24),
                            ).animate().fadeIn(),
                            if (state.character?.description.isNotEmpty ??
                                false) ...[
                              const VGap.xxs(),
                              const Text('BIOGRAPHY', style: textStyle)
                                  .animate()
                                  .fadeIn(),
                              const VGap.nano(),
                              Text(
                                state.character?.description ?? '',
                                style: descriptionStyle,
                              ).animate().fadeIn(delay: 200.milliseconds),
                            ] else
                              const Text(
                                'No biography available',
                                style: descriptionStyle,
                              ).animate().fadeIn(delay: 500.milliseconds),
                            const VGap.sm(),
                          ],
                        ),
                      ),
                    ],
                  ),
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
