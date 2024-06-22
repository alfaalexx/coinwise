import 'package:coinwise/pages/auth/registerPage.dart';
import 'package:coinwise/pages/dashboard/dashboard_screen.dart';
import 'package:coinwise/pages/forgot_password/forgot_password_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(229, 235, 243, 1),
        body: ListView(
          children: [
            const SizedBox(height: 10), // Adjust the height as needed
            Center(
              child: Image.asset(
                'assets/images/logo_auth.png',
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // INPUT EMAIL
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'user123@gmail.com',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/images/email_icon.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // INPUT SANDI
                  const Text(
                    'Kata sandi',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  TextField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Kata Sandi',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/images/password.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: _toggle),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        //Navigator ke Forgot Password Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Lupa Kata Sandi?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.lightBlue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // SUBMIT
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF023E8A),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 120.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const DashboardScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Belum memiliki akun? ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'Montserrat',
                  ),
                  children: [
                    TextSpan(
                      text: 'Daftar sekarang',
                      style: const TextStyle(
                        color: Color(0xFF023E8A),
                        fontSize: 14.0,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the login page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Register(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
