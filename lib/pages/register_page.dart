import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:jacksonsburger/components/my_button.dart';
import 'package:jacksonsburger/components/my_textfield.dart';


class RegisterPage extends StatefulWidget {

  Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {

    try {
      if (passwordController.text == confirmPasswordController.text) {

        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        FirebaseFirestore.instance.
        collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'username' : emailController.text.split('@')[0],
          'bio' : 'Bio ...',
          'cargo' : 'Cargo ...',
        });

      }

    } on FirebaseAuthException catch (e) {

      Navigator.pop(context);

      showErrorMessage(e.code);

      if (e.code == 'weak-password') {
        showErrorMessage('Senha muito fraca.');
      }

      else if (e.code == 'email-already-in-use') {
        showErrorMessage('Email já cadastrado.');
      }
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                message,
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset('lib/images/burger-logo.png',
                  width: 100,
                  height: 100,
                ),

                const SizedBox(height: 10),

                Text(
                  'Vamos criar uma conta pra você!',
                  style: TextStyle(color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                MyTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  obscureText: false,
                  prefixIcon: const Icon(Icons.mail_outline, color: Colors.red),
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.red),
                ),


                const SizedBox(height: 10),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirmar senha',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.red),
                ),

                const SizedBox(height: 15),

                MyButton(
                  onTap: signUserUp,
                  text: 'Criar conta',
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Já possui conta?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Entre agora',
                        style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
