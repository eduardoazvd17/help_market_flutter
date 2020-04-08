import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/btnLogin_form.dart';
import 'package:lista_compras/componentes/inputLogin_form.dart';
import 'package:lista_compras/telas/tela_cadastro.dart';

class TelaListas extends StatelessWidget {
  var userController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              // color: Colors.purple,
              width: largura * 0.98,
              height: altura * 0.82,
              child: Card(
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: altura * 0.024,
                        bottom: altura * 0.005,
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
                      padding: EdgeInsets.only(bottom: altura * 0.005),
                      child: Text(
                        "Cadastre-se para continuar.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InputLoginForm(
                      icon: Icon(Icons.person),
                      controller: userController,
                      hintText: "Nome",
                    ),
                    InputLoginForm(
                      icon: Icon(Icons.person),
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
                      controller: passController,
                      hintText: "Confirmar Senha",
                      obscureText: true,
                    ),
                    SizedBox(
                      height: altura * 0.02,
                    ),
                    BtnLoginForm(
                      texto: "Cadastrar-se",
                      funcao: () {},
                      cor: Colors.green,
                    ),
                    SizedBox(
                      height: altura * 0.02,
                    ),
                    BtnLoginForm(
                      texto: "Cancelar",
                      cor: Colors.red,
                      funcao: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
