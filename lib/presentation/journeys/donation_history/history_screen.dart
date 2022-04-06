import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/donation_history_cubit.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/donation_history_summary_cubit.dart';
import 'package:idonatio/presentation/journeys/donation_history/donation_history_details_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';
import 'package:intl/intl.dart';

import '../../../data/models/donation_models/donation_history_model.dart';
import '../../reusables.dart';

class DonationHistoryScreen extends StatefulWidget {
  const DonationHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  bool isStartSearch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: gradientBoxDecoration(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isStartSearch = !isStartSearch;
                          });
                        },
                        icon: const Icon(Icons.search,
                            size: 32, color: AppColor.text80Primary),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  !isStartSearch
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                                padding: EdgeInsets.all(16),
                                child: Level2Headline(
                                  text: 'Your donations',
                                )),
                            Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  """
A history of donations you’ve made through this app. Select a donation to view more details.""",
                                )),
                          ],
                        )
                      : const SizedBox.shrink(),
                  BlocConsumer<DonationHistoryCubit, DonationHistoryState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is DonationHistoryLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is DonationHistorySuccess) {
                        final thisMonthDonations = state
                            .donationHistoryModel.data
                            .where((element) =>
                                element.createdAt.month == DateTime.now().month)
                            .toList()
                            .where((element) =>
                                element.donationDetails.isNotEmpty);
                        final earlierDonations = state.donationHistoryModel.data
                            .where((element) =>
                                element.createdAt.month != DateTime.now().month)
                            .toList()
                            .where((element) =>
                                element.donationDetails.isNotEmpty);

                        return state.donationHistoryModel.data.isEmpty
                            ? Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                          'Get started by making a donation.'),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                          'A list of your past donations will appear here once you make a donation.'),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.add,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text('New Donation'.toUpperCase())
                                            ],
                                          ))
                                    ]),
                              )
                            : !isStartSearch
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        thisMonthDonations.isNotEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Level6Headline(
                                                        text: 'This month'),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    decoration:
                                                        whiteContainerBackGround(),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(children: [
                                                      ...thisMonthDonations.map(
                                                          (e) =>
                                                              DonationHistoryListCardItem(
                                                                donationData: e,
                                                              ))
                                                    ]),
                                                  ),
                                                  const SizedBox(
                                                    height: 32,
                                                  ),
                                                ],
                                              )
                                            : const SizedBox.shrink(),
                                        //
                                        earlierDonations.isNotEmpty
                                            ? Column(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Level6Headline(
                                                        text: 'Earlier'),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    decoration:
                                                        whiteContainerBackGround(),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(children: [
                                                      ...earlierDonations.map((e) =>
                                                          DonationHistoryListCardItem(
                                                            donationData: e,
                                                          ))
                                                    ]),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox.shrink(),
                                      ])
                                : state.donationHistoryModel.data.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('No results found.'),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'Please try a different search term.',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              )
                                            ]),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(16),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(.8)),
                                        child: Column(
                                          children: [
                                            ...state.donationHistoryModel.data
                                                .map((e) =>
                                                    DonationHistoryListCardItem(
                                                      donationData: e,
                                                    ))
                                          ],
                                        ),
                                      );
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
                              TextButton(
                                onPressed: () {
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
                                      border: Border.all(
                                          color: AppColor.basePrimary)),
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
            isStartSearch
                ? Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: const Color(0xff425A70).withOpacity(.25),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: -2),
                      BoxShadow(
                          color: const Color(0xff425A70).withOpacity(.25),
                          offset: const Offset(0, 0),
                          blurRadius: 1,
                          spreadRadius: 0),
                    ]),
                    child: TextFormField(
                      autofocus: true,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        context
                            .read<DonationHistoryCubit>()
                            .searchDonationHistory(value);
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Search',
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefix: IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: const Icon(
                              FeatherIcons.x,
                              color: AppColor.baseText80Primary,
                            ),
                            onPressed: () {
                              setState(() {
                                context
                                    .read<DonationHistoryCubit>()
                                    .getDonationHistory();
                                isStartSearch = !isStartSearch;
                              });
                            },
                          )),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    ));
  }
}

class DonationHistoryListCardItem extends StatelessWidget {
  final DonationHistoryData donationData;
  const DonationHistoryListCardItem({
    Key? key,
    required this.donationData,
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
                    const DoneeAvatarPlaceHolder(),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(donationData.donee.fullName),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${donationData.displayDonationType}',
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
                      '£${donationData.donationDetails.map((e) => e.amount).toList().reduce((value, element) => value! + element!)!}',
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
