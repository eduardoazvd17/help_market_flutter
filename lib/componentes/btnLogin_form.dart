import 'package:flutter/material.dart';

class BtnLoginForm extends StatelessWidget {
  final String texto;
  final Color cor;
  final Function funcao;
  final double width;

  BtnLoginForm({
    this.texto = "LOGAR",
    this.cor = (Colors.indigo),
    this.width,
    @required this.funcao,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.053,
      width: width,
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      decoration:
          BoxDecoration(color: cor, borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        onTap: funcao,
        child: Center(
          child: Text(
            texto,
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
