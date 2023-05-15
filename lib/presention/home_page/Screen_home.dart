import 'package:flutter/material.dart';
import 'package:netflix_clone/application/home_page/home_page_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_clone/presention/home_page/number_card.dart';
import 'package:netflix_clone/presention/main_pages/bottom_navigation.dart';
import 'package:netflix_clone/widgets/main_title.dart';
import 'package:netflix_clone/widgets/maincardimage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final img =
      'https://3.bp.blogspot.com/-b75pK55L104/VvU4LBTCC5I/AAAAAAAAG60/9__nl7WbMqUNwUYEqhC8d6-yToy-g_vKw/s1600/BvS%2BPoster.jpg';
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomePageBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(img))),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.add,
                            color: bgwhite,
                          ),
                          Text(
                            'My List',
                            style: TextStyle(color: bgwhite),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(bgwhite)),
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_arrow,
                          size: 25,
                          color: bgcolor,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Play',
                            style: TextStyle(
                                fontSize: 20,
                                color: bgcolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: bgwhite,
                          ),
                          Text(
                            'Info',
                            style: TextStyle(color: bgwhite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.black38.withOpacity(0.3),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                              width: 55,
                              height: 55,
                              'https://upload.wikimedia.org/wikipedia/commons/f/ff/Netflix-new-icon.png'),
                          Spacer(),
                          Icon(
                            Icons.cast_sharp,
                            color: bgwhite,
                            size: 30,
                          ),
                          sboxW,
                          Container(
                            width: 30,
                            height: 30,
                            color: Colors.cyan,
                          ),
                          sboxW,
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'TV shows',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Movies',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'catogories',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                } else if (state.hasError) {
                  return const Center(
                    child: Text(
                      "Error while getting data",
                      style: TextStyle(color: bgwhite),
                    ),
                  );
                }

                final releasedPastYear = state.pastYearMovieList.map(
                  (m) {
                    return '$imageAppendUrl${m.posterPath}';
                  },
                ).toList();
                releasedPastYear.shuffle();
                //trending--------

                final trending = state.trendingMovieList.map(
                  (m) {
                    return '$imageAppendUrl${m.posterPath}';
                  },
                ).toList();
                print(trending);
                trending.shuffle();
                //tense drama---------
                final tenseDrama = state.tenseMovieList.map(
                  (m) {
                    return '$imageAppendUrl${m.posterPath}';
                  },
                ).toList();
                //south indian Cinemas---------

                final southIndianCinemas = state.southIndianMovieList.map(
                  (m) {
                    return '$imageAppendUrl${m.posterPath}';
                  },
                ).toList();
                southIndianCinemas.shuffle();

                // top 10 tv show--------

                final top10TvShow = state.trendingTvList.map(
                  (m) {
                    return '$imageAppendUrl${m.posterPath}';
                  },
                ).toList();
                top10TvShow.shuffle();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainTitle(title: 'Released in the past year'),
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children:
                              List.generate(releasedPastYear.length, (index) => MainCardHome(posterPath: releasedPastYear[index],))),
                    ),
                    sboxH,
                    MainTitle(title: 'Trending Now'),
                    sboxH,
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children:
                              List.generate(trending.length, (index) => MainCardHome(posterPath: trending[index]))),
                    ),
                    MainTitle(title: 'Top 10 TV shows in india Today'),
                    sboxH,
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              releasedPastYear.length,
                              (index) => NumberCard(
                                    index: index,
                                    posterPath: top10TvShow[index],
                                  ))),
                    ),
                    MainTitle(title: 'South Indian Cinemas'),
                    sboxH,
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children:
                              List.generate(southIndianCinemas.length, (index) => MainCardHome(posterPath: southIndianCinemas[index]))),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
