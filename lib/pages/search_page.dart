import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/components/location_list_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // backgroundColor: appBarColor,
            elevation: 0,
            title: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const SizedBox(
                height: 40.0, // Set the desired height here
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search your location',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    textAlign: TextAlign.justify,
                    autofocus: true,
                  ),
                ),
              ),
            )),
        body: Container(
          // color: menuBarColor,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                // Adjust the vertical padding as needed
              ),
              LocationListTile(
                press: () {},
                location: "Banasree, Dhaka, Bangladesh",
              ),
            ],
          ),
        ));
  }
}
