import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cached_network_image/cached_network_image.dart';

class Postkomunitas extends StatefulWidget {
  const Postkomunitas({super.key});

  @override
  State<Postkomunitas> createState() => _PostkomunitasState();
}

class _PostkomunitasState extends State<Postkomunitas> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String postTitle = '';
  String postDescription = '';
  String uid = '';
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isSaving = false;

  final postTitleController = TextEditingController();
  final postDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserUID();
  }

  Future<void> _getUserUID() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImageSource? source = await _getImageSource();
    if (source != null) {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    }
  }

  Future<ImageSource?> _getImageSource() async {
    return await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose the image source'),
        actions: <Widget>[
          TextButton(
            child: Text('Camera'),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          TextButton(
            child: Text('Gallery'),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref('post_community_images/$uid/${Path.basename(imageFile.path)}');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> savePostCommunityData() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the required fields')),
      );
      return;
    }

    setState(() {
      _isSaving = true; // Set loading to true
    });

    String? postCommunityImageUrl = "noImage"; // Set default value

    if (_imageFile != null) {
      postCommunityImageUrl = await uploadImage(_imageFile!);
      if (postCommunityImageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image!')),
        );
        return;
      }
    }

    Map<String, dynamic> postCommunityData = {
      'postTitle': postTitle,
      'postTitle_lowercase': postTitle.toLowerCase(),
      'postDescription': postDescription,
      'uid': uid,
      'postCommunityImage': postCommunityImageUrl,
      'created_at': FieldValue.serverTimestamp(),
    };

    try {
      await _firestore.collection('post_community').add(postCommunityData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post Community added successfully!')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding Post Community: $e')),
      );
    } finally {
      setState(() {
        _isSaving = false; // Set loading to false regardless of the outcome
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      //button untuk ke Upload posting komunitas
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
          onPressed: () {
            _pickImage();
          },
          child: Image(image: AssetImage("assets/images/image_icon.png"))),
      backgroundColor: Color.fromRGBO(229, 235, 243, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
        elevation: 1,
        title: Text("Postingan Baru",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        actions: [
          GestureDetector(
            onTap: () {
              savePostCommunityData();
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
              width: 70,
              height: 35,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(2, 62, 138, 1),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  "Bagikan",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Judul",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              TextFormField(
                controller: postTitleController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Masukkan Judul Postingan Anda",
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) => setState(() => postTitle = value),
                validator: (value) {
                  // Tambahkan validator
                  if (value == null || value.isEmpty) {
                    return 'Post Community is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Deskripsi",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              TextFormField(
                controller: postDescriptionController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Masukkan Deskripsi Postingan Anda",
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                maxLines: null, // This allows the TextField to expand as needed
                minLines: 5, // This sets a minimum height for the TextField
                onChanged: (value) => setState(() => postDescription = value),
                validator: (value) {
                  // Tambahkan validator
                  if (value == null || value.isEmpty) {
                    return 'Post Community Description is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              _imageFile != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Gambar yang diupload",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
