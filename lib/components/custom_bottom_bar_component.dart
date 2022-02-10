import 'package:flutter/material.dart';

class CustomBottomBarWidget extends StatefulWidget {
  const CustomBottomBarWidget({Key? key}) : super(key: key);

  @override
  _CustomBottomBarWidgetState createState() => _CustomBottomBarWidgetState();
}

class _CustomBottomBarWidgetState extends State<CustomBottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue.shade900,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      // selectedFontSize: 15.0,
      // Esse index aqui n vai precisar.
      // currentIndex: _selectedIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.phone),
          label: 'Contato',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.downloading_sharp),
          label: 'Boletos',
        ),
      ],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      // _selectedIndex = index;
      print(index);
      if (index == 0) {
        // ContatoModalWidget();
        // showModalBottomSheet<void>(
        //     context: context,
        //     builder: (BuildContext context) => contatoModelWidget(context));
      } else if (index == 1) {
        // Requisição de boletos
        // Navigator.of(context).pushNamed('/boletos');
      }
    });
  }
}
