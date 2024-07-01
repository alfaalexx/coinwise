import 'package:coinwise/pages/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class membership extends StatefulWidget {
  const membership({super.key});

  @override
  State<membership> createState() => _membershipState();
}

class _membershipState extends State<membership> {
  // showDialog fungsi langganan
  void showSubscribedialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(60)),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/qr_dana.jpg'),
                SizedBox(
                  height: 10,
                ),
                Text("Scan Qris",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Scan disini untuk melanjutkan pembayaran Membership",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(140, 135, 135, 1)),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );

    // Menampilkan dialog Alertcoinwise setelah beberapa saat
    Future.delayed(Duration(seconds: 2), () {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Alertcoinwise();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 235, 243, 1),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const DashboardScreen(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
        title: Text("Membership"),
      ),
      body: ListView(
        children: [
          // kartu 1 bulan
          Container(
            margin: EdgeInsets.fromLTRB(15, 8, 15, 0),
            width: 300,
            height: 160,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                  child: Text(
                    "1 Bulan",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(139, 139, 139, 1)),
                  ),
                ),
                Text(
                  "Rp.100.000",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 2,
                  color: Color.fromRGBO(139, 139, 139, 1),
                ),
                Container(
                    margin: EdgeInsets.all(8),
                    width: 240,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(2, 62, 138, 1),
                        )),
                        onPressed: () => showSubscribedialog(context),
                        child: Text(
                          "Pilih Paket",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )))
              ],
            ),
          ),
          // kartu 3 bulan
          Container(
            margin: EdgeInsets.fromLTRB(15, 8, 15, 0),
            width: 300,
            height: 160,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                  child: Text(
                    "3 Bulan",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(139, 139, 139, 1)),
                  ),
                ),
                Text(
                  "Rp.295.000",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 2,
                  color: Color.fromRGBO(139, 139, 139, 1),
                ),
                Container(
                    margin: EdgeInsets.all(8),
                    width: 240,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(2, 62, 138, 1),
                        )),
                        onPressed: () => showSubscribedialog(context),
                        child: Text(
                          "Pilih Paket",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )))
              ],
            ),
          ),
          // kartu 6 bulan
          Container(
            margin: EdgeInsets.fromLTRB(15, 8, 15, 0),
            width: 300,
            height: 160,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                  child: Text(
                    "6 Bulan",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(139, 139, 139, 1)),
                  ),
                ),
                Text(
                  "Rp.590.000",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 2,
                  color: Color.fromRGBO(139, 139, 139, 1),
                ),
                Container(
                    margin: EdgeInsets.all(8),
                    width: 240,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(2, 62, 138, 1),
                        )),
                        onPressed: () => showSubscribedialog(context),
                        child: Text(
                          "Pilih Paket",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ))),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text("* Akses semua video pembelajaran"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text("* Akses postingan Komunitas"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text("* Akses postingan beranda"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Alertcoinwise extends StatefulWidget {
  const Alertcoinwise({super.key});

  @override
  State<Alertcoinwise> createState() => _AlertcoinwiseState();
}

class _AlertcoinwiseState extends State<Alertcoinwise> {
  bool _isDialogVisible = true;

  @override
  void initState() {
    super.initState();
    // Memulai timer ketika widget diinisialisasi
    startTimer();
  }

  // Metode untuk memulai timer
  void startTimer() {
    Future.delayed(Duration(seconds: 3), () {
      if (_isDialogVisible) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color.fromRGBO(217, 217, 217, 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/iconCheck.png'),
            SizedBox(
              height: 20,
            ),
            Text("Selesai",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            SizedBox(
              height: 20,
            ),
            Text(
              "Pembayaran telah berhasil",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(140, 135, 135, 1)),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Set nilai _isDialogVisible menjadi false saat widget dihapus
    _isDialogVisible = false;
    super.dispose();
  }
}
