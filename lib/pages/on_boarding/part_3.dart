import 'package:coinwise/pages/auth/loginPage.dart';
import 'package:flutter/material.dart';

class part_3 extends StatefulWidget {
  const part_3({super.key});

  @override
  State<part_3> createState() => _part_3State();
}

class _part_3State extends State<part_3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
          child: SizedBox(
            width: 145,
            height: 50,
            child: FloatingActionButton.extended(
              label: const Text(
                "Get started",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w300),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Login(),
                    ));
              },
              backgroundColor: const Color.fromRGBO(2, 62, 138, 1),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(229, 235, 243, 1),
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
                Image.asset("assets/images/animasi_3.png"),
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/images/indikator_board3.png",
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
