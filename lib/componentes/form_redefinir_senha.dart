import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/btnLogin_form.dart';
import 'package:lista_compras/componentes/inputLogin_form.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_cadastro.dart';

class FormRedefinirSenha extends StatefulWidget {
  final Function(Usuario) alterarUsuario;
  final String email;
  FormRedefinirSenha(this.email, this.alterarUsuario);
  @override
  _FormRedefinirSenhaState createState() =>
      _FormRedefinirSenhaState(TextEditingController(text: email));
}

class _FormRedefinirSenhaState extends State<FormRedefinirSenha> {
  final TextEditingController emailController;
  _FormRedefinirSenhaState(this.emailController);

  _redefinir(context) async {
    String email = emailController.text;

    if (email.isEmpty) {
      return;
    }

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
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Redefinição de senha"),
            content: new Text(
                "Voce receberá um e-mail com os passos para alterar sua senha."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Conta inexistente"),
            content: new Text(
                "Não há uma conta associada a este endereço de e-mail."),
            actions: <Widget>[
              FlatButton(
                child: Text("Criar minha conta"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TelaCadastro(widget.alterarUsuario),
                    ),
                  );
                },
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Esqueci minha senha',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
                'Insira seu e-mail no campo abaixo e nós enviaremos um e-mail com o link para redefinição de senha.'),
            InputLoginForm(
              controller: emailController,
              icon: Icon(Icons.email),
              hintText: 'E-mail',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            BtnLoginForm(
              funcao: () => _redefinir(context),
              cor: Theme.of(context).accentColor,
              texto: 'Redefinir Senha',
            )
          ],
        ),
      ),
    );
  }
}
