import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/get_donation_history_by_donee_id_cubit.dart';

import '../journeys/donations_to_donee/donations_to_donee_screen.dart';
import '../router/app_router.dart';

class ViewAllButtonWidget extends StatelessWidget {
  const ViewAllButtonWidget({Key? key, required this.doneeId})
      : super(key: key);
  final String doneeId;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context
              .read<GetDonationHistoryByDoneeIdCubit>()
              .getDonationHistorByDoneeId(doneeId);
          Navigator.push(
              context, AppRouter.routeToPage(const DonationsTodoneeScreen()));
        },
        child: Text('view all'.toUpperCase()));
  }
}
