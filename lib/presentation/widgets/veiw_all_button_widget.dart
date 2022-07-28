import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../journeys/donation_history/bloc/get_donation_history_by_donee_id_bloc.dart';
import '../journeys/donations_to_donee/donations_to_donee_screen.dart';
import '../router/app_router.dart';

class ViewAllButtonWidget extends StatelessWidget {
  const ViewAllButtonWidget({Key? key, required this.doneeId})
      : super(key: key);
  final String doneeId;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          context
              .read<GetDonationHistoryByDoneeIdBloc>()
              .add(GetDonationHistoryByDoneeIdFetched(id: doneeId));
          Navigator.push(
              context, AppRouter.routeToPage(const DonationsTodoneeScreen()));
        },
        child: Text('view all'.toUpperCase()));
  }
}
