import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_color.dart';

class AppBackgroundWidget extends StatelessWidget {
  const AppBackgroundWidget({Key? key, required this.childWidget})
      : super(key: key);
  final Widget childWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: AppColor.appBackground,
      ),
      child: childWidget,
    );
  }
}
