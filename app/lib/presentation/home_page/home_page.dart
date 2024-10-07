import 'package:design_system/design_system.dart';
import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:marvel_characters/presentation/home_page/home_page_viewmodel.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../../utils/utils.dart';
import 'home_page_providers.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget? loadingWidget;
    final vm = readHomeViewModel(ref);
    final scrollController = useScrollController();
    final searchController = useTextEditingController();

    useEffect(() {
      scrollController.addListener(() {
        final state = useHomeState(ref);

        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          vm.fetch(offset: state.currentOffset, searchTerm: state.searchTerm);
        }
      });
      return () => scrollController.dispose();
    }, [scrollController]);

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

        loadingWidget =
            state.isLoading ? const ScaffoldWidget(body: Loader()) : null;

        if (state.isLoadingNextPage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
            );
          });
        }

        return RefreshIndicator(
          color: Colors.black,
          onRefresh: () async => _clearAndFetch(vm),
          child: loadingWidget ??
              ScaffoldWidget(
                padding: const EdgeInsets.all(0),
                body: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const VGap.xxs(),
                      FeaturedCharacters(
                        characters: state.characters,
                        onCharacterTap: (characterId) => _onCharacterTap(
                          context: context,
                          characterId: characterId,
                        ),
                      ),
                      const VGap.xxs(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kSpacingXXXS,
                        ),
                        child: CharactersList(
                          characters: state.characters,
                          searchController: searchController,
                          onCharacterTap: (characterId) => _onCharacterTap(
                            context: context,
                            characterId: characterId,
                          ),
                          onSearch: (value) => _onSearch(vm, value),
                          onChanged: (value) => _onChanged(value, vm),
                        ),
                      ),
                      if (state.isLoadingNextPage) ...[
                        const Loader(),
                        const VGap.sm(),
                      ],
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }

  void _onCharacterTap({
    required BuildContext context,
    required int characterId,
  }) {
    context.go(Routes.details, extra: characterId);
  }

  void _onChanged(String value, HomePageViewModel vm) {
    if (value.isEmpty) {
      _clearAndFetch(vm);
    }
  }

  void _onSearch(HomePageViewModel vm, String value) {
    vm.cleanSearch();

    if (value.isEmpty) {
      vm.fetch(offset: 0);
    } else {
      vm.fetch(offset: 0, searchTerm: value);
    }
  }

  void _clearAndFetch(HomePageViewModel vm) {
    vm.cleanSearch();
    vm.fetch(offset: 0);
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
  final Function(int) onCharacterTap;

  const FeaturedCharacters({
    super.key,
    required this.characters,
    required this.onCharacterTap,
  });

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
                  width: MediaQuery.of(context).size.width * 0.35,
                  shadowHeight: MediaQuery.of(context).size.height * 0.05,
                  borderRadius: BorderRadius.circular(BorderSize.nano),
                  imagePath: character.thumbnailUrl,
                  characterName: character.name,
                  onTap: () => onCharacterTap(character.id),
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
  final void Function(String) onSearch;
  final void Function(String)? onChanged;
  final Function(int) onCharacterTap;
  final TextEditingController searchController;

  const CharactersList({
    super.key,
    required this.characters,
    required this.onSearch,
    required this.searchController,
    this.onChanged,
    required this.onCharacterTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useHomeState(ref);

    useEffect(() {
      searchController.text = state.searchTerm ?? '';
      return null;
    }, [state.searchTerm]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MARVEL CHARACTERS LIST',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const VGap.quarck(),
        SizedBox(
          height: 36,
          child: TextFormFieldWidget(
            controller: searchController,
            hintText: 'Search characters',
            onFieldSubmitted: (value) => onSearch(value),
            onChanged: (value) => onChanged?.call(value),
          ),
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
                  shadowHeight: MediaQuery.of(context).size.height * 0.05,
                  borderRadius: BorderRadius.circular(BorderSize.nano),
                  imagePath: character.thumbnailUrl,
                  characterName: character.name,
                  onTap: () => onCharacterTap(character.id),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
