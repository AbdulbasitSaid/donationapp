import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/loaders/primary_app_loader_widget.dart';

import '../../widgets/buttons/logout_button_widget.dart';
import '../../widgets/input_fields/donation_history_list_card_item.dart';
import '../donation_history/bloc/get_donation_history_by_donee_id_bloc.dart';
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
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      context
          .read<GetDonationHistoryByDoneeIdBloc>()
          .add(const GetDonationHistoryByDoneeIdFetched(id: ''));
    } else {
      return;
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [LogoutButton()],
      ),
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
                      BlocBuilder<GetDonationHistoryByDoneeIdBloc,
                          GetDonationHistoryByDoneeIdState>(
                        builder: (context, state) {
                          switch (state.status) {
                            case GetDonationHistoryByDoneeIdStatus.failue:
                              return const Level2Headline(
                                  text: 'Failed to get donee');
                            case GetDonationHistoryByDoneeIdStatus.loading:
                              return const Level2Headline(text: 'Loading...');
                            case GetDonationHistoryByDoneeIdStatus.success:
                              return Level2Headline(
                                text:
                                    state.donationHistory.first.donee.fullName,
                              );
                            default:
                              return const Level2Headline(text: 'Loading...');
                          }
                        },
                      )
                    ]),
              ),
            ),
          ),
          BlocConsumer<GetDonationHistoryByDoneeIdBloc,
              GetDonationHistoryByDoneeIdState>(
            listener: (context, state) => {},
            builder: (context, state) {
              if (state.status == GetDonationHistoryByDoneeIdStatus.success) {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return index == state.donationHistory.length
                              ? const Center(child: PrimaryAppLoader())
                              : DonationHistoryByIdListCardItem(
                                  firstThisMonthKey: Key(state.donationHistory
                                      .where((element) =>
                                          element.monthRanking == 'this-month')
                                      .first
                                      .id),
                                  earlierMonthKey: state.donationHistory
                                          .where((element) =>
                                              element.monthRanking == 'earlier')
                                          .isNotEmpty
                                      ? Key(state.donationHistory
                                          .where((element) =>
                                              element.monthRanking == 'earlier')
                                          .first
                                          .id)
                                      : Key(state.donationHistory
                                          .where((element) =>
                                              element.monthRanking ==
                                              'this-month')
                                          .first
                                          .id),
                                  key: Key(state.donationHistory[index].id),
                                  donationData: state.donationHistory[index],
                                );
                        },
                        itemCount: state.hasReachedMax == true
                            ? state.donationHistory.length
                            : state.donationHistory.length + 1,
                        controller: _scrollController,
                      ),
                    ),
                  ]),
                );
              } else if (state.status ==
                  GetDonationHistoryByDoneeIdStatus.initial) {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    const Center(
                      child: PrimaryAppLoader(),
                    )
                  ]),
                );
              } else if (state.status ==
                  GetDonationHistoryByDoneeIdStatus.loading) {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    const Center(
                      child: PrimaryAppLoader(),
                    )
                  ]),
                );
              } else {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    const Center(
                      child: Text(' Loading.'),
                    )
                  ]),
                );
              }
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
              context.watch<GetDonationHistoryByDoneeIdBloc>().state;
          return FloatingActionButton.extended(
            onPressed: () {
              context.read<GetdoneebycodeCubit>().getDoneeByCode(
                  getDoneeHistoryByIdState.status ==
                          GetDonationHistoryByDoneeIdStatus.success
                      ? getDoneeHistoryByIdState
                          .donationHistory.first.donee.doneeCode
                      : '');
              context.read<GetPaymentMethodsCubit>().getPaymentMethods();
              Navigator.push(
                  context,
                  AppRouter.routeToPage(DonationDetialsScreen(
                    isEnableGiftAid:
                        authenticatedUserState is GetAuthenticatedUserSuccess
                            ? authenticatedUserState.getAuthenticatedUserModel
                                .data.user.donor!.giftAidEnabled
                            : userState is Authenticated
                                ? userState.userData.user.donor!.giftAidEnabled
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
