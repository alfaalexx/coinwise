import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinwise/pages/auth/loginPage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DrawerContentPage extends StatefulWidget {
  const DrawerContentPage({super.key});

  @override
  State<DrawerContentPage> createState() => _DrawerContentPageState();
}

class _DrawerContentPageState extends State<DrawerContentPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String displayName = "Loading...";
  String email = "Loading...";
  String profileImageUrl = "";

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle unauthenticated user if needed
    }
    loadProfileData();
  }

  void loadProfileData() async {
    final User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      final String currentUid = currentUser.uid;
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('profile')
          .doc(currentUid)
          .get();

      if (documentSnapshot.exists) {
        var data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          displayName = data['username'];
          email = data['email'];
          profileImageUrl = data['profile_image'] ?? "";
        });
      } else {
        print('Data profil tidak ditemukan');
      }
    }
  }

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
                      child: profileImageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: profileImageUrl,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/defaultAvatar.png"),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 55, left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          displayName,
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
              _auth.signOut();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }), (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logout Successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
