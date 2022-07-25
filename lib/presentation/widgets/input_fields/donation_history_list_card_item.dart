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

class DonationHistoryListCardItem extends StatelessWidget {
  final DonationHistoryDatumModel donationData;
  final String searchTerm;

  final Key firstThisMonthKey;
  final Key earlierMonthKey;
  const DonationHistoryListCardItem({
    Key? key,
    required this.donationData,
    required this.searchTerm,
    required this.earlierMonthKey,
    required this.firstThisMonthKey,
  }) : super(key: key);

  bool _showEarlierMonth() {
    return key == earlierMonthKey ? true : false;
  }

  bool _showThisMonth() {
    return key == firstThisMonthKey ? true : false;
  }

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
            if (_showThisMonth())
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(219, 229, 255, 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'This Month',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                ),
              )
            else if (_showEarlierMonth())
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(213, 251, 232, 0.48),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Earlier',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                ),
              )
            else
              const SizedBox.shrink(),
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
