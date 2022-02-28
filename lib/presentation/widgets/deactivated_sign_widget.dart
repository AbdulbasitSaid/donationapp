import 'package:flutter/material.dart';

import '../themes/app_color.dart';

class DeactivatedSignWidget extends StatelessWidget {
  const DeactivatedSignWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColor.lightAlertSemantic,
          borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width))),
      child: Row(
        children: [
          Text(
            'Donee account deactivated',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AppColor.darkSecondaryAmber),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.question_mark,
          )
        ],
      ),
    );
  }
}
