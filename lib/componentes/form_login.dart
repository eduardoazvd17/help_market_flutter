import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/botao_form_login.dart';
import 'package:lista_compras/componentes/input_form_login.dart';

class FormLogin extends StatelessWidget {
  final TextEditingController usuarioController;
  final TextEditingController senhaController;
  final Function onSubmit;
  final Function onForgotPass;

  FormLogin({
    this.usuarioController,
    this.senhaController,
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
              InputFormLogin(
                icone: Icons.mail,
                controller: usuarioController,
                hint: "E-mail",
                teclado: TextInputType.emailAddress,
              ),
              InputFormLogin(
                icone: Icons.lock,
                controller: senhaController,
                hint: "Senha",
                ocultar: true,
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
                  BotaoFormLogin(
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
