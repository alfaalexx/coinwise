import 'package:coinwise/pages/beranda/berandaPage.dart';
import 'package:coinwise/pages/berita/beritaPage.dart';
import 'package:coinwise/pages/berita/news_page.dart';
import 'package:coinwise/pages/course/coursePage.dart';
import 'package:coinwise/pages/komunitas/komunitasPage.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    BerandaPage(),
    CoursePage(),
    NewsPage(),
    KomunitasPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Color.fromRGBO(2, 62, 138, 1),
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Image.asset(
                    "assets/images/beranda_aktif.png",
                    color: Color.fromRGBO(2, 62, 138, 1),
                  )
                : Image.asset("assets/images/beranda_icon.png"),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Image.asset(
                    "assets/images/course_icon.png",
                    color: Color.fromRGBO(2, 62, 138, 1),
                  )
                : Image.asset("assets/images/course_icon.png"),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? Image.asset(
                    "assets/images/berita_icon.png",
                    color: Color.fromRGBO(2, 62, 138, 1),
                  )
                : Image.asset("assets/images/berita_icon.png"),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? Image.asset(
                    "assets/images/komunitas.png",
                    color: Color.fromRGBO(2, 62, 138, 1),
                  )
                : Image.asset("assets/images/komunitas.png"),
            label: 'Komunitas',
          ),
        ],
      ),
    );
  }
}
