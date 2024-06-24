import 'package:coinwise/pages/komunitas/komunitasPage.dart';
import 'package:coinwise/pages/on_boarding/part_1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coinwise/pages/splash/splash_screen.dart';
import 'package:coinwise/pages/dashboard/dashboard_screen.dart'; // Import DashboardScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return SplashScreen(
                onInitializationComplete: () {
                  // Navigasi ke layar Login setelah splash screen selesai
                  navigatorKey.currentState?.pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const part_1(),
                    ),
                  );
                },
              );
            } else {
              return SplashScreen(
                onInitializationComplete: () {
                  // Navigasi ke halaman Dashboard setelah splash screen selesai
                  navigatorKey.currentState?.pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const DashboardScreen(),
                    ),
                  );
                },
              );
            }
          } else {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
