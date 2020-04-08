import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/main_drawer.dart';
import 'package:lista_compras/telas/tela_configuracoes.dart';
import 'package:lista_compras/telas/tela_inicial.dart';
import 'package:lista_compras/telas/tela_listas.dart';

class TelaInicio extends StatefulWidget {
  final List<Widget> _telas = [
    TelaInicial(),
    TelaListas(),
    TelaConfiguracoes(),
  ];

  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Inicio'
              : _selectedIndex == 1 ? 'Minhas Listas' : 'Configurações',
        ),
      ),
      drawer: MainDrawer(),
      body: widget._telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Inicio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Minhas Listas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Configurações'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
