import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/get_donation_history_by_donee_id_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import '../../widgets/list_cards/donation_history_list_card_widget.dart';
import '../donation_history/donee_detail_history.dart';

class DonationsTodoneeScreen extends StatefulWidget {
  const DonationsTodoneeScreen({Key? key}) : super(key: key);

  @override
  _DonationsTodoneeScreenState createState() => _DonationsTodoneeScreenState();
}

class _DonationsTodoneeScreenState extends State<DonationsTodoneeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            pinned: true,
            // stretch: true,
            snap: false,
            floating: false,
            expandedHeight: 140,
            backgroundColor: const Color.fromRGBO(219, 229, 255, 1),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                  left: 40, right: 40, top: 40, bottom: 8),
              centerTitle: false,
              background: Container(decoration: gradientBoxDecoration()),
              title: FittedBox(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      Text(
                        'All Donations'.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 10),
                      ),
                      BlocBuilder<GetDonationHistoryByDoneeIdCubit,
                          GetDonationHistoryByDoneeIdState>(
                        builder: (context, state) {
                          if (state is GetDonationHistoryByDoneeIdSuccess) {
                            return Level2Headline(
                                text: state.donationHistoryByDoneeIdModel.data
                                    .first.donee.fullName);
                          }
                          if (state is GetDonationHistoryByDoneeIdFailure) {
                            return const Level2Headline(
                                text: 'Failed to get donee');
                          } else {}
                          return const Level2Headline(text: 'Loading...');
                        },
                      )
                    ]),
              ),
            ),
          ),
          BlocBuilder<GetDonationHistoryByDoneeIdCubit,
              GetDonationHistoryByDoneeIdState>(
            builder: (context, state) {
              if (state is GetDonationHistoryByDoneeIdSuccess) {
                final doneeData = state.donationHistoryByDoneeIdModel.data;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
                            child: TextButton(
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.zero)),
                              onPressed: () {
                                final detial = doneeData[index];
                              },
                              child: DonationHistoryListCard(
                                donationHistoryListCardEntity:
                                    DonationHistoryListCardEntity(
                                  amount: doneeData[index].totalPayment,
                                  donationType:
                                      doneeData[index].displayDationType,
                                  dontionDate: doneeData[index].createdAt,
                                  name: doneeData[index].donee.fullName,
                                  rank: doneeData[index].rank,
                                ),
                              ),
                            ),
                          ),
                      childCount: doneeData.length),
                );
              }
              return SliverList(
                delegate: SliverChildListDelegate([
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                ]),
              );
            },
          )
        ],
      ),
    );
  }
}
