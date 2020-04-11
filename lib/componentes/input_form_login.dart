import 'package:flutter/material.dart';

class InputFormLogin extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icone;
  final bool ocultar;
  final TextCapitalization captalizacao;
  final TextInputType teclado;

  InputFormLogin({
    @required this.controller,
    this.icone,
    this.hint = "Default",
    this.ocultar = false,
    this.captalizacao,
    this.teclado = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
      ),
      child: TextField(
        keyboardType: teclado,
        controller: controller,
        obscureText: ocultar,
        textCapitalization:
            captalizacao == null ? TextCapitalization.none : captalizacao,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icone,
            color: Theme.of(context).iconTheme.color.withAlpha(50),
          ),
          hintText: hint,
          contentPadding: EdgeInsets.only(left: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: true,
        ),
      ),
    );
  }
}
