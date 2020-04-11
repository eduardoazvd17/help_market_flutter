import 'package:flutter/material.dart';

class BotaoFormLogin extends StatelessWidget {
  final String titulo;
  final Color cor;
  final Function funcao;

  BotaoFormLogin({
    this.titulo = "Entrar",
    this.cor,
    @required this.funcao,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: funcao,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: cor == null ? Theme.of(context).primaryColor : cor,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            titulo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
