import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/btnLogin_form.dart';
import 'package:lista_compras/componentes/inputLogin_form.dart';
import 'package:lista_compras/telas/tela_cadastro.dart';

class TelaCadastro extends StatelessWidget {
  var nomeController = TextEditingController();
  var userController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Container(
            margin: EdgeInsets.only(top: altura * 0.015),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: altura * 0.01),
                Container(
                  width: largura * 0.98,
                  height: altura * 0.82,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: altura * 0.03,
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
                        padding: EdgeInsets.only(bottom: altura * 0.03),
                        child: Text(
                          "Cadastre-se para continuar.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: altura * 0.03),
                        child: Icon(
                          Icons.people,
                          size: altura * 0.08,
                        ),
                      ),
                      InputLoginForm(
                        icon: Icon(Icons.person),
                        controller: nomeController,
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
                        controller: confirmPassController,
                        hintText: "Confirmar Senha",
                        obscureText: true,
                      ),
                      SizedBox(
                        height: altura * 0.02,
                      ),
                      BtnLoginForm(
                        width: largura * 0.858,
                        texto: "Cadastrar-se",
                        funcao: () {},
                        cor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: altura * 0.02,
                      ),
                      BtnLoginForm(
                        width: largura * 0.858,
                        texto: "Cancelar",
                        cor: Colors.red,
                        funcao: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
