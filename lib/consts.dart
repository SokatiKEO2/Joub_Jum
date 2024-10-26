import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const String GOOGLE_MAP_API_KEY = 'AIzaSyBVMeYfW8X9ZsiHk3gn2MO9Tj_FzFoJtUM';
const Color appBarColor = Color(0x255198255);
const Color menuBarColor = Color(0xFFcaffbf);
const Color buttonColor = Color(0xB0FFC6FF);
const Color boxColor = Color(0xffc8c8c8);


void navigateToNextScreen(BuildContext context, Widget targetPage) {
  Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => targetPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ));
}