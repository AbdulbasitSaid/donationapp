import 'package:flutter/material.dart';
import 'package:idonatio/presentation/widgets/loaders/primary_app_loader_widget.dart';

class PageLoaderWidget extends StatelessWidget {
  const PageLoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: PrimaryAppLoader()),
    );
  }
}
