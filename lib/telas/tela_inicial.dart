import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/form_redefinir_senha.dart';
import 'package:lista_compras/componentes/login_form.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_cadastro.dart';
import 'package:lista_compras/utilitarios/validador.dart';

class TelaInicial extends StatelessWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarUsuario;
  TelaInicial(this.usuario, this.atualizarUsuario);

  final usuarioCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _enviar(context) async {
      String email = usuarioCtrl.text;
      String senha = senhaCtrl.text;
      Validador validador = Validador(context);

      if (validador.valida(email) ||
          validador.valida(senha) ||
          validador.validaEmail(email)) {
        return;
      }

      validador.mostrarCarregamento();

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
        validador.ocultarCarregamento();
      } catch (e) {
        validador.ocultarCarregamento();
        validador.validaErro(e.code);
      }
    }

    _esqueciMinhaSenha(context) {
      String email = usuarioCtrl.text;
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => FormRedefinirSenha(email),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          usuario == null
                              ? "Welcome!"
                              : "Olá, ${usuario.nome.split(' ').first}!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.015,
                        ),
                        Text(
                          usuario == null
                              ? "Seja bem vindo ao app lista de compras\nVocê deve se autenticar para continuar"
                              : "Seja bem vindo de volta ao app lista de compras",
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
                                onForgotPass: () => _esqueciMinhaSenha(context),
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
                      : Container(), //<- Tela de apresentação apos se autenticar.
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
