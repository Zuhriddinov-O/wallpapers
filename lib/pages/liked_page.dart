import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpapers/storage/dio_repository.dart';

import '../storage/wallpapers.dart';
import 'info_page.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});


  @override
  State<LikedPage> createState() => _LikedPageState();
}

final _repo = DioRepositoryImpl();

class _LikedPageState extends State<LikedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC2D9EC),
      body: RefreshIndicator(
        child: FutureBuilder(
          future: _repo.getPhotos(),
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data?.isNotEmpty == true) {
              return _successField(snapshot.data ?? []);
            } else if (snapshot.data == null) {
              return const Center(child: SpinKitWave(color: Colors.black));
            } else if (snapshot.data?.isEmpty == true) {
              return const Center(child: Text("Empty"));
            } else {
              return Container();
            }
          },
        ),
        onRefresh: () {
          return _repo.getPhotos();
        },
      ),
    );
  }

  _successField(List<Photos> photos) {
    List<Photos>photoList=[];
    for (var element in photos) {
      if (element.liked == false) {
        photoList.add(element);
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CupertinoTextField(
            onChanged: (query) {
              // runFilter(query);
            },
            placeholder: "Search...",
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 1.3782,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kIsWeb ? 5 : 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 320,
            ),
            itemCount: photoList.length,
            itemBuilder: (context, index) {
              final liked = photoList[index];
              print(photoList[index].liked);
              return SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: OpenContainer(
                        closedBuilder: (context, action) {
                          return Image.network(
                            liked.src?.medium ?? "",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: 290,
                          );
                        },
                        openBuilder: (context, action) {
                          return InfoPage(photo: liked, photos: liked, likedList: []);
                        },
                      ),
                    ),
                    Text("Rating: ${liked.height} ⭐️⭐️⭐️⭐️⭐️"),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
