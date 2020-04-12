import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/modelos/config.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_splash.dart';

void main() => runApp(ListaCompras());

class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  Map<String, Config> configs;

  _atualizarConfigs(Usuario usuario) {
    if (usuario == null) {
      setState(() {
        this.configs = null;
      });
      return;
    }
    Firestore.instance
        .collection('usuarios')
        .document(usuario.id)
        .collection('config')
        .getDocuments()
        .then((doc) {
      Map<String, Config> configs = new HashMap();
      for (var item in doc.documents) {
        if (configs[item.documentID] == null) {
          configs.putIfAbsent(
            'modo-noturno',
            () => Config(item.documentID, item['nome'], item['valor'] as bool),
          );
        } else {
          configs.update(
            'modo-noturno',
            (_) => Config(item.documentID, item['nome'], item['valor'] as bool),
          );
        }
      }
      setState(() {
        this.configs = configs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData light = ThemeData(
      primarySwatch: Colors.indigo,
      accentColor: Colors.indigo,
      iconTheme: IconThemeData(color: Colors.black),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );

    ThemeData dark = ThemeData(
      primarySwatch: Colors.pink,
      dividerColor: Colors.white12,
      accentColor: Colors.pink,
      backgroundColor: Colors.grey[900],
      scaffoldBackgroundColor: Colors.grey[900],
      bottomAppBarColor: Colors.grey[900],
      canvasColor: Colors.grey[850],
      iconTheme: IconThemeData(color: Colors.white),
      hintColor: Colors.white30,
      dialogTheme: DialogTheme(backgroundColor: Colors.grey[850]),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey[900],
      ),
      textTheme: TextTheme(
        subhead: TextStyle(color: Colors.white),
        title: TextStyle(color: Colors.white),
        body1: TextStyle(color: Colors.white),
        body2: TextStyle(color: Colors.white),
        caption: TextStyle(color: Colors.white70),
      ),
    );

    return MaterialApp(
      theme: configs == null
          ? light
          : configs['modo-noturno'].valor ? dark : light,
      debugShowCheckedModeBanner: false,
      home: TelaSplash(_atualizarConfigs),
    );
  }
}
