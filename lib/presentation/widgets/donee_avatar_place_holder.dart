import 'package:flutter/material.dart';
import 'package:idonatio/common/assest.dart';
import 'package:idonatio/presentation/themes/app_color.dart';

class DoneeAvatarPlaceHolder extends StatelessWidget {
  const DoneeAvatarPlaceHolder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: Colors.white,
        ),
        color: AppColor.border30Primary,
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        clipBehavior: Clip.antiAlias,
        child: Align(
          child: Image.asset(
            AppAssest.person,
            fit: BoxFit.contain,
            // height: MediaQuery.of(context).size.height * .12,
          ),
        ),
      ),
    );
  }
}
