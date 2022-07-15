import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/models/donation_models/donee_model.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../journeys/donation_history/cubit/donation_history_summary_cubit.dart';
import '../../journeys/saved_donees/saved_donee_details.dart';
import '../../router/app_router.dart';
import '../../themes/app_color.dart';
import '../donee_avatar_place_holder.dart';

class SavedDoneeListItemWidget extends StatelessWidget {
  const SavedDoneeListItemWidget({
    Key? key,
    required this.highlightString,
    required this.donee,
  }) : super(key: key);
  final DoneeModel donee;
  final String highlightString;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context
            .read<DonationHistorySummaryCubit>()
            .getDonationHistoryDetailSummary(donee.id);
        Navigator.push(context,
            AppRouter.routeToPage(SavedDoneeDetails(donationData: donee)));
      },
      style: TextButton.styleFrom(primary: AppColor.text80Primary),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DoneeAvatarPlaceHolder(),
          const SizedBox(
            width: 16,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SubstringHighlight(
                text: donee.fullName,
                term: highlightString,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
                textStyleHighlight: const TextStyle(
                    color: AppColor.basePrimary, fontWeight: FontWeight.bold),
              ),
              Text(
                '${donee.fullAddress} ',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
