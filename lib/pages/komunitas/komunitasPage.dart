import 'package:coinwise/pages/komunitas/komenKomunitas.dart';
import 'package:coinwise/pages/komunitas/postKomunitas.dart';
import 'package:coinwise/pages/profile/profilePage.dart';
import 'package:coinwise/widget/drawer_content_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeago/timeago.dart' as timeago;

class KomunitasPage extends StatefulWidget {
  const KomunitasPage({super.key});

  @override
  State<KomunitasPage> createState() => _KomunitasPageState();
}

class _KomunitasPageState extends State<KomunitasPage> {
  // Membuat GlobalKey untuk ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String displayName = "Loading...";
  String email = "Loading...";
  String profileImageUrl = "";
  String searchQuery = "";

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
          profileImageUrl = data['profile_image'] ??
              ""; // Ambil URL gambar profil jika tersedia
        });
      } else {
        print('Data profil tidak ditemukan');
      }
    }
  }

  Future<Map<String, dynamic>?> getUserProfileData(String uid) async {
    try {
      DocumentSnapshot userProfileSnapshot =
          await FirebaseFirestore.instance.collection('profile').doc(uid).get();

      if (userProfileSnapshot.exists) {
        return userProfileSnapshot.data() as Map<String, dynamic>?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user profile data: $e');
      return null;
    }
  }

  // Function untuk mengubah timestamp menjadi format tanggal
  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      DateTime dateTime = timestamp.toDate();
      return timeago
          .format(dateTime); // Ini akan menghasilkan format "time ago"
    }
    return '';
  }

  void performSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //button untuk ke halaman post komunitas
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Postkomunitas(),
              ));
        },
        backgroundColor: Color.fromRGBO(2, 62, 138, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color.fromRGBO(229, 235, 243, 1),
      key: _scaffoldKey,
      drawer: DrawerContentPage(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: IconButton(
            icon: Image.asset('assets/images/icon_menu.png'),
            onPressed: () {
              // Menggunakan GlobalKey untuk membuka drawer
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        title: Container(
          height: 40,
          child: TextField(
            onChanged: performSearch,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Cari...",
                hintStyle: TextStyle(
                    color: Color.fromRGBO(139, 139, 139, 1), height: 3.5),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {
                //navigator ke profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(30.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: profileImageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: profileImageUrl,
                        placeholder: (context, url) => SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: Colors.black,
                            )),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )
                    : Image.asset("assets/images/defaultAvatar.png",
                        width: 40, height: 40),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('post_community')
              .orderBy('created_at', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final posts = snapshot.data!.docs;

            List<DocumentSnapshot> filteredPosts = posts.where((post) {
              var data = post.data() as Map<String, dynamic>;
              String postTitle = data['postTitle'] ?? '';
              return postTitle
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());
            }).toList();

            return ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                var post = filteredPosts[index];
                var data = post.data() as Map<String, dynamic>;

                // Dapatkan uid pengguna dari data postingan
                String uid = data['uid'];

                return FutureBuilder(
                  future: getUserProfileData(uid),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('Profile data not found'));
                    }

                    var userProfile = snapshot.data!;
                    String userName = userProfile['username'] ?? 'User';
                    bool isMember = userProfile['isMember'] ?? false;

                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      radius: 20,
                                      child: ClipOval(
                                        child: userProfile['profile_image'] !=
                                                    null &&
                                                userProfile['profile_image']
                                                    .isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl: userProfile[
                                                    'profile_image'],
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/images/defaultAvatar.png'),
                                                fit: BoxFit.cover,
                                                width: 40,
                                                height: 40,
                                              )
                                            : Image.asset(
                                                'assets/images/defaultAvatar.png',
                                                fit: BoxFit.cover,
                                                width: 40,
                                                height: 40,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "${isMember ? "Member" : "Non-Member"} • ${_formatTimestamp(data['created_at'])}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromRGBO(
                                                131, 131, 131, 1)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 3),
                                child: Text(
                                  data['postTitle'] ?? '',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 3),
                                child: Text(
                                  data['postDescription'] ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 5,
                                ),
                              ),
                            ),
                            Divider(
                              indent: 15,
                              endIndent: 15,
                              color: Color.fromRGBO(139, 139, 139, 1),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.thumb_up_alt_outlined),
                                      SizedBox(width: 5),
                                      Text("50k"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.remove_red_eye_outlined),
                                      SizedBox(width: 5),
                                      Text("100k"),
                                    ],
                                  ),
                                ),
                                //button ke halaman komen komunitas
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 2, 15, 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Komenkomunitas(postId: post.id),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                                      height: 28,
                                      width: 190,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(229, 235, 243, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Tambahkan Komentar...",
                                        style: TextStyle(
                                          fontSize: 12,
                                          letterSpacing: 0.3,
                                          color:
                                              Color.fromRGBO(131, 131, 131, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }),
    );
  }
}
