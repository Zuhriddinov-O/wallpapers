import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpapers/pages/info_page.dart';
import 'package:wallpapers/storage/dio_repository.dart';
import 'package:wallpapers/storage/wallpapers.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  final _repo = DioRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC2D9EC),
      body: RefreshIndicator(
        onRefresh: () {
          return _repo.getPhotos();
        },
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
      ),
    );
  }

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
              mainAxisExtent: 300,
            ),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              var photo = photos[index];
              photos.shuffle();
              return OpenContainer(
                closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                closedBuilder: (BuildContext context, void Function() action) {
                  return SizedBox(
                    child: Image.network(
                      photo.src?.medium ?? "",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: 290,
                    ),
                  );
                },
                openBuilder: (BuildContext context, void Function({Object? returnValue}) action) {
                  return InfoPage(
                    photo: photo,
                    photos: photo,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
// likelarni idsi boyicha listga solish
