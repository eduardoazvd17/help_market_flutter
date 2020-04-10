import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/btnLogin_form.dart';
import 'package:lista_compras/componentes/inputLogin_form.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/utilitarios/validador.dart';

class TelaCadastro extends StatelessWidget {
  final Function(Usuario) atualizarUsuario;
  TelaCadastro(this.atualizarUsuario);

  final nomeController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  _enviar(context) async {
    String nome = nomeController.text;
    String email = userController.text.trim();
    String senha = passController.text.trim();
    String confSenha = confirmPassController.text.trim();
    Validador validador = Validador(context);

    if (!validador.valida(nome) ||
        !validador.valida(email) ||
        !validador.valida(senha) ||
        !validador.valida(confSenha) ||
        !validador.validaSenhas(senha, confSenha) ||
        !validador.validaEmail(email)) {
      return;
    }

    validador.mostrarCarregamento();

    try {
      AuthResult auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);
      FirebaseUser user = auth.user;
      Firestore.instance.collection('usuarios').document(user.uid).setData({
        'nome': nome,
        'email': email,
      });
      Firestore.instance
          .collection('usuarios')
          .document(user.uid)
          .collection('config')
          .document('modo-noturno')
          .setData({
        'nome': 'Modo Noturno',
        'valor': false,
      });
      UserUpdateInfo update = new UserUpdateInfo();
      update.displayName = nome;
      user.updateProfile(update);
      atualizarUsuario(new Usuario(user.uid, nome, email));
      validador.ocultarCarregamento();
      Navigator.of(context).pop();
    } catch (e) {
      validador.ocultarCarregamento();
      validador.validaErro(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: constraints.maxHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.only(
                          top: constraints.maxHeight * 0.02,
                          bottom: constraints.maxHeight * 0.02,
                        ),
                        child: Text(
                          "Seja Bem-Vindo!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: constraints.maxHeight * 0.01),
                        child: Text(
                          "Cadastre-se para continuar.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: constraints.maxHeight * 0.01),
                        child: Icon(
                          Icons.people,
                          size: 100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            InputLoginForm(
                              icon: Icons.person,
                              controller: nomeController,
                              captalizacao: TextCapitalization.words,
                              hintText: "Nome",
                            ),
                            InputLoginForm(
                              icon: Icons.mail,
                              controller: userController,
                              hintText: "Email",
                              keyboardType: TextInputType.emailAddress,
                            ),
                            InputLoginForm(
                              icon: Icons.lock,
                              controller: passController,
                              hintText: "Senha",
                              obscureText: true,
                            ),
                            InputLoginForm(
                              icon: Icons.lock,
                              controller: confirmPassController,
                              hintText: "Confirmar Senha",
                              obscureText: true,
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            ),
                            BtnLoginForm(
                              texto: "Cadastrar-se",
                              funcao: () => _enviar(context),
                              cor: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            ),
                            BtnLoginForm(
                              texto: "Cancelar",
                              cor: Colors.red,
                              funcao: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
