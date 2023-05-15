part of 'home_page_bloc.dart';


@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    required String stateId,
    required List<HotAndNewData> pastYearMovieList,
    required List<HotAndNewData> trendingMovieList,
    required List<HotAndNewData> tenseMovieList,
    required List<HotAndNewData> southIndianMovieList,
    required List<HotAndNewData> trendingTvList,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;
  factory HomePageState.initial() => const HomePageState(
        pastYearMovieList: [],
        trendingMovieList: [],
        tenseMovieList: [],
        southIndianMovieList: [],
        trendingTvList: [],
        isLoading: false,
        hasError: false,
        stateId: '0',
      );
}