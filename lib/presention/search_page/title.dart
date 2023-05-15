import 'package:flutter/cupertino.dart';

class SearchTextTitle extends StatelessWidget {
  final String title;
  const SearchTextTitle({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
