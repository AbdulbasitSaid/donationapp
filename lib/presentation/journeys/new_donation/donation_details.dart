
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_cart_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_process_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_donation_fees_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/enable_gift_aid_for_new_donation.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../widgets/cards/cart_item_widget.dart';
import '../../widgets/cards/detail_card_for_organisation_widget.dart';
import '../../widgets/cards/include_transaction_fee_widget.dart';
import '../../widgets/dialogs/donation_cart_dialog_content_widget.dart';
import 'entities/donation_item_entity.dart';
import 'entities/donation_process_entity.dart';

class DonationDetialsScreen extends StatefulWidget {
  const DonationDetialsScreen({Key? key}) : super(key: key);

  @override
  State<DonationDetialsScreen> createState() => _DonationDetialsScreenState();
}

class _DonationDetialsScreenState extends State<DonationDetialsScreen> {
  bool? isDonateAnonymously = false;
  bool? isEnableGiftAid = false;
  @override
  void initState() {
    context.read<GetDonationFeesCubit>().getFees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              context.read<DonationCartCubit>().emptyCart();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: AppColor.appBackground,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24,
                ),
                child: Level2Headline(text: 'Donation details'.toUpperCase()),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Level6Headline(text: 'Donating to:'),
              ),
              // Donee Detail card
              BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                builder: (context, state) {
                  if (state is GetdoneebycodeSuccess) {
                    if (state.doneeResponseData.organization?.id != null) {
                      return DetailCardForOrganisationWidget(
                        address: state.doneeResponseData.organization
                                ?.addressLine_1 ??
                            'has no address',
                        id: state.doneeResponseData.doneeCode,
                        name: state.doneeResponseData.organization?.name,
                      );
                    } else {
                      return DetailCardForIndividualWidget(
                        id: state.doneeResponseData.doneeCode,
                        name: state.doneeResponseData.fullName,
                        address: state.doneeResponseData.addressLine_1,
                      );
                    }
                  } else if (state is GetdoneebycodeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(child: Text('failed to get donee'));
                  }
                },
              ),
              const SizedBox(
                height: 32,
              ),
              // add/edit Ui
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Level6Headline(text: 'Donation type and amount'),
                    BlocBuilder<DonationCartCubit, List<DonationItemEntity>>(
                      builder: (context, state) {
                        if (state.isNotEmpty) {
                          return TextButton(
                              onPressed: () {
                                showDonationCartDialoge(context);
                              },
                              child: Text('add/edit'.toUpperCase()));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<DonationCartCubit, List<DonationItemEntity>>(
                builder: (context, cartState) {
                  if (cartState.isEmpty) {
                    return TextButton(
                      onPressed: () {
                        showDonationCartDialoge(context);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            SizedBox(
                              width: 32,
                            ),
                            Text('Add donation type')
                          ],
                        ),
                      ),
                    );
                  } else if (cartState.isNotEmpty) {
                    double amount = cartState
                        .map((e) => e.amount)
                        .toList()
                        .reduce((a, b) => a + b);

                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Column(
                              children: cartState
                                  .map((e) => CartItemWdiget(
                                        e,
                                        key: Key(e.id),
                                      ))
                                  .toList()),
                          const Divider(),
                          const IncludeTransactionFeeWidget(),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: BlocBuilder<DonationProcessCubit,
                                    DonationProcessEntity>(
                                builder: (context, donationProcessState) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.text90Primary,
                                            fontSize: 16),
                                  ),
                                  BlocBuilder<GetdoneebycodeCubit,
                                      GetdoneebycodeState>(
                                    builder: (context, state) {
                                      if (state is GetdoneebycodeSuccess) {
                                        return Text(getCurrencySymbol(
                                                '${state.doneeResponseData.country.currencyCode}',
                                                context) +
                                            (amount +
                                                    (donationProcessState
                                                            .paidTransactionFee
                                                        ? getCharge(
                                                            amount,
                                                            donationProcessState
                                                                .currency)
                                                        : 0))
                                                .toStringAsFixed(2));
                                      }
                                      return Text(getCurrencySymbol(
                                              'gbp', context) +
                                          (amount +
                                                  (donationProcessState
                                                          .paidTransactionFee
                                                      ? getCharge(
                                                          amount,
                                                          donationProcessState
                                                              .currency)
                                                      : 0))
                                              .toStringAsFixed(2));
                                    },
                                  ),
                                ],
                              );
                            }),
                          )
                        ],
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 16,
              ),
// donation options
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Level6Headline(text: 'Donation options'),
              ),
              BlocBuilder<DonationProcessCubit, DonationProcessEntity>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        //enabling gift aid
                        TextButton(
                          onPressed: () => context
                              .read<DonationProcessCubit>()
                              .updateDonationProccess(state.copyWith(
                                applyGiftAidToDonation:
                                    !state.applyGiftAidToDonation,
                              )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                  value: state.applyGiftAidToDonation,
                                  onChanged: (onChanged) {
                                    context
                                        .read<DonationProcessCubit>()
                                        .updateDonationProccess(state.copyWith(
                                            applyGiftAidToDonation:
                                                !state.applyGiftAidToDonation));
                                  }),
                              Flexible(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Enable GiftAid on this donation',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Your donee gets an additional 25% on your donation – at no extra cost to you.',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        //todo make this selection start from user details
                        // toggle donate anonymously
                        TextButton(
                          onPressed: () {
                            context
                                .read<DonationProcessCubit>()
                                .updateDonationProccess(state.copyWith(
                                    isAnonymous: !state.isAnonymous));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                  value: state.isAnonymous,
                                  onChanged: (onChanged) {
                                    context
                                        .read<DonationProcessCubit>()
                                        .updateDonationProccess(state.copyWith(
                                            isAnonymous: !state.isAnonymous));
                                  }),
                              Flexible(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Donate anonymously',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Your donee may still be able to identify you as a donor in certain situations. Learn more', //ToDo make learn more selectable
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  );
                },
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<DonationCartCubit, List<DonationItemEntity>>(
                    builder: (context, cartState) {
                      double total = cartState.isEmpty
                          ? 0
                          : cartState
                              .map((e) => e.amount)
                              .toList()
                              .reduce((a, b) => a + b);

                      return BlocBuilder<DonationProcessCubit,
                          DonationProcessEntity>(
                        builder: (context, state) {
                          return BlocBuilder<GetdoneebycodeCubit,
                              GetdoneebycodeState>(
                            builder: (context, doneeState) {
                              if (doneeState is GetdoneebycodeSuccess) {
                                return ElevatedButton(
                                    onPressed: total < 1
                                        ? null
                                        : () {
                                            context
                                                .read<DonationProcessCubit>()
                                                .updateDonationProccess(state.copyWith(
                                                    stripeConnectedAccountId:
                                                        doneeState
                                                            .doneeResponseData
                                                            .stripeConnectedAccountId,
                                                    saveDonee: true,
                                                    doneeId: doneeState
                                                        .doneeResponseData.id,
                                                    currency: (doneeState
                                                                .doneeResponseData
                                                                .organization
                                                                ?.id ==
                                                            null)
                                                        ? doneeState
                                                            .doneeResponseData
                                                            .country
                                                            .currencyCode
                                                        : doneeState
                                                            .doneeResponseData
                                                            .organization!
                                                            .country!
                                                            .currencyCode,
                                                    amount: total,
                                                    donationDetails: [
                                                      ...cartState.map((e) =>
                                                          DonationProcessDetail(
                                                              donationTypeId:
                                                                  e.id,
                                                              amount: e.amount))
                                                    ]));
                                            Navigator.push(
                                                context,
                                                AppRouter.routeToPage(
                                                    const EnableGiftAidForDonation()));
                                          },
                                    child: Row(
                                      children: [
                                        Text('continue'.toUpperCase()),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Icon(Icons.arrow_right_alt)
                                      ],
                                    ));
                              }
                              return ElevatedButton(
                                  onPressed: null,
                                  child: Row(
                                    children: [
                                      Text('continue'.toUpperCase()),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Icon(Icons.arrow_right_alt)
                                    ],
                                  ));
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 56,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showDonationCartDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              scrollable: true,
              title: const Level4Headline(
                text: 'Add donation type',
              ),
              content: const DonationCartDialogContent(),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text('cancle'.toUpperCase()),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Ok');
                  },
                  child: Text('ok'.toUpperCase()),
                ),
              ],
            ));
  }
}
