import 'package:flutter/material.dart';

class DrawerContentPage extends StatefulWidget {
  const DrawerContentPage({super.key});

  @override
  State<DrawerContentPage> createState() => _DrawerContentPageState();
}

class _DrawerContentPageState extends State<DrawerContentPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
            color: Colors.transparent, // Background color
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF023E8A), // Warna border
                      width: 2, // Lebar border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset("assets/images/defaultAvatar.png"),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 55, left: 16),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          "Username",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Status Member",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            onTap: () {
              // Navigate to the home page
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('Berita'),
            onTap: () {
              // Navigate to the news page
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to the settings page
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
