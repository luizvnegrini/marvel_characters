import '../../domain/domain.dart';
import '../base/viewmodel.dart';

abstract class HomePageState extends ViewModelState {
  abstract final bool isLoading;

  abstract final String errorMessage;

  abstract final List<Character> characters;

  const HomePageState();

  HomePageState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Character>? characters,
  });
}

class HomePageStateImpl extends HomePageState {
  @override
  final bool isLoading;

  @override
  final String errorMessage;

  @override
  final List<Character> characters;

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        characters,
      ];

  const HomePageStateImpl({
    this.isLoading = false,
    this.errorMessage = '',
    this.characters = const [],
  });

  factory HomePageStateImpl.initial() => const HomePageStateImpl();

  @override
  HomePageState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Character>? characters,
  }) =>
      HomePageStateImpl(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        characters: characters ?? this.characters,
      );
}
