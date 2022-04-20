import 'package:flutter/material.dart';

class PageLoaderWidget extends StatelessWidget {
  const PageLoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
