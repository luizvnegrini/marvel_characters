import '../base/viewmodel.dart';

abstract class HomePageState extends ViewModelState {
  abstract final bool isLoading;

  abstract final String errorMessage;

  abstract final String? hex;

  const HomePageState();

  HomePageState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? hex,
  });
}

class HomePageStateImpl extends HomePageState {
  @override
  final bool isLoading;

  @override
  final String errorMessage;

  @override
  final String? hex;

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        hex,
      ];

  const HomePageStateImpl({
    this.isLoading = false,
    this.errorMessage = '',
    this.hex,
  });

  factory HomePageStateImpl.initial() => const HomePageStateImpl();

  @override
  HomePageState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? hex,
  }) =>
      HomePageStateImpl(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        hex: hex ?? this.hex,
      );
}
