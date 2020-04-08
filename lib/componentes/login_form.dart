import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/btnLogin_form.dart';
import 'package:lista_compras/componentes/inputLogin_form.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passController;

  LoginForm({
    this.userController,
    this.passController,
  });

  //TODO: Adicionar funcoes para logar e esqueceu a senha
  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Container(
        height: altura * 0.30,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: altura * 0.015,
            ),
            InputLoginForm(
              icon: Icon(Icons.person),
              controller: userController,
              hintText: "Usuario",
              keyboardType: TextInputType.emailAddress,
            ),
            InputLoginForm(
              icon: Icon(Icons.lock),
              controller: passController,
              hintText: "Senha",
              obscureText: true,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: altura * 0.012,
                bottom: altura * 0.016,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Esqueceu a senha?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  BtnLoginForm(
                    cor: Colors.indigo[300],
                    funcao: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
