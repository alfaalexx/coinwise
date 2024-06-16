import 'package:coinwise/pages/on_boarding/part_2.dart';
import 'package:flutter/material.dart';

class part_1 extends StatefulWidget {
  const part_1({super.key});

  @override
  State<part_1> createState() => _part_1State();
}

class _part_1State extends State<part_1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 5, 20),
          height: 70,
          width: 70,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const part_2(),
                    ));
              },
              backgroundColor: Color.fromRGBO(2, 62, 138, 1),
              shape: CircleBorder(side: BorderSide.none),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
        body: ListView(
          children: [
            Image.asset(
              "assets/images/logo_board.png",
              alignment: Alignment(0, -4.4),
            ),
            Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Image.asset("assets/images/animasi_1.png"),
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/images/indikator_board.png",
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Semua dalam satu aplikasi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Akses semua metode pembelajaranmu",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  "dalam satu aplikasi",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                )
              ],
            ),
          ],
        ));
  }
}
