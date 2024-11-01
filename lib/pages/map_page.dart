import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joub_jum/consts.dart';
import 'package:location/location.dart';
import 'package:joub_jum/pages/search_page.dart';
import 'package:joub_jum/pages/menu_bar_pages/account.dart';
import 'package:joub_jum/pages/menu_bar_pages/friend.dart';
import 'package:joub_jum/pages/menu_bar_pages/invitation.dart';
import 'package:joub_jum/pages/menu_bar_pages/joub_jum.dart';
import 'package:joub_jum/pages/menu_bar_pages/recommendation.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();

  LatLng? _selectedP;
  LatLng? _currentP;
  String? _photoUrl;

  double _buttonBottomPadding = 84;

  Map<PolylineId, Polyline> polylines = {};
  late BitmapDescriptor currentLocationMarker;

  @override
  void initState() {
    //TODO setState for Polyline ONLY after they selected a location
    setCustomMapPin();
    super.initState();
    getLocationUpdate().then((_) {
      _cameraToPosition(_currentP!);
    });
  }
  void setCustomMapPin() async {
    currentLocationMarker = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(20, 20), devicePixelRatio: 2.5),
        'assets/icons/current_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: buildDrawer(),
      appBar: appBar(),
      body: _currentP == null
          ? const Center(
        child: Text("Loading..."),
      )
          : Stack(
        children: [
          GoogleMap(
            //when map is created, we have access to controller
            onMapCreated: ((GoogleMapController controller) =>
                _mapController.complete(controller)),
            initialCameraPosition:
            CameraPosition(target: _currentP!, zoom: 13),
            markers: {
              //Current location of user
              Marker(
                  markerId: const MarkerId("_currentLocation"),
                  icon: currentLocationMarker,
                  position: _currentP!),
              if (_selectedP != null) // Check if _destination is not null
                Marker(
                  markerId: const MarkerId("_destinationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _selectedP!,
                ),
            },
            polylines: Set<Polyline>.of(polylines.values),
          ),
          buildCurrentLocationButton(),
        ],
      ),
    );
  }

  Stack buildCurrentLocationButton() {
    return Stack(children: [
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(bottom: _buttonBottomPadding, right: 25),
          child: FloatingActionButton(
            onPressed: () {
              _cameraToPosition(_currentP!);
            },
            child: const Icon(Icons.my_location),
          ),
        ),
      ),
    ]);
  }

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: buttonColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('User1', style: TextStyle(color: Colors.black,),),
            accountEmail: Text('user1@gmail.com', style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                    'https://media.istockphoto.com/id/2151669184/vector/vector-flat-illustration-in-grayscale-avatar-user-profile-person-icon-gender-neutral.jpg?s=612x612&w=0&k=20&c=UEa7oHoOL30ynvmJzSCIPrwwopJdfqzBs0q69ezQoM8=',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: menuBarColor
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: const Text('Account'),
            onTap: () {
              navigateToNextScreen(context, const AccountPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.recommend_rounded),
            title: const Text('Recommendation'),
            onTap: () {
              navigateWithData(context, const RecommendationPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.insert_invitation_rounded),
            title: const Text('Invitation'),
            onTap: () {
              navigateToNextScreen(context, const InvitationPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.map_rounded),
            title: const Text('JoubJum'),
            onTap: () {
              navigateToNextScreen(context, const JoubJumPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.people_alt_rounded),
            title: const Text('Friend'),
            onTap: () {
              navigateToNextScreen(context, const FriendPage());
            },
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: appBarColor,
      elevation: 0,
      title: const Text(
        'Location',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      centerTitle: true,
      leading: Builder(builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            navigateWithData(context, const SearchPage());
          },
        ),
      ],
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 14);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdate() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check if location services are enabled on user's device, otherwise request the user to enable them
    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if the app has location permission, If location permission is denied, request the user to grant permission
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Listen for location changes
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        if (mounted) {
          setState(() {
            _currentP =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          });
        }
      }
    });
  }

  //TODO: Change point to _currentP and Selected Location
  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinate = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: GOOGLE_MAP_API_KEY,
        request: PolylineRequest(
            origin: PointLatLng(_currentP!.latitude, _currentP!.longitude),
            destination:
            PointLatLng(_selectedP!.latitude, _selectedP!.longitude),
            mode: TravelMode.driving));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinate.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinate;
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinate) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blue,
        points: polylineCoordinate,
        width: 4);
    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<void> navigateWithData(BuildContext context, Widget targetPage) async {
    final result = await Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => targetPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));

    if (result != null) {
      Navigator.pop(context);
      setState(() {
        _selectedP = result[0];
        _photoUrl = result[1];
      });
      _cameraToPosition(_selectedP!).then((_) {
        getPolylinePoints().then((coordinate) {
          generatePolylineFromPoints(coordinate);
        });
      });
    }
  }
}

