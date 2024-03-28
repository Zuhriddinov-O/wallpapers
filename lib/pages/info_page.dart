import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/storage/wallpapers.dart';

class InfoPage extends StatefulWidget {
  InfoPage({super.key, required this.photo, required Photos photos, required this.likedList});

 final Photos photo;
  List<int> likedList;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Image.network(widget.photo.src?.portrait ?? "",
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill),
          Positioned(
            child: AppBar(
              foregroundColor: Colors.white,
              forceMaterialTransparency: true,
              title: Text(widget.photo.photographer ?? ""),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IconButton(
                      onPressed: () {
                        isLiked = widget.photo.liked!;
                        setState(() {
                          isLiked = !isLiked;
                          widget.photo.liked = isLiked;


                          widget.photo.liked == true ? widget.likedList.add(widget.photo.id!) : widget.likedList.remove(widget.photo.id!);
                        });
                        // print(widget.likedList);
                      },
                      icon: Icon(isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                          color: isLiked ? Colors.red : Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
