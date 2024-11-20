import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joub_jum/firebase_options.dart';
import 'package:joub_jum/pages/auth_pages/register_screen.dart';
import 'package:joub_jum/pages/map_page.dart';
import 'package:joub_jum/pages/menu_bar_pages/Provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => InvitationsAndJoubJumsState(),
      child: const MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starter Template',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        // Show loading indicator while waiting for authentication status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // If user is signed in, show the MapPage or main content
        if (snapshot.hasData) {
          return const MapPage();
        }
        // If user is not signed in, show the RegisterPage
        else {
          return const RegisterPage();
        }
      },
    );
  }
}
