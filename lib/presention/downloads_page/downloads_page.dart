import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix_clone/application/downloads/downloads_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/widgets/appbarwidget.dart';

class DownloadsPage extends StatelessWidget {
  DownloadsPage({super.key});

  final _widgetList = [const _SmartDownloads(), Section1(), Section3()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget(
          title: 'Downloads',
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemCount: _widgetList.length,
        itemBuilder: (context, index) => _widgetList[index],
        separatorBuilder: (context, index) => SizedBox(
          height: 20,
        ),
      ),
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        sboxW,
        Icon(
          Icons.settings,
          color: bgwhite,
        ),
        Text('Smart Downloads')
      ],
    );
  }
}

class Section1 extends StatelessWidget {
  const Section1({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          'Introducing Downloads for You',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: bgwhite, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "We'll download a personalised section of\n films and programms for you , so there\n will be always somthing to watch on your\n device",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            if (state.downloads.isEmpty) {
             return CircularProgressIndicator();
            } 
           else{
             return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isLoading
                  ? Center(child: const CircularProgressIndicator())
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: size.width * 0.4,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        DownloadsImageWidget(
                          imglist:
                              '$imageAppendUrl${state.downloads[0].posterPath}',
                          margin: const EdgeInsets.only(left: 130, bottom: 20),
                          angle: 20,
                          size: Size(size.width * 0.65, size.width * 0.58),
                        ), 
                        DownloadsImageWidget(
                          imglist:
                              '$imageAppendUrl${state.downloads[1].posterPath}',
                          margin: const EdgeInsets.only(right: 130, bottom: 20),
                          angle: -20,
                          size: Size(size.width * 0.65, size.width * 0.58),
                        ),
                        DownloadsImageWidget(
                          imglist:
                              '$imageAppendUrl${state.downloads[2].posterPath}',
                          margin: const EdgeInsets.only(left: 0, bottom: 0),
                          size: Size(size.width * 0.7, size.width * 0.58),
                        ),
                      ],
                    ),
            );
           }
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Set Up',
                style: TextStyle(
                    color: bgwhite, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {},
            color: NbuttonColorBlue,
          ),
        ),
        sboxW,
        MaterialButton(
          child: Text(
            'See What you can Download',
            style: TextStyle(
                color: bgcolor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
          color: NbuttonColorWhite,
        ),
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {Key? key,
      required this.imglist,
      this.angle = 0,
      required this.margin,
      required this.size})
      : super(key: key);

  final String imglist;
  final double angle;
  final EdgeInsets margin;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          margin: margin,
          width: size.width,
          height: size.width,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              // fit: BoxFit.contain,
              image: NetworkImage(imglist),
            ),
          ),
        ),
      ),
    );
  }
}
