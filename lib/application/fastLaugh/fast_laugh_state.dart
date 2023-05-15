part of 'fast_laugh_bloc.dart';

@freezed
class FastLaughState with _$FastLaughState {
  factory FastLaughState({
    required List<Downloads> videosList,
    required bool isLoading,
    required bool isError,
  }) = _Initial;

  factory FastLaughState.initial() => FastLaughState(
        videosList: [],
        isLoading: true,
        isError: false,
      );
}
