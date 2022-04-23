import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/donation_history_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/add_donee_by_id.dart';
import 'package:idonatio/presentation/journeys/new_donation/scan_for_donee.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../reusables.dart';
import '../../widgets/input_fields/donation_history_list_card_item.dart';

class DonationHistoryScreen extends StatefulWidget {
  const DonationHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  bool isStartSearch = false;
  late TextEditingController _searchController;
  String highlightSearch = '';
  @override
  void initState() {
    _searchController = TextEditingController();
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        context.read<DonationHistoryCubit>().getDonationHistory();
      } else {
        context
            .read<DonationHistoryCubit>()
            .searchDonationHistory(_searchController.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

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
                  isStartSearch == false
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
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is DonationHistoryLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DonationHistorySuccess) {
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

                        return state.donationHistoryModel.data.isEmpty &&
                                isStartSearch == false
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
                                      TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (context) => SimpleDialog(
                                                          title: const Text(
                                                              'Get Donee'),
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.push(
                                                                        context,
                                                                        AppRouter.routeToPage(
                                                                            const AddDoneeByIdScreen()));
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .add_circle_outline_rounded),
                                                                      const SizedBox(
                                                                        width:
                                                                            24,
                                                                      ),
                                                                      Text(
                                                                        'Add by ID',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyLarge,
                                                                      )
                                                                    ],
                                                                  )),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.push(
                                                                        context,
                                                                        AppRouter.routeToPage(
                                                                            const ScanForDoneeScreen()));
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .qr_code_2),
                                                                      const SizedBox(
                                                                        width:
                                                                            24,
                                                                      ),
                                                                      Text(
                                                                        'Scan QR Code',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyLarge,
                                                                      )
                                                                    ],
                                                                  )),
                                                            ),
                                                          ]));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6,
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                    ]),
                              )
                            : isStartSearch == false
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
                                                                searchTerm:
                                                                    highlightSearch,
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
                                                            searchTerm:
                                                                highlightSearch,
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
                                                      searchTerm:
                                                          highlightSearch,
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
                                  showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                              title: const Text('Get Donee'),
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            AppRouter.routeToPage(
                                                                const AddDoneeByIdScreen()));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(Icons
                                                              .add_circle_outline_rounded),
                                                          const SizedBox(
                                                            width: 24,
                                                          ),
                                                          Text(
                                                            'Add by ID',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            AppRouter.routeToPage(
                                                                const ScanForDoneeScreen()));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.qr_code_2),
                                                          const SizedBox(
                                                            width: 24,
                                                          ),
                                                          Text(
                                                            'Scan QR Code',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ]));
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
            isStartSearch == true
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
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          highlightSearch = value;
                        });
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
                                _searchController.clear();
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
