import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpapers/pages/info_page.dart';

import '../storage/dio_repository.dart';
import '../storage/wallpapers.dart';

class RatedPage extends StatefulWidget {
  const RatedPage({super.key});

  @override
  State<RatedPage> createState() => _RatedPageState();
}

final _repo = DioRepositoryImpl();

class _RatedPageState extends State<RatedPage> {
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
              return const Center(child: SpinKitWaveSpinner(color: Colors.black));
            } else if (snapshot.data?.isEmpty == true) {
              return const Center(child: Text("Empty"));
            } else {
              return Container();
            }
          },
        ),
        onRefresh: () async {
          _repo.getPhotos();
          setState(() {});
        },
      ),
    );
  }

  List ratedList = [];

  _successField(List<Photos> photos) {
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
            itemCount: photos.length,
            itemBuilder: (context, index) {
              photos.sort((a, b) => b.height!.compareTo(a.height as num));
              final ratedPhotos = photos[index];
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
                            ratedPhotos.src?.medium ?? "",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: 290,
                          );
                        },
                        openBuilder: (context, action) {
                          return InfoPage(photo: ratedPhotos, photos: ratedPhotos, likedList: []);
                        },
                      ),
                    ),
                    Text("Rating: ${ratedPhotos.height} ⭐️⭐️⭐️⭐️⭐️"),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
