import 'package:flutter/material.dart';
import 'package:idonatio/presentation/reusables.dart';

class SearchDonationHistoryScreen extends StatelessWidget {
  const SearchDonationHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: gradientBoxDecoration(),
      ),
    );
  }
}
