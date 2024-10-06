import 'package:design_system/design_system.dart';
import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';
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
                body: Center(child: CircularProgressIndicator()),
              )
            : null;

        return loadingWidget ??
            ScaffoldWidget(
              padding: const EdgeInsets.all(0),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const VGap.xxs(),
                    FeaturedCharacters(characters: state.characters),
                    const VGap.xxs(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kSpacingXXXS,
                      ),
                      child: CharactersList(characters: state.characters),
                    ),
                    const VGap.nano(),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       context.go(Routes.details, extra: 199);
                    //     },
                    //     child: const Text('navigate to details'))
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

class FeaturedCharacters extends StatelessWidget {
  final List<Character> characters;

  const FeaturedCharacters({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: kSpacingXXXS),
          child: Text(
            'FEATURED CHARACTERS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const VGap.nano(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final leftPadding = index == 0.0 ? kSpacingXXXS : 0.0;
              final character = characters[index];

              return Padding(
                padding: EdgeInsets.only(left: leftPadding),
                child: CharacterTile(
                  imagePath:
                      '${character.thumbnail.path}.${character.thumbnail.extension}',
                  characterName: character.name,
                ),
              );
            },
            separatorBuilder: (_, index) => const HGap.nano(),
            itemCount: characters.length,
          ),
        ),
      ],
    );
  }
}

class CharactersList extends HookConsumerWidget {
  final List<Character> characters;

  const CharactersList({super.key, required this.characters});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MARVEL CHARACTERS LIST',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const VGap.quarck(),
        const SizedBox(
          height: 36,
          child: TextFormFieldWidget(hintText: 'Search characters'),
        ),
        const VGap.xs(),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: kSpacingXXXS,
          mainAxisSpacing: kSpacingXXXS,
          children: characters
              .map<CharacterTile>(
                (character) => CharacterTile(
                  imagePath:
                      '${character.thumbnail.path}.${character.thumbnail.extension}',
                  characterName: character.name,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
