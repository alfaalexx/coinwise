import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Komenkomunitas extends StatefulWidget {
  const Komenkomunitas({super.key, required this.postId});
  final String postId;

  @override
  State<Komenkomunitas> createState() => _KomenkomunitasState();
}

class _KomenkomunitasState extends State<Komenkomunitas> {
  final ScrollController _scrollController = ScrollController();
  bool _showInput = true;

  String? getCurrentUserUid() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_showInput) {
        setState(() {
          _showInput = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_showInput) {
        setState(() {
          _showInput = true;
        });
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

  void _deletePostCommunity(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus Postingan'),
          content: Text('Apakah Anda yakin ingin menghapus postingan ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                // Lakukan penghapusan postingan
                try {
                  FirebaseFirestore.instance
                      .collection('post_community')
                      .doc(widget.postId)
                      .get()
                      .then((snapshot) {
                    if (snapshot.exists) {
                      var data = snapshot.data()!;
                      String imageUrl = data['postCommunityImage'];

                      // Hapus gambar dari Firebase Storage jika ada
                      if (imageUrl != null && imageUrl != 'noImage') {
                        FirebaseStorage.instance
                            .refFromURL(imageUrl)
                            .delete()
                            .then((_) {
                          // Hapus dokumen dari Firestore setelah berhasil menghapus gambar
                          FirebaseFirestore.instance
                              .collection('post_community')
                              .doc(widget.postId)
                              .delete()
                              .then((_) {
                            // Hapus berhasil, tambahkan logika sesuai kebutuhan
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Postingan berhasil dihapus'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            // Contoh: kembali ke halaman sebelumnya setelah menghapus
                            Navigator.of(context).pop();
                          }).catchError((error) {
                            // Error ketika menghapus dokumen
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Gagal menghapus postingan: $error'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          });
                        }).catchError((error) {
                          // Error ketika menghapus gambar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Gagal menghapus gambar: $error'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        });
                      } else {
                        // Hapus dokumen dari Firestore jika tidak ada gambar
                        FirebaseFirestore.instance
                            .collection('post_community')
                            .doc(widget.postId)
                            .delete()
                            .then((_) {
                          // Hapus berhasil, tambahkan logika sesuai kebutuhan
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Postingan berhasil dihapus'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // Contoh: kembali ke halaman sebelumnya setelah menghapus
                          Navigator.of(context).pop();
                        }).catchError((error) {
                          // Error ketika menghapus dokumen
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Gagal menghapus postingan: $error'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        });
                      }
                    }
                  });
                } catch (e) {
                  print('Error deleting post: $e');
                  // Handle error
                }

                Navigator.of(dialogContext).pop(); // Tutup dialog konfirmasi
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? currentUserUid = getCurrentUserUid();
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 235, 243, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Postingan",
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        actions: <Widget>[
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('post_community')
                .doc(widget.postId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Menampilkan loading atau placeholder jika sedang memuat
                return CircularProgressIndicator();
              }

              var data = snapshot.data!.data() as Map<String, dynamic>;
              String postCreatorUid = data['uid'];

              // Memeriksa apakah pengguna saat ini adalah pemilik postingan
              bool canEditDelete =
                  currentUserUid != null && currentUserUid == postCreatorUid;

              // Menampilkan tombol delete hanya jika pengguna saat ini adalah pemilik postingan
              if (canEditDelete) {
                return IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deletePostCommunity(context);
                  },
                );
              } else {
                return SizedBox(); // Jika bukan pemilik postingan, jangan tampilkan tombol delete
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('post_community')
                  .doc(widget.postId)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var data = snapshot.data!.data() as Map<String, dynamic>;

                String uid = data['uid'];

                return FutureBuilder(
                    future: getUserProfileData(uid),
                    builder: (context,
                        AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return Center(child: Text('Profile data not found'));
                      }

                      var userProfile = snapshot.data!;
                      String userName = userProfile['username'] ?? 'User';
                      return ListView(
                        controller: _scrollController,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            decoration: BoxDecoration(color: Colors.white),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 5),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey[200],
                                          radius: 20,
                                          child: ClipOval(
                                            child: userProfile[
                                                            'profile_image'] !=
                                                        null &&
                                                    userProfile['profile_image']
                                                        .isNotEmpty
                                                ? CachedNetworkImage(
                                                    imageUrl: userProfile[
                                                        'profile_image'],
                                                    placeholder: (context,
                                                            url) =>
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
                                            "Wirausaha • ${_formatTimestamp(data['created_at'])}",
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
                                // Menampilkan gambar jika tersedia
                                if (data['postCommunityImage'] != 'noImage' &&
                                    data['postCommunityImage']!.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        14, 14, 0, 14),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: data['postCommunityImage']!,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                // Menampilkan placeholder jika gambar tidak tersedia

                                Divider(
                                  indent: 15,
                                  endIndent: 15,
                                  color: Color.fromRGBO(139, 139, 139, 1),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 0, 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.thumb_up_alt_outlined),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("50k"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.remove_red_eye_outlined),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("100k"),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 2, 15, 10),
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 5, 0, 5),
                                        height: 28,
                                        width: 190,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Tambahkan Komentar...",
                                          style: TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.3,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 420,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 6, 0),
                                      child: CircleAvatar(),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                2, 15, 5, 6),
                                            padding: EdgeInsets.all(8),
                                            width: 340,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    229, 235, 243, 1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Reza Rahardian",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "founder starup",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Color.fromRGBO(
                                                          131, 131, 131, 1)),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  "Untuk  itu,  diperlukan  pemahaman  yang "
                                                  "baik  bagi  masyarakat  termasuk manfaat, "
                                                  "potensi,  dan  risiko  dari  perdagangan "
                                                  "aset  kripto. Biar tidak salah prediksinya berinvestasi",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "3h ago",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Color.fromRGBO(
                                                        131, 131, 131, 1)),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              TextButton(
                                                  onPressed: () {},
                                                  style: TextButton.styleFrom(
                                                    minimumSize: Size.zero,
                                                    padding: EdgeInsets.zero,
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  child: Text(
                                                    "Balas",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            2, 62, 138, 1),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12),
                                                  )),
                                              SizedBox(width: 205),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.thumb_up_alt_outlined,
                                                    size: 20,
                                                  ),
                                                  Text(" 33")
                                                ],
                                              )
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 4, 0, 5),
                                            width: 75,
                                            height: 22,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromRGBO(
                                                    2, 62, 138, 1)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 2, 6, 6),
                                              child: Text(
                                                "2 Basalan",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              }),
          // Input komentar
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: _showInput ? 0 : -60,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Color.fromRGBO(217, 217, 217, 1)))),
              padding: EdgeInsets.fromLTRB(20, 12, 0, 12),
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(229, 235, 243, 1),
                          hintText: "Tuliskan komentar...",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              height: 3.5,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/images/send.png",
                      height: 30,
                    ),
                    onPressed: () {
                      // Action for sending the comment
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
