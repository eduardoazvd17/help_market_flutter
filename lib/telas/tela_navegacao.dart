import 'package:flutter/material.dart';
import 'package:lista_compras/componentes/form_lista.dart';
import 'package:lista_compras/componentes/main_drawer.dart';
import 'package:lista_compras/modelos/usuario.dart';
import 'package:lista_compras/telas/tela_configuracoes.dart';
import 'package:lista_compras/telas/tela_inicial.dart';
import 'package:lista_compras/telas/tela_listas.dart';

class TelaNavegacao extends StatefulWidget {
  final Usuario usuario;
  final Function(Usuario) atualizarConfigs;
  TelaNavegacao(this.usuario, this.atualizarConfigs);
  @override
  _TelaNavegacaoState createState() => _TelaNavegacaoState(usuario);
}

class _TelaNavegacaoState extends State<TelaNavegacao> {
  Usuario usuario;
  int _selectedIndex = 0;
  _TelaNavegacaoState(this.usuario);

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
    if (usuario == null) {
      widget.atualizarConfigs(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
      TelaInicial(usuario, _atualizarUsuario, widget.atualizarConfigs),
      TelaListas(usuario),
      TelaConfiguracoes(usuario, widget.atualizarConfigs),
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
