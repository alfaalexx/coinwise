import 'package:coinwise/pages/komunitas/komenKomunitas.dart';
import 'package:coinwise/pages/komunitas/postKomunitas.dart';
import 'package:flutter/material.dart';

class KomunitasPage extends StatefulWidget {
  const KomunitasPage({super.key});

  @override
  State<KomunitasPage> createState() => _KomunitasPageState();
}

class _KomunitasPageState extends State<KomunitasPage> {
  // Membuat GlobalKey untuk ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Postkomunitas(),
              ));
        },
        backgroundColor: Color.fromRGBO(2, 62, 138, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color.fromRGBO(229, 235, 243, 1),
      key: _scaffoldKey,
      drawer: Drawer(),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
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
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/notif_icon.png"),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // AWAL CARD KOMUNITAS
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: 420,
              height: 200,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: CircleAvatar(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Naya Rafeza",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Wirausaha • 12h",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 3),
                    child: Text(
                      "Berinvestasi dalam aset kripto mengandung risiko "
                      "yang cukup tinggi. Sesuai sifatnya, nilai aset kripto "
                      "sangat volatile, bisa saja mengalami peningkatan "
                      "maupun penurunan nilai yang sangat drastis dalam",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                        padding: const EdgeInsets.fromLTRB(10, 2, 15, 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Komenkomunitas(),
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                            height: 28,
                            width: 190,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(229, 235, 243, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Tambahkan Komentar...",
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.3,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // container selanjutnya belum pakai extract widget
            // AWAL CARD KOMUNITAS
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: 420,
              height: 140,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: CircleAvatar(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Aishiteru",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Mahasiswa • 20h",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 3),
                    child: Text(
                      "Rekomendasi course untuk pemula apa ya?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                        child: Row(
                          children: [
                            Icon(Icons.thumb_up_alt_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text("73k"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          children: [
                            Icon(Icons.remove_red_eye_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text("190k"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 15, 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Komenkomunitas(),
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                            height: 28,
                            width: 190,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(229, 235, 243, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Tambahkan Komentar...",
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.3,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // AWAL CARD KOMUNITAS
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: 420,
              height: 200,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: CircleAvatar(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Naya Rafeza",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Wirausaha • 12h",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 3),
                    child: Text(
                      "Berinvestasi dalam aset kripto mengandung risiko "
                      "yang cukup tinggi. Sesuai sifatnya, nilai aset kripto "
                      "sangat volatile, bisa saja mengalami peningkatan "
                      "maupun penurunan nilai yang sangat drastis dalam",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                        padding: const EdgeInsets.fromLTRB(10, 2, 15, 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Komenkomunitas(),
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                            height: 28,
                            width: 190,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(229, 235, 243, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Tambahkan Komentar...",
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.3,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // container selanjutnya belum pakai extract widget
            // AWAL CARD KOMUNITAS
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: 420,
              height: 200,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: CircleAvatar(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Naya Rafeza",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Wirausaha • 12h",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 3),
                    child: Text(
                      "Berinvestasi dalam aset kripto mengandung risiko "
                      "yang cukup tinggi. Sesuai sifatnya, nilai aset kripto "
                      "sangat volatile, bisa saja mengalami peningkatan "
                      "maupun penurunan nilai yang sangat drastis dalam",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                        padding: const EdgeInsets.fromLTRB(10, 2, 15, 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Komenkomunitas(),
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                            height: 28,
                            width: 190,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(229, 235, 243, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Tambahkan Komentar...",
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.3,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // container selanjutnya belum pakai extract widget
            // AWAL CARD KOMUNITAS
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: 420,
              height: 200,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: CircleAvatar(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Naya Rafeza",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Wirausaha • 12h",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 3),
                    child: Text(
                      "Berinvestasi dalam aset kripto mengandung risiko "
                      "yang cukup tinggi. Sesuai sifatnya, nilai aset kripto "
                      "sangat volatile, bisa saja mengalami peningkatan "
                      "maupun penurunan nilai yang sangat drastis dalam",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                        padding: const EdgeInsets.fromLTRB(10, 2, 15, 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Komenkomunitas(),
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                            height: 28,
                            width: 190,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(229, 235, 243, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Tambahkan Komentar...",
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.3,
                                  color: Color.fromRGBO(131, 131, 131, 1)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // container selanjutnya belum pakai extract widget
          ],
        ),
      ),
    );
  }
}
