import 'package:flutter/material.dart';

class BtnLoginForm extends StatelessWidget {
  final String texto;
  final Color cor;
  final Function funcao;
  final double width;
  //TODO: Alterar flatButton

  BtnLoginForm({
    this.texto = "LOGAR",
    this.cor = (Colors.indigo),
    this.width,
    @required this.funcao,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      decoration:
          BoxDecoration(color: cor, borderRadius: BorderRadius.circular(50)),
      child: FlatButton(
        onPressed: funcao,
        child: Text(
          texto,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
