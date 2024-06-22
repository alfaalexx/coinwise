import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
            onPressed: () {},
            child: Text(
              'Simpan',
              style: TextStyle(
                  color: Color(0xFF023E8A), fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
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
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey,
                            child: Center(
                                child: Icon(Icons.add_a_photo, size: 50)),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextButton(
                        onPressed: () {},
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                TextField(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                TextField(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Divider(
                  color: Colors.grey, // Warna garis
                  thickness: 1, // Ketebalan garis
                ),
                SizedBox(height: 5),
                Text(
                  'Instagram',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                TextField(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                TextField(
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
