import 'package:coinwise/pages/on_boarding/part_3.dart';
import 'package:flutter/material.dart';

class part_2 extends StatefulWidget {
  const part_2({super.key});

  @override
  State<part_2> createState() => _part_2State();
}

class _part_2State extends State<part_2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 5, 20),
          height: 70,
          width: 70,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const part_3(),
                    ));
              },
              backgroundColor: const Color.fromRGBO(2, 62, 138, 1),
              shape: const CircleBorder(side: BorderSide.none),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor:const Color.fromRGBO(229, 235, 243, 1),
        body: ListView(
          children: [
            Image.asset(
              "assets/images/logo_board.png",
              alignment: const Alignment(0, -4.4),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset("assets/images/animasi_2.png"),
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/images/indikator_board2.png",
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Pemahaman investasi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Materi edukasi yang berkualitas ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const Text(
                  "mengenai teknologi dan investasi crypto.",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                )
              ],
            ),
          ],
        ));
  }
}
