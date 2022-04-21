import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/get_donation_history_by_donee_id_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import '../../widgets/list_cards/donation_history_list_card_widget.dart';
import '../new_donation/cubit/get_payment_methods_cubit.dart';
import '../new_donation/cubit/getdoneebycode_cubit.dart';
import '../new_donation/donation_details.dart';
import '../user/cubit/get_authenticated_user_cubit.dart';
import '../user/cubit/user_cubit.dart';

class DonationsTodoneeScreen extends StatefulWidget {
  const DonationsTodoneeScreen({
    Key? key,
  }) : super(key: key);
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
          BlocConsumer<GetDonationHistoryByDoneeIdCubit,
              GetDonationHistoryByDoneeIdState>(
            listener: (context, state) => {},
            builder: (context, state) {
              if (state is GetDonationHistoryByDoneeIdSuccess) {
                final doneeData = state.donationHistoryByDoneeIdModel.data;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
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

      //todo change color
      floatingActionButton: Builder(
        builder: (context) {
          final userState = context.watch<UserCubit>().state;
          final authenticatedUserState =
              context.watch<GetAuthenticatedUserCubit>().state;
          final getDoneeHistoryByIdState =
              context.watch<GetDonationHistoryByDoneeIdCubit>().state;
          return FloatingActionButton.extended(
            onPressed: () {
              context.read<GetdoneebycodeCubit>().getDoneeByCode(
                  getDoneeHistoryByIdState is GetDonationHistoryByDoneeIdSuccess
                      ? getDoneeHistoryByIdState.donationHistoryByDoneeIdModel
                          .data.first.donee.doneeCode!
                      : '');
              context.read<GetPaymentMethodsCubit>().getPaymentMethods();
              Navigator.push(
                  context,
                  AppRouter.routeToPage(DonationDetialsScreen(
                    isDonateAnonymously: authenticatedUserState
                            is GetAuthenticatedUserSuccess
                        ? authenticatedUserState.getAuthenticatedUserModel.data
                            .user.donor.donateAnonymously
                        : userState is Authenticated
                            ? userState.userData.user.donor.donateAnonymously
                            : false,
                    isEnableGiftAid:
                        authenticatedUserState is GetAuthenticatedUserSuccess
                            ? authenticatedUserState.getAuthenticatedUserModel
                                .data.user.donor.giftAidEnabled
                            : userState is Authenticated
                                ? userState.userData.user.donor.giftAidEnabled
                                : false,
                  )));
            },
            label: Text('new donation'.toUpperCase()),
            icon: const Icon(
              Icons.add,
            ),
          );
        },
      ),
    );
  }
}
