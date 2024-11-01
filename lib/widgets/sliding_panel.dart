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

Widget floatingPanel(String photoUrl) {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]),
    margin: const EdgeInsets.all(24.0),
    child: Image.network(photoUrl)
  );
}
