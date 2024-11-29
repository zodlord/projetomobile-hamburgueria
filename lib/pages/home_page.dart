import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jacksonsburger/components/bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home_page';
  static const String routeName = 'home_page';

  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout, color: Colors.black)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'lib/images/burger-logo.png',
                  height: 300,
                ),
              ),
            ),

            SizedBox(height: 50),

            Text('Logado como ' + user.email!)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarClass(),
    );
  }
}
