import 'package:flutter/material.dart';
import 'package:lista_compras/telas/tela_inicio.dart';

void main() => runApp(ListaCompras());

class ListaCompras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      home: TelaInicio(),
    );
  }
}
