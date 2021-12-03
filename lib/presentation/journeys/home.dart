import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _homeScreens = <Widget>[
    Text('Make a donation'),
    Text('04 – Donation History'),
    Text('05 – Saved donees'),
    Text('03 – Manage Account'),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: AppBackgroundWidget(
        childWidget: Center(
          child: _homeScreens.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.basePrimary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Colors.pink,
              icon: Icon(
                Icons.add,
              ),
              label: 'New'),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(
                Icons.favorite_border,
              ),
              label: 'History'),
          BottomNavigationBarItem(
              backgroundColor: Colors.yellow,
              icon: Icon(
                Icons.history,
              ),
              label: 'Donees'),
          BottomNavigationBarItem(
              backgroundColor: Colors.purple,
              icon: Icon(
                Icons.manage_accounts_outlined,
              ),
              label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
