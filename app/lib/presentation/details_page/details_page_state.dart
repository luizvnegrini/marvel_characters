import '../../domain/domain.dart';
import '../base/viewmodel.dart';

abstract class DetailsPageState extends ViewModelState {
  abstract final bool isLoading;

  abstract final String errorMessage;

  abstract final Character? character;

  const DetailsPageState();

  DetailsPageState copyWith({
    bool? isLoading,
    String? errorMessage,
    Character? character,
  });
}

class DetailsPageStateImpl extends DetailsPageState {
  @override
  final bool isLoading;

  @override
  final String errorMessage;

  @override
  final Character? character;

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        character,
      ];

  const DetailsPageStateImpl({
    this.isLoading = false,
    this.errorMessage = '',
    this.character,
  });

  factory DetailsPageStateImpl.initial() => const DetailsPageStateImpl();

  @override
  DetailsPageState copyWith({
    bool? isLoading,
    String? errorMessage,
    Character? character,
  }) =>
      DetailsPageStateImpl(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        character: character ?? this.character,
      );
}
