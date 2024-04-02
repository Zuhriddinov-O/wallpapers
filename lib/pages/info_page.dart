import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/db/db_helper.dart';
import 'package:wallpapers/storage/favorites.dart';
import 'package:wallpapers/storage/wallpapers.dart';

class InfoPage extends StatefulWidget {
  InfoPage({super.key, required this.photo, required Photos photos});

 final Photos photo;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool _isLiked = false;

  @override
  void initState() {
    _checkState();
    super.initState();
  }

  void _checkState() async {
    _isLiked = await SqlHelper.getById(widget.photo.id) != null;
    setState(() {

    });
  }

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
                        if(_isLiked == false) {
                          _isLiked = true;
                          SqlHelper.saveSign(Favorites(id: null, photo_id: widget.photo.id, photographer: widget.photo.photographer, medium: widget.photo.src?.medium, liked: "true"));
                        } else {
                          _isLiked = false;
                          SqlHelper.deletePhoto(widget.photo.id);
                        }
                        setState(() {

                        });
                      },
                      icon: Icon(_isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                          color: _isLiked ? Colors.red : Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
