import 'package:flutter/material.dart';
import 'package:joub_jum/consts.dart';
import 'package:joub_jum/components/location_list_tile.dart';
import 'package:joub_jum/components/network_util.dart';
import 'package:joub_jum/models/autocomplete_prediction.dart';
import 'package:joub_jum/models/place_auto_complete_response.dart';
import 'package:joub_jum/models/fetch_place_data.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<AutocompletePrediction> placePrediction = [];

  Future<void> placeAutocomplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        '/maps/api/place/autocomplete/json',
        {"input": query, "key": GOOGLE_MAP_API_KEY});
    String? response = await NetworkUtil.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePrediction = result.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: placePrediction.length,
                itemBuilder: (context, index) => LocationListTile(
                    location: placePrediction[index].description!,
                    press: () {
                      var result = fetchPlace(placePrediction[index].placeId);
                      Navigator.pop(context, result);
                    }),
              ),
            ),
          ],
        ),
        backgroundColor: bodyColor,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SizedBox(
            height: 40.0, // Set the desired height here
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
              child: TextField(
                onChanged: (value) {
                  placeAutocomplete(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Search your location',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 15.0),
                textAlign: TextAlign.justify,
                autofocus: true,
              ),
            ),
          ),
        ));
  }
}
