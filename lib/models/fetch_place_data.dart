import 'dart:convert';
import 'package:joub_jum/consts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<List> fetchPlace(String? placeID) async {
  final String placeSearchURL =
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$GOOGLE_MAP_API_KEY';
  final response = await http.get(Uri.parse(placeSearchURL));
  if (response.statusCode == 200) {
    final placeDetails = json.decode(response.body)['result'];

    // Extract latitude and longitude
    final lat = placeDetails['geometry']['location']['lat'];
    final lng = placeDetails['geometry']['location']['lng'];

    // Extract rating, handle if not present
    double rating = placeDetails['rating'] ?? 0;

    // Extract photos, handle if not present
    List<dynamic> photos = [];
    if (placeDetails['photos'] != null) {
      final photosInDetails = placeDetails['photos'] as List;
      for (var i = 0;
          i < (photosInDetails.length < 5 ? photosInDetails.length : 5);
          i++) {
        final photoReference = photosInDetails[i]['photo_reference'];
        String photoData = getPlacePhotoData(photoReference);
        photos.add(photoData);
      }
    }else{
      photos.add("https://i0.wp.com/www.bishoprook.com/wp-content/uploads/2021/05/placeholder-image-gray-16x9-1.png?ssl=1");
    }

    // Extract location and place name
    LatLng selectedLocation = LatLng(lat, lng);
    String placeName = placeDetails['name'];

    // Prepare the data to return
    List<dynamic> locationAndPhotoData = [
      selectedLocation,
      photos,
      placeName,
      placeID,
      rating
    ];

    return locationAndPhotoData;
  } else {
    throw Exception('Failed to load place details');
  }
}

String getPlacePhotoData(String? photoReference) {
  const maxHeight = 200;
  const maxWidth = 200;
  final String url =
      "https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth&maxheight=$maxHeight&photoreference=$photoReference&key=$GOOGLE_MAP_API_KEY";
  return url;
}
