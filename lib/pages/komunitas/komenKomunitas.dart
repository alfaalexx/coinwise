import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Komenkomunitas extends StatefulWidget {
  const Komenkomunitas({super.key});

  @override
  State<Komenkomunitas> createState() => _KomenkomunitasState();
}

class _KomenkomunitasState extends State<Komenkomunitas> {
  final ScrollController _scrollController = ScrollController();
  bool _showInput = true;

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

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 235, 243, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
        title: Text(
          "Postingan",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: 420,
                height: 200,
                decoration: BoxDecoration(color: Colors.white),
                child: ListView(
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                            height: 28,
                            width: 190,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
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
              // container selanjut nya belum pakai extract widget
              Container(
                width: 420,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 6, 0),
                          child: CircleAvatar(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(2, 15, 5, 6),
                              padding: EdgeInsets.all(8),
                              width: 340,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(229, 235, 243, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reza Rahardian",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "founder starup",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color:
                                            Color.fromRGBO(131, 131, 131, 1)),
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
                                        fontWeight: FontWeight.w400,
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
                                      color: Color.fromRGBO(131, 131, 131, 1)),
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
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      "Balas",
                                      style: TextStyle(
                                          color: Color.fromRGBO(2, 62, 138, 1),
                                          fontWeight: FontWeight.w400,
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
                              margin: EdgeInsets.fromLTRB(10, 4, 0, 5),
                              width: 75,
                              height: 22,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(2, 62, 138, 1)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 2, 6, 6),
                                child: Text(
                                  "2 Basalan",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
                          padding: const EdgeInsets.fromLTRB(10, 15, 6, 0),
                          child: CircleAvatar(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(2, 15, 5, 6),
                              padding: EdgeInsets.all(8),
                              width: 340,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(229, 235, 243, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reza Rahardian",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "founder starup",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color:
                                            Color.fromRGBO(131, 131, 131, 1)),
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
                                        fontWeight: FontWeight.w400,
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
                                      color: Color.fromRGBO(131, 131, 131, 1)),
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
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      "Balas",
                                      style: TextStyle(
                                          color: Color.fromRGBO(2, 62, 138, 1),
                                          fontWeight: FontWeight.w400,
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
                              margin: EdgeInsets.fromLTRB(10, 4, 0, 5),
                              width: 75,
                              height: 22,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(2, 62, 138, 1)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 2, 6, 6),
                                child: Text(
                                  "2 Basalan",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
                          padding: const EdgeInsets.fromLTRB(10, 15, 6, 0),
                          child: CircleAvatar(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(2, 15, 5, 6),
                              padding: EdgeInsets.all(8),
                              width: 340,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(229, 235, 243, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reza Rahardian",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "founder starup",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color:
                                            Color.fromRGBO(131, 131, 131, 1)),
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
                                        fontWeight: FontWeight.w400,
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
                                      color: Color.fromRGBO(131, 131, 131, 1)),
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
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      "Balas",
                                      style: TextStyle(
                                          color: Color.fromRGBO(2, 62, 138, 1),
                                          fontWeight: FontWeight.w400,
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
                              margin: EdgeInsets.fromLTRB(10, 4, 0, 5),
                              width: 75,
                              height: 22,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(2, 62, 138, 1)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 2, 6, 6),
                                child: Text(
                                  "2 Basalan",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
              height: 60,
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
