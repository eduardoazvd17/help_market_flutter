import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/btnLogin_form.dart';
import 'package:lista_compras/componentes/inputLogin_form.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passController;
  final Function onSubmit;
  final Function onForgotPass;

  LoginForm({
    this.userController,
    this.passController,
    this.onSubmit,
    this.onForgotPass,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 1.0), //(x,y)
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              InputLoginForm(
                icon: Icons.mail,
                controller: userController,
                hintText: "E-mail",
                keyboardType: TextInputType.emailAddress,
              ),
              InputLoginForm(
                icon: Icons.lock,
                controller: passController,
                hintText: "Senha",
                obscureText: true,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: onForgotPass,
                    child: Text(
                      "Esqueceu a senha?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  BtnLoginForm(
                    cor: Theme.of(context).accentColor,
                    funcao: onSubmit,
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
