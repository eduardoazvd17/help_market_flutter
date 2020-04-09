import 'package:flutter/material.dart';
import 'package:lista_compras/modelos/usuario.dart';

class TelaAjustesConta extends StatelessWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarUsuario;
  TelaAjustesConta(this.usuario, this.atualizarUsuario);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nome),
      ),
      body: Container(),
    );
  }
}
