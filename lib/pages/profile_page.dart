import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jacksonsburger/components/bottom_navigation_bar.dart';
import 'package:jacksonsburger/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const String id = 'profile_page';
  static const String routeName = 'profile_page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {

  final currentUser = FirebaseAuth.instance.currentUser!;

  final usersCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> editField(String field) async {
    final TextEditingController controller = TextEditingController();

    final currentValue = await usersCollection.doc(currentUser.email).get().then((snapshot) {
      return snapshot[field];
    });

    controller.text = currentValue ?? '';

    String? updatedValue = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("Edit $field", style: TextStyle(color: Colors.white)),
        content: TextField(
          autofocus: true,
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Digite seu novo $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context, null),
          ),
          TextButton(
            child: Text(
              'Salvar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(controller.text),
          ),
        ],
      ),
    );

    if (updatedValue != null && updatedValue.trim() != currentValue) {
      await usersCollection.doc(currentUser.email).update({field: updatedValue});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[300],
        title: Text(
          'Perfil',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot)  {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [

                const SizedBox(height: 50),

                const Icon(
                  Icons.person,
                  size: 72,
                ),

                const SizedBox(height: 10),

                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF06aa51)),
                ),

                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    'Meus Detalhes',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),

                MyTextBox(
                  text: userData['username'],
                  sectionName: 'Username',
                  onPressed: () => editField('username'),
                ),

                MyTextBox(
                  text: userData['bio'],
                  sectionName: 'Bio',
                  onPressed: () => editField('bio'),
                ),

                MyTextBox(
                  text: userData['cargo'],
                  sectionName: 'Cargo',
                  onPressed: () => editField('cargo'),
                ),

                const SizedBox(height: 50),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }

          return const Center (
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBarClass(),
    );
  }
}