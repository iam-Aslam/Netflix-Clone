import 'package:flutter/cupertino.dart';

class MainCardHome extends StatelessWidget {
   
     final String posterPath;
  const MainCardHome({
    Key? key,
   
      required this.posterPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 130,
        height: 230,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                    posterPath))),
      ),
    );
  }
}
