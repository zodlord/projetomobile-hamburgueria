import 'package:flutter/material.dart';
import 'package:jacksonsburger/pages/home_page.dart';
import 'package:jacksonsburger/pages/calculadora_page.dart';
import 'package:jacksonsburger/pages/lucro_page.dart';
import 'package:jacksonsburger/pages/profile_page.dart';

import '../pages/pedidos_page.dart';

class BottomNavigationBarClass extends StatelessWidget {
  const BottomNavigationBarClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[300],
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.attach_money,
          ),
          label: 'Lucro',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calculate_outlined,
          ),
          label: 'Caculadora',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people_alt_outlined,
          ),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
          ),
          label: 'Perfil',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, HomePage.routeName);
            break;
          case 1:
            Navigator.pushNamed(context, LucroPage.routeName);
            break;
          case 2:
            Navigator.pushNamed(context, CalculadoraPage.routeName);
            break;
          case 3:
            Navigator.pushNamed(context, PedidosPage.routeName);
            break;
          case 4:
            Navigator.pushNamed(context, ProfilePage.routeName);
            break;
        }
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedFontSize: 14,
      unselectedFontSize: 12,
    );
  }
}