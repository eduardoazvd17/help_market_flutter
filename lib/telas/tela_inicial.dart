import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/login_form.dart';
import 'package:lista_compras/telas/tela_cadastro.dart';

class TelaInicial extends StatelessWidget {
  final usuarioCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  //TODO: Adicionar funcao registre-se

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    var largura = MediaQuery.of(context).size.width;

    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              height: altura * 0.815,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              margin: EdgeInsets.only(top: altura * 0.015),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: altura * 0.02),
                  Container(
                    height: altura * 0.25,
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2018/10/03/21/44/shopping-3722450_960_720.png",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: altura * 0.02,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Welcome \$user!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: altura * 0.015,
                        ),
                        Text(
                          "Welcome \$user! Welcome \$user! Welcome \$user! ",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: largura * 0.02,
                      vertical: altura * 0.01,
                    ),
                    child: LoginForm(
                      passController: senhaCtrl,
                      userController: usuarioCtrl,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => TelaCadastro()));
                    },
                    child: Text(
                      "Não tem uma conta? Cadastre-se.",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
