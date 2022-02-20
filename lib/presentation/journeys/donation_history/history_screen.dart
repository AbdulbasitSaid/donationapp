import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/donation_history_cubit.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../../data/models/donation_models/donation_history_model.dart';
import '../../reusables.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Container(
        decoration: gradientBoxDecoration(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(16),
                  child: Level2Headline(
                    text: 'Your donations',
                  )),
              const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    """
A history of donations you’ve made through this app. Select a donation to view more details.""",
                  )),
              BlocConsumer<DonationHistoryCubit, DonationHistoryState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is DonationHistorySuccess) {
                    final thisMonthDonations = state.donationHistoryModel.data
                        .where((element) =>
                            element.createdAt.month == DateTime.now().month)
                        .toList();
                    final earlierDonations = state.donationHistoryModel.data
                        .where((element) =>
                            element.createdAt.month != DateTime.now().month)
                        .toList();

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Level6Headline(text: 'This month'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: whiteContainerBackGround(),
                            width: MediaQuery.of(context).size.width,
                            child: Column(children: [
                              ...thisMonthDonations
                                  .map((e) => DonationHistoryListCardItem(
                                        donationData: e,
                                      ))
                            ]),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Level6Headline(text: 'Earlier'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: whiteContainerBackGround(),
                            width: MediaQuery.of(context).size.width,
                            child: Column(children: [
                              ...earlierDonations
                                  .map((e) => DonationHistoryListCardItem(
                                        donationData: e,
                                      ))
                            ]),
                          ),
                        ]);
                  }
                  return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Get started by making a donation.',
                              style: Theme.of(context).textTheme.subtitle1),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'A list of your past donations will appear here once you make a donation.',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<DonationHistoryCubit>()
                                  .getDonationHistory();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .6,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border:
                                      Border.all(color: AppColor.basePrimary)),
                              child: Row(children: const [
                                Icon(
                                  Icons.add,
                                  color: AppColor.basePrimary,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'New Donation',
                                  style: TextStyle(
                                      color: AppColor.basePrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ),
                          )
                        ],
                      ));
                },
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    ));
  }
}

class DonationHistoryListCardItem extends StatelessWidget {
  final Data donationData;
  const DonationHistoryListCardItem({
    Key? key,
    required this.donationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DoneeAvatarPlaceHolder(),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      //TODO set up for organisations
                      "${donationData.donee.firstName}  ${donationData.donee.lastName}"),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    donationData.donationDetails.length > 1
                        ? 'Multiple donation types'
                        : donationData.donationDetails.first.donationType.type,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '£${donationData.donationDetails.map((e) => e.amount).toList().reduce((value, element) => value + element) / 100}',
              ),
            ],
          )
        ],
      ),
    );
  }
}
