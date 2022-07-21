import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/models/donation_models/donee_history_datum_model.dart';
import 'package:idonatio/presentation/widgets/donee_logo_widget.dart';
import 'package:intl/intl.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../journeys/donation_history/cubit/donation_history_summary_cubit.dart';
import '../../journeys/donation_history/donation_history_details_screen.dart';
import '../../router/app_router.dart';
import '../../themes/app_color.dart';
import '../donee_avatar_place_holder.dart';

class DonationHistoryListCardItem extends StatelessWidget {
  final DonationHistoryDatumModel donationData;
  final String searchTerm;
  const DonationHistoryListCardItem({
    Key? key,
    required this.donationData,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(primary: AppColor.text80Primary),
      onPressed: () {
        context
            .read<DonationHistorySummaryCubit>()
            .getDonationHistoryDetailSummary(donationData.doneeId);
        Navigator.push(
            context,
            AppRouter.routeToPage(DonationHistoryDetialsScreen(
              donationHistoryData: donationData,
            )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            donationData.rank == 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${DateFormat.EEEE().format(donationData.createdAt)},${DateFormat.d().format(donationData.createdAt)} ${DateFormat.MMMM().format(donationData.createdAt)}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.text70Primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoneeLogoWidget(
                      imageUrl: donationData.donee.imageUrl,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubstringHighlight(
                          text: donationData.donee.fullName,
                          term: searchTerm,
                          textStyleHighlight: const TextStyle(
                              color: AppColor.basePrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          donationData.displayDonationType,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "£${donationData.totalPayment}",
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
