import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: AppBar(
              backgroundColor: bgcolor,
              title: const Text(
                "New & Hot",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                const Icon(
                  size: 30,
                  Icons.cast,
                  color: bgwhite,
                ),
                sboxW,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Container(
                    color: Colors.cyan,
                    width: 30,
                  ),
                ),
              ],
              bottom: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: bgwhite,
                ),
                unselectedLabelColor: bgwhite,
                labelColor: bgcolor,
                tabs: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "🍿Coming Soon",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "👀Everyone's Watching",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: bgcolor,
        body: const TabBarView(
          children: [
            ComingSoonWidget(),
            EveryonesWatchingWidget(),
          ],
        ),
      ),
    );
  }
}

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HotAndNewBloc, HotAndNewState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else if (state.hasError) {
          return const Center(
            child: Text("Error while loading coming soon list"),
          );
        } else if (state.comingSoonList.isEmpty) {
          return const Center(
            child: Text("Coming soon list is empty"),
          );
        } else {
          return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                // print(state.comingSoonList[0].releaseDate);

                final date = DateTime.parse(
                    state.comingSoonList[index].releaseDate ?? "2002-05-01");
                final formatedDate = DateFormat.yMMMMd('en_US').format(date);
                final month =
                    formatedDate.split(' ').first.substring(0, 3).toUpperCase();
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 420,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                month,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                state.comingSoonList[index].releaseDate!
                                    .split('-')[2],
                                // 'FEB 11',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width - 50,
                          height: 420,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 250,
                                    child: Image.network(
                                      '$imageAppendUrl${state.comingSoonList[index].backdropPath!}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: 5,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.volume_off,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      state
                                          .comingSoonList[index].originalTitle!,
                                      // 'Orginal Title',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.notifications_outlined,
                                          size: 30,
                                          color: bgwhite,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.info_outline,
                                          size: 30,
                                          color: bgwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Coming on February 11",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    state.comingSoonList[index].overview!,
                                    textAlign: TextAlign.start,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  sboxH,
                                  // const Text(
                                  //   "Drama · Mythical · Crime · Comedy",
                                  //   textAlign: TextAlign.start,
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  // kHeight,
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              });
        }
      },
    );
  }
}

class EveryonesWatchingWidget extends StatelessWidget {
  const EveryonesWatchingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneWatching());
    });
    return BlocBuilder<HotAndNewBloc, HotAndNewState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else if (state.hasError) {
          return const Center(
            child: Text("Error while loading coming soon list"),
          );
        } else if (state.everyOneIsWatchingList.isEmpty) {
          return const Center(
            child: Text("Coming soon list is empty"),
          );
        } else {
          return ListView.builder(
            itemCount: state.everyOneIsWatchingList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        state.everyOneIsWatchingList[index].backdropPath != null
                            ? '$imageAppendUrl${state.everyOneIsWatchingList[index].backdropPath}'
                            : "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg",
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.volume_off,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            state.everyOneIsWatchingList[index].title ??
                                state.everyOneIsWatchingList[index].name ??
                                'no title',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                                color: bgwhite,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                color: bgwhite,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_arrow,
                                color: bgwhite,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.everyOneIsWatchingList[index].overview!,
                      textAlign: TextAlign.start,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  sboxH,
                ],
              );
            },
          );
        }
      },
    );
  }
}
































































// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:netflix_clone/core/colors/colors.dart';
// import 'package:netflix_clone/core/constants.dart';
// import 'package:netflix_clone/presention/fast_laughs_page/widgets/videolistitem.dart';
// import 'package:netflix_clone/widgets/appbarwidget.dart';

// class NewandHotPage extends StatelessWidget {
//   const NewandHotPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: bgcolor,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(80),
//           child: AppBar(
//             backgroundColor: bgcolor,
//             title: Text(
//               'Hot & New',
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//             actions: [
//               Icon(
//                 Icons.cast_sharp,
//                 color: bgwhite,
//                 size: 30,
//               ),
//               sboxW,
//               Container(
//                 width: 30,
//                 height: 30,
//                 color: Colors.cyan,
//               ),
//               sboxW,
//             ],
//             bottom: TabBar(
//               labelColor: bgcolor,
//               unselectedLabelColor: bgwhite,
//               labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 color: bgwhite,
//               ),
//               tabs: [
//                 Tab(
//                   text: '🍿Coming Soon ',
//                 ),
//                 Tab(
//                   text: '👀Everyones watching ',
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildComingSoon(context),
//             _buildEveryonesWatching(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildComingSoon(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return ListView(
//       shrinkWrap: true,
//       children: [
//         sboxH,
//         CmingSoonWidget(size: size),
//         CmingSoonWidget(size: size),
//       ],
//     );
//   }

//   Widget _buildEveryonesWatching() {
//     return Container();
//   }
// }

// class CmingSoonWidget extends StatelessWidget {
//   const CmingSoonWidget({
//     Key? key,
//     required this.size,
//   }) : super(key: key);

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         sboxH,
//         SizedBox(
//           height: 400,
//           child: Column(
//             children: [
//               Text('FEB',
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: bgwhite.withOpacity(0.5))),
//               Text('11',
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//             ],
//           ),
//           width: 50,
//         ),
//         Container(
//           child: Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 200,
//                 child: Image.network(
//                     'https://mir-s3-cdn-cf.behance.net/project_modules/fs/706b9474134343.5c239806af449.jpg'),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Tall Girl 2',
//                       style:
//                           TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//                   Spacer(),
//                   VideoActionsWidget(icon: Icons.alarm, title: 'Remind Me'),
//                   sboxW,
//                   VideoActionsWidget(icon: Icons.info, title: 'info'),
//                   sboxW
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text('Coming on Friday',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: bgwhite.withOpacity(0.5))),
//                   sboxH,
//                   Text('Tall Girl 2',
//                       style:
//                           TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
//                   sboxH,
//                   Text(
//                       'The film stars Ava Michelle, Griffin Gluck, Sabrina Carpenter, Paris Berelc, Luke Eisner, Clara Wilsey, Anjelika Washington, Rico Paris, Angela Kinsey, and Steve Zahn. It was released by Netflix on September 13, 2019.',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w300,
//                           color: bgwhite.withOpacity(0.5))),
//                 ],
//               )
//             ],
//           ),
//           width: size.width - 50,
//           height: 400,
//         ),
//       ],
//     );
//   }
// }


// class EveryonesWatchingWidget extends StatelessWidget {
//   const EveryonesWatchingWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       BlocProvider.of<HotAndNewBloc>(context)
//           .add(const LoadDataInEveryOneWatching());
//     });
//     return BlocBuilder<HotAndNewBloc, HotAndNewState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const CircularProgressIndicator();
//         } else if (state.hasError) {
//           return const Center(
//             child: Text("Error while loading coming soon list"),
//           );
//         } else if (state.everyOneIsWatchingList.isEmpty) {
//           return const Center(
//             child: Text("Coming soon list is empty"),
//           );
//         } else {
//           return ListView.builder(
//             itemCount: state.everyOneIsWatchingList.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return Column(
//                 children: [
//                   Stack(
//                     children: [
//                       Image.network(
//                         state.everyOneIsWatchingList[index].backdropPath != null
//                             ? '$imageAppendUrl${state.everyOneIsWatchingList[index].backdropPath}'
//                             : "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg",
//                         fit: BoxFit.cover,
//                       ),
//                       Positioned(
//                         right: 5,
//                         bottom: 5,
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.volume_off,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: 250,
//                           child: Text(
//                             state.everyOneIsWatchingList[index].title ??
//                                 state.everyOneIsWatchingList[index].name ??
//                                 'no title',
//                             style: const TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(
//                                 Icons.share,
//                                 color: bgwhite,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(
//                                 Icons.add,
//                                 color: bgwhite,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(
//                                 Icons.play_arrow,
//                                 color: bgwhite,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       state.everyOneIsWatchingList[index].overview!,
//                       textAlign: TextAlign.start,
//                       // overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   sboxH,
//                 ],
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }