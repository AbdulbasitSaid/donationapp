import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_color.dart';

class AppErrorDialogWidget extends StatelessWidget {
  const AppErrorDialogWidget(
      {Key? key, required this.title, required this.message})
      : super(key: key);
  final String title, message;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).errorColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: const Color(0xffFFF5F5),
      ),
      child: ListTile(
        iconColor: AppColor.baseNegativeSemantic,
        isThreeLine: false,
        contentPadding: const EdgeInsets.all(12),
        leading: Column(
          children: const [
            Icon(
              Icons.cancel_outlined,
              size: 24,
            ),
          ],
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColor.baseNegativeSemantic,
              ),
        ),
        subtitle: Text(
          message,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: AppColor.baseNegativeSemantic,
              ),
        ),
      ),
    );
  }
}
