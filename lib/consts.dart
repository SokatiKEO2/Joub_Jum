import 'package:flutter/material.dart';

const String GOOGLE_MAP_API_KEY = 'AIzaSyBVMeYfW8X9ZsiHk3gn2MO9Tj_FzFoJtUM';
const Color appBarColor = Color(0xbfc49450);

const Color drawerBottom = Color(0xFFe1d5c9);
const Color drawerTop = Color(0xFFc49450);

const Color boxColor = Color(0xFFFAEBD7);
const Color bodyColor = Color(0xFFf6f6ee);

const Color duskyGreen = Color(0xFF556B2F);
const Color antiqueColor = Color(0xFFFAEBD7);

const String mainFont = "Raritas";
const Color textForeground = Colors.black;


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

