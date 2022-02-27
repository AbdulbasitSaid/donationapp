import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../journeys/donation_history/cubit/donation_history_summary_cubit.dart';
import '../reusables.dart';
import 'labels/level_2_heading.dart';

class DonationSummaryWidget extends StatelessWidget {
  const DonationSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationHistorySummaryCubit,
        DonationHistorySummaryState>(
      builder: (context, state) {
        if (state is DonationHistorySummarySuccess) {
          return Container(
            decoration: whiteContainerBackGround(),
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Number of donations '),
                    Text(
                        '${state.summaryModel.data.numberOfDonations.toInt()} '),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Average donation amount '),
                    Text(
                        '£${state.summaryModel.data.averageDonationAmount.toStringAsFixed(2)} '),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total donation amount '),
                    Text(
                        '£${state.summaryModel.data.totalDonationAmount.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ]),
          );
        } else if (state is DonationHistorySummaryFailure) {
          return Center(
            child: Level2Headline(text: state.errorMessage),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
