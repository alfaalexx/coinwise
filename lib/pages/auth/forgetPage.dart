import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 235, 243, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Lupa kata sandi'),
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Image.asset(
                'assets/images/animasi_4.png',
                height: 300.0,
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Pemulihan kata sandi',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Link pemulihan kata sandi akan dikirimkan melalui email anda.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'user123@gmail.com',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/images/email_icon.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(229, 235, 243, 1),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  SizedBox(height: 30.0),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
                      // Logic to send password reset link
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF023E8A),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Reset Kata Sandi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
