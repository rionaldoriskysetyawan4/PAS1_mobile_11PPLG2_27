import 'package:flutter/material.dart';
import 'package:pas1_mobile_11pplg2_27/menu/Page/SecondPage.dart';
import 'package:pas1_mobile_11pplg2_27/menu/Page/ThreePage.dart';

import 'Page/MainPage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Mainpage(),
    Secondpage(),
    Threepage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.article, color: Color(0xFFF7BA20)),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Color(0xFFF7BA20)),
              label: 'Like',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color(0xFFF7BA20)),
              label: 'Profile',
            ),
          ]
      ),



    );
  }
}
