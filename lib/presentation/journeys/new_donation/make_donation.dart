import 'package:flutter/material.dart';
import 'package:idonatio/presentation/journeys/new_donation/scan_for_donee.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/recentdonees_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../reusables.dart';
import '../../router/app_router.dart';
import '../../themes/app_color.dart';
import '../../widgets/donee_list_tile_widget.dart';
import '../../widgets/labels/base_label_text.dart';
import '../../widgets/labels/level_2_heading.dart';
import '../../widgets/labels/level_6_headline.dart';
import '../../widgets/loaders/primary_app_loader_widget.dart';
import '../saved_donees/saved_donee_screen.dart';
import 'add_donee_by_id.dart';

class MakeDonationScreen extends StatefulWidget {
  const MakeDonationScreen({Key? key}) : super(key: key);

  @override
  State<MakeDonationScreen> createState() => _MakeDonationScreenState();
}

class _MakeDonationScreenState extends State<MakeDonationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async =>
              context.read<GetRecentdoneesCubit>().getRecentDonees(),
          child: Container(
            decoration: gradientBoxDecoration(),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Level2Headline(text: 'Make a donation'),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            BaseLabelText(
                                text:
                                    'Add or select a donee you???ll like to make a donation to.'),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Level6Headline(
                              text: 'New donee',
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      AppRouter.routeToPage(
                                          const AddDoneeByIdScreen())),
                                  child: ListTile(
                                    iconColor: Theme.of(context).primaryColor,
                                    dense: true,
                                    leading: const Icon(
                                        Icons.add_circle_outline_rounded),
                                    title: Text(
                                      'Add by ID',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.text80Primary,
                                          ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        AppRouter.routeToPage(
                                            const ScanForDoneeScreen()));
                                  },
                                  child: ListTile(
                                    iconColor: Theme.of(context).primaryColor,
                                    dense: true,
                                    leading: const Icon(Icons.qr_code_2),
                                    title: Text(
                                      'Scan QR Code',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.text80Primary,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      // recent saved donees
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<GetRecentdoneesCubit>()
                                        .getRecentDonees();
                                  },
                                  child: const Level6Headline(
                                    text: 'Recent',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (() => Navigator.push(
                                      context,
                                      AppRouter.routeToPage(
                                          const SavedDoneeScreen(
                                        showBackButton: true,
                                      )))),
                                  child: Text(
                                    "Saved Donees".toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          // empty list
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Builder(builder: (context) {
                                final doneeState =
                                    context.watch<GetRecentdoneesCubit>().state;
                                return doneeState is RecentdoneesSuccessful &&
                                        doneeState.recentDoneesResponseModel
                                            .data!.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          'Get started by adding a donee above.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }),
                              const SizedBox(
                                height: 8,
                              ),
                              BlocConsumer<GetRecentdoneesCubit,
                                  RecentdoneesState>(
                                listener: (context, state) {
                                  if (state is RecentdoneesFailed) {}
                                },
                                builder: (context, state) {
                                  if (state is RecentdoneesSuccessful &&
                                      state.recentDoneesResponseModel.data!
                                          .isNotEmpty) {
                                    return RefreshIndicator(
                                      onRefresh: () async {
                                        context
                                            .read<GetRecentdoneesCubit>()
                                            .getRecentDonees();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: whiteContainerBackGround(),
                                        child: Column(children: [
                                          ...?state
                                              .recentDoneesResponseModel.data
                                              ?.map((e) => DoneeListTile(
                                                    imageUrl: e.imageUrl,
                                                    key: Key(e.id),
                                                    address: e.fullAddress,
                                                    doneeCode: e.doneeCode,
                                                    name: e.fullName,
                                                  )),
                                        ]),
                                      ),
                                    );
                                  } else if (state is RecentdoneesLoading) {
                                    return const Center(
                                      child: PrimaryAppLoader(),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      'A list of your recent donees will appear here once you make a donation or add a donee to your list.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          // end empty list
                        ],
                      ),
                      // end recent saved donees
                    ],
                  ),
                ),
                Positioned(
                    left: 16,
                    top: 0,
                    child: InkWell(
                      splashColor: AppColor.basePrimary,
                      onTap: () {
                        context.read<GetRecentdoneesCubit>().getRecentDonees();
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: AppColor.basePrimary,
                        size: 28,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
