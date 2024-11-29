import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jacksonsburger/components/my_button.dart';
import 'package:jacksonsburger/components/my_textfield.dart';
import 'package:jacksonsburger/pages/forgot_password_page.dart';

class LoginPage extends StatefulWidget {

  Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {


    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {

      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showErrorMessage();
      }
    }
  }
  void showErrorMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Usuário não encontrado.'),
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

                const SizedBox(height: 20),

                Text(
                    'Seja bem vindo de volta, sentimos sua falta!',
                    style: TextStyle(color: Colors.grey[700],
                    fontSize: 16,
                    ),
                ),

                const SizedBox(height: 30),

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const ForgotPasswordPage()));
                        },
                        child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                MyButton(
                  onTap: signUserIn,
                  text: 'Entrar',
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
                    Text('Não possui conta?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Cadastre-se',
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
