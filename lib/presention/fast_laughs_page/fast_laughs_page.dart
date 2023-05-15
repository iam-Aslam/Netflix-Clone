import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/fastLaugh/fast_laugh_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/presention/fast_laughs_page/widgets/videolistitem.dart';


class ScreenFastLaugh extends StatelessWidget {
  const ScreenFastLaugh({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    });
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: BlocBuilder<FastLaughBloc, FastLaughState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            } else if (state.isError) {
              return const Center(
                child: Text("Error found"),
              );
            } else {
              return PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                    state.videosList.length,
                    (index) => VideoListItemInheritedWidget(
                        widget: VideoListItem(
                          index: index,
                          key: Key(
                            index.toString(),
                          ),
                        ),
                        movieData: state.videosList[index])),
              );
            }
          },
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:netflix_clone/application/fastLaugh/fast_laugh_bloc.dart';
// import 'package:netflix_clone/presention/fast_laughs_page/widgets/videolistitem.dart';

// class FastlaughsPage extends StatelessWidget {
//   const FastlaughsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
//     });
//     return Scaffold(
//       body: SafeArea(child: BlocBuilder<FastLaughBloc, FastLaughState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const CircularProgressIndicator();
//           } else if (state.isError) {
//             return const Center(
//               child: Text("Error while getting data "),
//             );
//           } else if (state.videosList.isEmpty) {
//             return const Center(
//               child: Text('videoList is empty'),
//             );
//           }else{
//             return PageView(
//                 scrollDirection: Axis.vertical,
//                 children: List.generate(
//                     state.videosList.length,
//                     (index) => VideoListItemInheritedWidget(
//                         widget: VideoListItem(
//                           index: index,
//                           key: Key(
//                             index.toString(),
//                           ),
//                         ),
//                         movieData: state.videosList[index])),
//               );
//           }
          
//         },
//       )),
//     );
//   }
// }
