import 'package:flutter/material.dart';
import 'package:motapp/app/pages/create_account_page.dart';
import 'package:motapp/app/pages/home_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';
import 'package:motapp/app/viewmodels/login_view_model.dart';
import 'package:motapp/app/widgets/text_field_login_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textEmail = TextEditingController();

  final textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: LightColors.backgaundLogin,
              body: Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/logo.png', height: 100),
                      Padding(padding: EdgeInsetsGeometry.only(top: 70)),
                      TextFieldLoginWidget(
                        controller: textEmail,
                        labelText: 'E-mail',
                        icon: Icons.person_2_rounded,
                      ),
                      SizedBox(height: 26),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: TextFieldLoginWidget(
                          obscureText: true,
                          controller: textPassword,
                          labelText: 'Senha',
                          icon: Icons.lock_sharp,
                        ),
                      ),

                      ElevatedButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () async {
                                final result = await viewModel.login(
                                  textEmail.text,
                                  textPassword.text,
                                );
                                if (result != null &&
                                    !result.startsWith('ERRO')) {
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  }
                                } else if (result != null) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(result),
                                        duration: Duration(seconds: 4),
                                      ),
                                    );
                                  }
                                }
                              },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            LightColors.buttonRed,
                          ),
                        ),
                        child: Text(
                          "Entrar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            LightColors.buttonRed,
                          ),
                        ),
                        child: viewModel.isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Criar Conta",
                                style: TextStyle(color: Colors.white),
                              ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAccountPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // // Login com o Firebase Auth
  // void login(email, senha) {
  //   FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email, password: senha)
  //       .then((resultado) {
  //         isLoading = false;
  //         if (mounted) {
  //           Navigator.pushReplacementNamed(
  //             context,
  //             '/menu',
  //             arguments: resultado.user!.uid,
  //           );
  //         }
  //       })
  //       .catchError((erro) {
  //         var mensagem = '';
  //         if (erro.code == 'user-not-found') {
  //           mensagem = 'ERRO: Usuário não encontrado.';
  //         } else if (erro.code == 'wrong-password') {
  //           mensagem = 'ERRO: Senha incorreta.';
  //         } else if (erro.code == 'invalid-email') {
  //           mensagem = 'ERRO: Email inválido.';
  //         } else {
  //           mensagem = 'ERRO: ${erro.message}';
  //         }
  //         if (mounted) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text(mensagem), duration: Duration(seconds: 4)),
  //           );
  //         }
  //       });
  // }
}
