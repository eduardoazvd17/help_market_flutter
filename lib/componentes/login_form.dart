import 'package:flutter/material.dart';
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
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            InputLoginForm(
              icon: Icon(Icons.person),
              controller: userController,
              hintText: "Usuario",
            ),
            InputLoginForm(
              icon: Icon(Icons.lock),
              controller: passController,
              hintText: "Senha",
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
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
                  Container(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.indigo[300],
                        borderRadius: BorderRadius.circular(50)),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "LOGAR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
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
