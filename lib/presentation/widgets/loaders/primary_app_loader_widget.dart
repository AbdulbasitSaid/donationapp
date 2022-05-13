import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../themes/app_color.dart';

class PrimaryAppLoader extends StatelessWidget {
  const PrimaryAppLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 54,
      width: 54,
      child: LoadingIndicator(colors: [
        AppColor.basePrimary,
        AppColor.baseSecondaryGreen,
        AppColor.baseSecondaryAmber,
      ], indicatorType: Indicator.ballTrianglePathColoredFilled),
    );
  }
}
