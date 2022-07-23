import 'package:flutter/material.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_donation_fees_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/user/cubit/get_authenticated_user_cubit.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';

import '../journeys/new_donation/cubit/get_payment_methods_cubit.dart';
import '../journeys/new_donation/donation_details.dart';
import '../router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'donee_logo_widget.dart';

class DoneeListTile extends StatelessWidget {
  final String? name, address;
  final String doneeCode;
  final String? imageUrl;
  const DoneeListTile({
    Key? key,
    required this.name,
    required this.address,
    required this.doneeCode,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final userState = context.watch<UserCubit>().state;
      final authUserState = context.watch<GetAuthenticatedUserCubit>().state;

      return TextButton(
        onPressed: () {
          context.read<GetdoneebycodeCubit>().getDoneeByCode(doneeCode);
          context.read<GetPaymentMethodsCubit>().getPaymentMethods();
          context.read<GetDonationFeesCubit>().getFees();
          Navigator.push(
              context,
              AppRouter.routeToPage(DonationDetialsScreen(
                
                isEnableGiftAid: authUserState is GetAuthenticatedUserSuccess
                    ? authUserState.getAuthenticatedUserModel.data.user.donor
                        .giftAidEnabled
                    : userState is Authenticated
                        ? userState.userData.user.donor.giftAidEnabled
                        : false,
              )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //
            DoneeLogoWidget(imageUrl: imageUrl),
            //
            const SizedBox(
              width: 16,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "$address",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ))
          ]),
        ),
      );
    });
  }
}
