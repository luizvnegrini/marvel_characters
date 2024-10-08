import '../../domain/domain.dart';
import '../base/viewmodel.dart';

abstract class HomePageState extends ViewModelState {
  abstract final bool isLoading;

  abstract final bool isLoadingNextPage;

  abstract final int currentOffset;

  abstract final bool hasReachedMax;

  abstract final String errorMessage;

  abstract final List<Character> characters;

  abstract final String? searchTerm;

  const HomePageState();

  HomePageState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Character>? characters,
    bool? isLoadingNextPage,
    int? currentOffset,
    bool? hasReachedMax,
    String? searchTerm,
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
  final bool isLoadingNextPage;

  @override
  final int currentOffset;

  @override
  final bool hasReachedMax;

  @override
  final String searchTerm;
  @override
  List<Object?> get props => [
        isLoading,
        isLoadingNextPage,
        errorMessage,
        characters,
        currentOffset,
        hasReachedMax,
        searchTerm,
      ];

  const HomePageStateImpl({
    this.isLoading = false,
    this.errorMessage = '',
    this.characters = const [],
    this.isLoadingNextPage = false,
    this.currentOffset = 0,
    this.hasReachedMax = false,
    this.searchTerm = '',
  });

  factory HomePageStateImpl.initial() => const HomePageStateImpl();

  @override
  HomePageState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Character>? characters,
    bool? isLoadingNextPage,
    int? currentOffset,
    bool? hasReachedMax,
    String? searchTerm,
  }) =>
      HomePageStateImpl(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        characters: characters ?? this.characters,
        isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
        currentOffset: currentOffset ?? this.currentOffset,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        searchTerm: searchTerm ?? this.searchTerm,
      );
}
