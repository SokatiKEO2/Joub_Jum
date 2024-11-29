import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/pages/menu_bar_pages/create_joubjum.dart';

Widget floatingCollapsed() {
  return Container(
    decoration: const BoxDecoration(
      // color: Color(0xFFeddcfe),
      color: drawerTop,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
    ),
    margin: const EdgeInsets.fromLTRB(20.0, 48.0, 20.0, 0),
    child: const Center(
      child: Icon(
        IconData(0xf0532, fontFamily: 'MaterialIcons'),
        size: 50,
        color: boxColor,
      ),
    ),
  );
}

Widget floatingPanel(List photoUrl, String placeName, String placeID,
    ElevatedButton directionButton, double rating) {
  return Container(
    decoration: const BoxDecoration(
      color: bodyColor,
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      boxShadow: [
        BoxShadow(
          blurRadius: 20.0,
          color: Colors.grey,
        ),
      ],
    ),
    margin: const EdgeInsets.fromLTRB(20.0, 48.0, 20.0, 24.0),
    child: Column(
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.center,
            placeName,
            style: const TextStyle(fontSize: 18, fontFamily: 'Raritas'),
          ),
        ),
        const Divider(height: 6, color: appBarColor),
        const SizedBox(height: 18),
        pictureSlider(photoUrl),
        Expanded(
          child: Row(
            children: [
              descriptionBox(rating),
              Text("Rating: $rating"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: directionButton),
              const SizedBox(width: 10),
              Expanded(
                child: JoubJumButton(
                  placeName: placeName,
                  placeID: placeID,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

RatingBar descriptionBox(double rating) => RatingBar.builder(
  initialRating: rating,
  direction: Axis.horizontal,
  allowHalfRating: true,
  itemCount: 5,
  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
  itemBuilder: (context, _) => const Icon(
    Icons.star,
    color: Colors.amber,
  ),
  onRatingUpdate: (rating) {
  },
  ignoreGestures: true,
);

class JoubJumButton extends StatelessWidget {
  final String placeName;
  final String placeID;

  const JoubJumButton(
      {super.key, required this.placeID, required this.placeName});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: appBarColor,
        foregroundColor: bodyColor,
      ),
      onPressed: () {
        navigateToNextScreen(
            context, CreateJoubJumPage(location: placeName, placeId: placeID));
      },
      child: const Text("+ JoubJum"),
    );
  }
}

Widget pictureSlider(List photoUrl) {
  return Container(
    alignment: Alignment.topRight,
    height: 100,
    child: ListView.separated(
      itemCount: photoUrl.length,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      separatorBuilder: (context, index) => const SizedBox(width: 18),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.network(photoUrl[index], fit: BoxFit.cover),
        );
      },
    ),
  );
}
