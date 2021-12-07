import 'package:flutter/material.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _homeScreens = <Widget>[
    Text('Make a donation'),
    Text('04 – Donation History'),
    Text('05 – Saved donees'),
    Text('03 – Manage Account'),
  ];

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
          child: PageView(
            children: _homeScreens,
          ),
        ),
      ),
    );
  }
}
