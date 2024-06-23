import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _instagramLinkController =
      TextEditingController();
  final TextEditingController _linkedinLinkController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  String? displayName;
  String? email;
  String? instagramLink;
  String? linkedinLink;
  String? aboutMe;
  String? profileImageUrl;
  bool isLoading = false;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    // Periksa status otentikasi pengguna.
    loadProfileData();
  }

  @override
  void dispose() {
    // Hentikan listener atau callback lainnya di sini
    _nameController.dispose();
    _emailController.dispose();
    _instagramLinkController.dispose();
    _linkedinLinkController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

  void loadProfileData() {
    final User? user = _auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      FirebaseFirestore.instance.collection('profile').doc(uid).get().then(
        (doc) {
          if (doc.exists) {
            final data = doc.data() as Map<String, dynamic>;
            setState(() {
              displayName = data['username'];
              email = data['email'];
              instagramLink = data['instagram_link'];
              linkedinLink = data['linkedin_link'];
              aboutMe = data['about_me'];
              profileImageUrl = data['profile_image'];
              _nameController.text = displayName ?? '';
              _emailController.text = email ?? '';
              _instagramLinkController.text = instagramLink ?? '';
              _linkedinLinkController.text = linkedinLink ?? '';
              _aboutMeController.text = aboutMe ?? '';
            });
          }
        },
      );
    }
  }

  Future<void> _uploadProfileImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final User? user = _auth.currentUser;
    if (user == null) {
      // Handle the case where there is no authenticated user.
      return;
    }

    Reference reference = _storage.ref().child(
        'profile_images/${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
    UploadTask uploadTask = reference.putFile(File(pickedFile.path));

    try {
      await uploadTask.whenComplete(() async {
        final String imageUrl = await reference.getDownloadURL();

        setState(() {
          isLoading = false;
          profileImageUrl = imageUrl;
        });
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading profile image: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  void updateProfile() {
    final User? user = _auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      final updatedName = _nameController.text;
      final updatedEmail = _emailController.text;
      final updatedLinkedinLink = _linkedinLinkController.text;
      final updatedInstagramLink = _instagramLinkController.text;
      final updatedAboutMe = _aboutMeController.text;

      setState(() {
        isLoading = true;
      });

      FirebaseFirestore.instance.collection('profile').doc(uid).set({
        'uid': uid,
        'username': updatedName,
        'email': updatedEmail,
        'linkedin_link': updatedLinkedinLink,
        'instagram_link': updatedInstagramLink,
        'about_me': updatedAboutMe,
        'profile_image': profileImageUrl,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );

        setState(() {
          isLoading = false;
          displayName = updatedName;
          email = updatedEmail;
          linkedinLink = updatedLinkedinLink;
          instagramLink = updatedInstagramLink;
          aboutMe = updatedAboutMe;
        });

        Navigator.pop(context, true);
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: $error'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5EBF3),
      appBar: AppBar(
        backgroundColor: const Color(0xffE5EBF3),
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Edit Profil",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: updateProfile,
            child: Text(
              'Simpan',
              style: TextStyle(
                  color: Color(0xFF023E8A), fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: 1000,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    50), // This creates a circular shape
                                child: profileImageUrl != null
                                    ? CachedNetworkImage(
                                        imageUrl: profileImageUrl!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 100,
                                          height: 100,
                                          color: Colors.grey,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          width: 100,
                                          height: 100,
                                          color: Colors.grey,
                                          child:
                                              Center(child: Icon(Icons.error)),
                                        ),
                                      )
                                    : Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey,
                                        child: Center(
                                            child: Icon(Icons.add_a_photo,
                                                size: 50)),
                                      ),
                              ),
                            ),
                            SizedBox(height: 5),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Choose an option"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _uploadProfileImage(
                                                ImageSource.camera);
                                          },
                                          child: Text("Camera"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _uploadProfileImage(
                                                ImageSource.gallery);
                                          },
                                          child: Text("Gallery"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Edit Foto Profil',
                                style: TextStyle(
                                  color: Color(0xFF023E8A),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Nama Lengkap',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Nama Lengkap Anda',
                          filled: true,
                          fillColor: Color(0xffE5EBF3),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Deskripsi',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _aboutMeController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Deskripsi tentang Anda',
                          filled: true,
                          fillColor: Color(0xffE5EBF3),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Media Sosial',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Divider(
                        color: Colors.grey, // Warna garis
                        thickness: 1, // Ketebalan garis
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Instagram',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _instagramLinkController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Link Instagram Anda',
                          filled: true,
                          fillColor: Color(0xffE5EBF3),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'LinkedIn',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _linkedinLinkController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Link LinkedIn Anda',
                          filled: true,
                          fillColor: Color(0xffE5EBF3),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
