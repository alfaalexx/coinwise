import 'package:coinwise/on_boarding/part_1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/part_1',
      routes: {
        '/part_1': (context) => part_1(),
        // ... (rute lainnya)
      },
      // Pastikan untuk menambahkan onUnknownRoute jika Anda tidak mengaturnya
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Rute tidak ditemukan: ${settings.name}'),
            ),
          ),
        );
      },
    );
  }
}
