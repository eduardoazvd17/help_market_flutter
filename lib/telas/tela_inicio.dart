import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/form_lista.dart';
import 'package:lista_compras/componentes/main_drawer.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_configuracoes.dart';
import 'package:lista_compras/telas/tela_inicial.dart';
import 'package:lista_compras/telas/tela_listas.dart';

class TelaInicio extends StatefulWidget {
  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  Usuario usuario;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (usuario == null) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  _atualizarUsuario(Usuario usuario) {
    setState(() {
      this.usuario = usuario;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
      TelaInicial(usuario, _atualizarUsuario),
      TelaListas(usuario),
      TelaConfiguracoes(usuario),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          usuario == null
              ? ''
              : _selectedIndex == 0
                  ? 'Inicio'
                  : _selectedIndex == 1 ? 'Minhas Listas' : 'Configurações',
        ),
      ),
      drawer: MainDrawer(usuario, _atualizarUsuario),
      body: usuario == null ? _telas[0] : _telas[_selectedIndex],
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => FormLista(
                    usuario: usuario,
                    lista: null,
                  ),
                );
              },
            )
          : null,
      bottomNavigationBar: usuario == null
          ? null
          : BottomNavigationBar(
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
