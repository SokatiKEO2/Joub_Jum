import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';

Widget floatingCollapsed() {
  return Container(
    decoration: const BoxDecoration(
      color: appBarColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
    ),
    margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    child: const Center(
      child: Icon(Icons.arrow_upward),
    ),
  );
}

Widget floatingPanel(List photoUrl, String placeName) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      boxShadow: [
        BoxShadow(
          blurRadius: 20.0,
          color: Colors.grey,
        ),
      ],
    ),
    margin: const EdgeInsets.all(24.0),
    child: Column(
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8.0), // Optional padding
          child: Text(
            placeName, // Example title
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        pictureSlider(photoUrl),
      ],
    ),
  );
}


Widget pictureSlider(List photoUrl) {
  return Container(
    alignment: Alignment.topRight,
    height: 100,
    child: ListView.separated(
      itemCount: photoUrl.length,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      separatorBuilder: (context, index) => const SizedBox(width: 18),
      itemBuilder: (context, index) {
        return Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(photoUrl[index], fit: BoxFit.cover),
          ),
        );
      },
    ),
  );
}



//
// borderRadius: BorderRadius.circular(24),
// child: SizedBox.fromSize(
// size: Size.fromRadius(48),
// child: Image.network(
// photoUrl[index],
// fit: BoxFit.cover,
// ),
// ),