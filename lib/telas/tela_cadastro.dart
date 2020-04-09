import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/btnLogin_form.dart';
import 'package:lista_compras/componentes/inputLogin_form.dart';
import 'package:lista_compras/modelos/usuario.dart';

class TelaCadastro extends StatelessWidget {
  final Function(Usuario) atualizarUsuario;
  TelaCadastro(this.atualizarUsuario);

  final nomeController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  _enviar(context) async {
    String nome = nomeController.text;
    String email = userController.text;
    String senha = passController.text;
    String confSenha = confirmPassController.text;

    if (nome.isEmpty || email.isEmpty || senha.isEmpty || confSenha.isEmpty) {
      return;
    }

    if (senha != confSenha) {
      return;
    }

    //Loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                SizedBox(height: 15),
                new Text(
                  "Carregando",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    try {
      //Faz a autenticação
      AuthResult auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);
      FirebaseUser user = auth.user;
      //Envia verificacao por email
      user.sendEmailVerification();
      //Armazena dados no banco
      Firestore.instance.collection('usuarios').document(user.uid).setData({
        'nome': nome,
        'email': email,
      });
      //Armazena a config modo noturno.
      Firestore.instance
          .collection('usuarios')
          .document(user.uid)
          .collection('config')
          .document('modo-noturno')
          .setData({
        'nome': 'Modo Noturno',
        'valor': false,
      });
      //Atualizar usuario.
      atualizarUsuario(new Usuario(user.uid, nome, email));
      Navigator.of(context).pop(); //Fecha o loading dialog
      Navigator.of(context).pop(); //Fecha a tela de cadastro.
    } catch (e) {
      //TODO: showDialog Erro.
      return;
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
                              icon: Icon(Icons.person),
                              controller: nomeController,
                              captalizacao: TextCapitalization.words,
                              hintText: "Nome",
                            ),
                            InputLoginForm(
                              icon: Icon(Icons.mail),
                              controller: userController,
                              hintText: "Email",
                              keyboardType: TextInputType.emailAddress,
                            ),
                            InputLoginForm(
                              icon: Icon(Icons.lock),
                              controller: passController,
                              hintText: "Senha",
                              obscureText: true,
                            ),
                            InputLoginForm(
                              icon: Icon(Icons.lock),
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
