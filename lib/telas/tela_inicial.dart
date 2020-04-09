import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/login_form.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_cadastro.dart';

class TelaInicial extends StatelessWidget {
  Usuario usuario;
  Function(Usuario) atualizarUsuario;
  TelaInicial(this.usuario, this.atualizarUsuario);

  final usuarioCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  //TODO: Adicionar funcao registre-se

  @override
  Widget build(BuildContext context) {
    _enviar(context) async {
      String email = usuarioCtrl.text;
      String senha = senhaCtrl.text;

      if (email.isEmpty || senha.isEmpty) {
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text(
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
        AuthResult auth = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: senha);
        FirebaseUser user = auth.user;
        DocumentSnapshot doc = await Firestore.instance
            .collection('usuarios')
            .document(user.uid)
            .get();
        Usuario usuario = Usuario(user.uid, doc['nome'], doc['email']);
        atualizarUsuario(usuario);
        Navigator.of(context).pop();
      } catch (e) {
        return;
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: Theme.of(context).primaryColor,
        child: Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          color: Theme.of(context).primaryColor,
          child: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.02,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.25,
                          child: Image.network(
                            "https://cdn.pixabay.com/photo/2018/10/03/21/44/shopping-3722450_960_720.png",
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        Text(
                          "Welcome!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.015,
                        ),
                        Text(
                          "Seja bem vindo ao app lista de compras\nVocê deve se autenticar para continuar",
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  usuario == null
                      ? Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: LoginForm(
                                passController: senhaCtrl,
                                userController: usuarioCtrl,
                                onSubmit: () => _enviar(context),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        TelaCadastro(atualizarUsuario),
                                  ),
                                );
                              },
                              child: Text(
                                "Não tem uma conta? Cadastre-se.",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        )
                      : Container(child: Center(child: Text('Logado'))),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
