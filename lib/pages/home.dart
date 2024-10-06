import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(),
      //backgroundColor: Theme.of(context).primaryColor,
    );
  }
}