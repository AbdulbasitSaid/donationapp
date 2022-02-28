import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/get_donation_history_by_donee_id_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/donee_list_tile_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

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
              titlePadding: const EdgeInsets.only(left: 40, top: 40, bottom: 8),
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
                      const Level2Headline(text: 'RCCG East London')
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
                            padding: const EdgeInsets.all(16.0),
                            child: DoneeListTile(
                                name: doneeData[index].donee.fullName,
                                address: doneeData[index].donee.fullAddress,
                                doneeCode: doneeData[index].donee.doneeCode!),
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
