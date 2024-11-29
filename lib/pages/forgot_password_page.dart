import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jacksonsburger/components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  static const String id = 'forgot_password_page';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Link enviado!'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Email não encontrado!'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                    'Deseja resetar sua senha?',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.red
                    ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'Digite seu email que enviaremos um link.',
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
              prefixIcon: const Icon(Icons.mail_outline, color: Colors.red),
            ),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: passwordReset,
            color: Colors.red[700],
            textColor: Colors.white,
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}