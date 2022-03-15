import 'package:flutter/material.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';

import '../journeys/new_donation/cubit/get_payment_methods_cubit.dart';
import '../journeys/new_donation/donation_details.dart';
import '../router/app_router.dart';
import 'donee_avatar_place_holder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneeListTile extends StatelessWidget {
  final String? name, address;
  final String doneeCode;
  const DoneeListTile({
    Key? key,
    required this.name,
    required this.address,
    required this.doneeCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<GetdoneebycodeCubit>().getDoneeByCode(doneeCode);
        context.read<GetPaymentMethodsCubit>().getPaymentMethods();
        Navigator.push(
            context, AppRouter.routeToPage(const DonationDetialsScreen()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const DoneeAvatarPlaceHolder(),
          const SizedBox(
            width: 8,
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
  }
}
