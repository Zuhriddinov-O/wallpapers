import 'package:flutter/material.dart';

class LikedPage extends StatefulWidget {
  LikedPage({super.key, required this.likedList});

  List<int> likedList;

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.likedList);
    return const Scaffold(
      backgroundColor: Color(0xFFC2D9EC),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text("Data"),
      ),
    );
  }
}
