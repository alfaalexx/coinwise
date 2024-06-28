import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinwise/pages/auth/loginPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

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

  // Function to log out the user
  void _logout(BuildContext context) async {
    // Show a confirmation dialog
    bool confirmLogout = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          backgroundColor: Color.fromRGBO(248, 248, 248, 1),
          title: Text('Konfirmasi Keluar'),
          content: Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(232, 232, 232, 1))),
              onPressed: () {
                // Jika pengguna memilih "Ya", set nilai true
                Navigator.of(context).pop(true);
              },
              child: Text('Ya', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(232, 232, 232, 1))),
              onPressed: () {
                // Jika pengguna memilih "Tidak", set nilai false
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Tidak',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
    // Jika pengguna mengkonfirmasi keluar, hapus data login dan navigasikan ke halaman login
    if (confirmLogout == true) {
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
    }
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
            margin: const EdgeInsets.only(top: 30.0),
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
            color: Colors.transparent, // Background color
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
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
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/defaultAvatar.png"),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 25, left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Non-Member",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color.fromRGBO(131, 131, 131, 1),
            height: 1,
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
            leading: const Icon(Icons.history),
            title: const Text('Riwayat'),
            onTap: () {
              // Navigate to the news page
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setelan'),
            onTap: () {
              // Navigate to the settings page
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 420,
          ),
          ListTile(
            leading:
                const Image(image: AssetImage("assets/images/logout_icon.png")),
            title: const Text(
              'Keluar',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16),
            ),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
