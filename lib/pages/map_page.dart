import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:joub_jum/widgets/sliding_panel.dart';

import '../auth.dart';
import '../widgets/confirmation.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();
  final PanelController _panelController = PanelController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  LatLng? _selectedP;
  LatLng? _currentP;
  List? _photoUrl;
  String? userEmail;
  String? _placeName;
  double _buttonBottomPadding = 84;
  bool polylineDirection = false;

  String? _placeID;
  late double _sliderMaxHeight;

  Map<PolylineId, Polyline> polylines = {};
  late BitmapDescriptor currentLocationMarker;

  @override
  void initState() {
    //TODO setState for Polyline ONLY after they selected a location
    super.initState();
    setCustomMapPin();
    getCurrentUserEmail();
    getLocationUpdate().then((_) {
      _cameraToPosition(_currentP!);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      _sliderMaxHeight = screenHeight / 2;
    });
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      drawer: SizedBox(width: screenWidth / 1.5, child: buildDrawer()),
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
            backgroundColor: boxColor,
            foregroundColor: appBarColor,
            onPressed: () {
              _cameraToPosition(_currentP!);
            },
            child: const Icon(Icons.my_location),
          ),
        ),
      ),
      if (_selectedP != null)
        SlidingUpPanel(
          controller: _panelController,
          maxHeight: _sliderMaxHeight,
          renderPanelSheet: false,
          panel: floatingPanel(
              _photoUrl!, _placeName!, _placeID!, directionButton()),
          collapsed: floatingCollapsed(),
          defaultPanelState: PanelState.OPEN,
          onPanelSlide: (double position) {
            setState(() {
              _buttonBottomPadding = 84 + (0.8 * position * _sliderMaxHeight);
            });
          },
        ),
    ]);
  }

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: drawerBottom,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'User1',
              style: TextStyle(color: Colors.black, fontFamily: mainFont),
            ),
            accountEmail: Text(userEmail!,
                style:
                    const TextStyle(color: Colors.black, fontFamily: mainFont)),
            currentAccountPicture: const CircleAvatar(
              child: CircleAvatar(
                maxRadius: 60,
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage("https://en.vogue.me/wp-content/uploads/2022/03/Nicki-Minaj-Barbie-diamond-necklace-Ashna-Mehta.jpg"),
              ),
            ),
            decoration: const BoxDecoration(color: drawerTop),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_rounded),
            title: const Text(
              'Account',
              style: TextStyle(fontFamily: mainFont),
            ),
            onTap: () {
              navigateToNextScreen(context, const AccountPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.recommend_rounded),
            title: const Text(
              'Recommendation',
              style: TextStyle(fontFamily: mainFont),
            ),
            onTap: () {
              navigateWithData(context, const RecommendationPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.insert_invitation_rounded),
            title: const Text(
              'Invitation',
              style: TextStyle(fontFamily: mainFont),
            ),
            onTap: () {
              navigateWithData(context, const InvitationPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.map_rounded),
            title: const Text(
              'JoubJum',
              style: TextStyle(fontFamily: mainFont),
            ),
            onTap: () {
              navigateWithData(context, const JoubJumPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_alt_rounded),
            title: const Text(
              'Friend',
              style: TextStyle(fontFamily: mainFont),
            ),
            onTap: () {
              navigateToNextScreen(context, const FriendPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Sign Out',
              style: TextStyle(fontFamily: mainFont),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Confirmation(text: "sign out", function: () async {await AuthService().signOut(context: context);});
                  });
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
        style:
            TextStyle(color: Colors.black, fontSize: 25, fontFamily: mainFont),
      ),
      centerTitle: true,
      leading: Builder(builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu),
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
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
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
      setState(() {
        _selectedP = result[0];
        _photoUrl = result[1];
        _placeName = result[2];
        _placeID = result[3];
      });
      if (_scaffoldKey.currentState!.isDrawerOpen) {
        Navigator.of(context).pop();
      }
      _cameraToPosition(_selectedP!);
      if (polylineDirection) {
        getPolylinePoints().then((coordinate) {
          generatePolylineFromPoints(coordinate);
        });
      }
    }
  }

  //TODO add username as well
  Future<void> getCurrentUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email;
      });
    }
  }

  ElevatedButton directionButton() => ElevatedButton(
        onPressed: () {
          if (polylineDirection) {
            setState(() {
              polylineDirection = false;
              polylines = {};
            });
          } else {
            setState(() {
              polylineDirection = true;
            });
          }
          if (polylineDirection) {
            getPolylinePoints().then((coordinate) {
              generatePolylineFromPoints(coordinate);
            });
          }
          _panelController.close();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: appBarColor,
          foregroundColor: bodyColor,
        ),
        child: const Text("Direction"),
      );

  void setCustomMapPin() async {
    currentLocationMarker = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(20, 20), devicePixelRatio: 2.5),
        'assets/icons/current_marker.png');
  }
}
