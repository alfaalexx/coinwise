import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Postkomunitas extends StatefulWidget {
  const Postkomunitas({super.key});

  @override
  State<Postkomunitas> createState() => _PostkomunitasState();
}

class _PostkomunitasState extends State<Postkomunitas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
          onPressed: () {},
          child: Image(image: AssetImage("assets/images/image_icon.png"))),
      backgroundColor: Color.fromRGBO(229, 235, 243, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
        title: Text("Postingan Baru",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        actions: [
          GestureDetector(
            onTap: () {},
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Judul",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Please enter title (required)",
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Deskripsi",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Please enter text",
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
            ),
          ],
        ),
      ),
    );
  }
}
