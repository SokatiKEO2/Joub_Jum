import 'package:flutter/material.dart';
import 'package:joub_jum/pages/map_page.dart';
import 'package:joub_jum/pages/menu_bar_pages/Provider.dart';
import 'package:joub_jum/pages/menu_bar_pages/invitation.dart';
import 'package:provider/provider.dart';


void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => InvitationsAndJoubJumsState(),
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starter Template',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MapPage(),
    );
  }
}