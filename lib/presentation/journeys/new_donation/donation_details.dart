import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_cart_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_process_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_payment_methods_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/enable_gift_aid_for_new_donation.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import 'entities/donation_item_entity.dart';
import 'entities/donation_process_entity.dart';

class DonationDetialsScreen extends StatefulWidget {
  const DonationDetialsScreen({Key? key}) : super(key: key);

  @override
  State<DonationDetialsScreen> createState() => _DonationDetialsScreenState();
}

class _DonationDetialsScreenState extends State<DonationDetialsScreen> {
  // bool isAddTransactionFee = false;
  bool? isDonateAnonymously = false;
  bool? isEnableGiftAid = false;
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
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24,
                ),
                child: Level2Headline(text: 'Donation details'),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Level6Headline(text: 'Donating to:'),
              ),
              // Denee Detail card
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
                        id: state.doneeResponseData.id,
                        name:
                            '${state.doneeResponseData.firstName} ${state.doneeResponseData.lastName}',
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
                    return GestureDetector(
                      onTap: () {
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
                        GestureDetector(
                          onTap: () => context
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
                        GestureDetector(
                          onTap: () {
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
                    // setState(() {
                    //   Navigator.pop(context, 'Cancel');
                    // });
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text('cancle'.toUpperCase()),
                ),
                TextButton(
                  onPressed: () {
                    // setState(() {
                    //   Navigator.pop(context, 'Ok');
                    // });
                    Navigator.pop(context, 'Ok');
                  },
                  child: Text('ok'.toUpperCase()),
                ),
              ],
            ));
  }
}

class IncludeTransactionFeeWidget extends StatelessWidget {
  const IncludeTransactionFeeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationProcessCubit, DonationProcessEntity>(
      builder: (context, dpState) {
        return GestureDetector(
          onTap: () {
            context.read<DonationProcessCubit>().updateDonationProccess(dpState
                .copyWith(paidTransactionFee: !dpState.paidTransactionFee));
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                      value: dpState.paidTransactionFee,
                      onChanged: (value) {
                        context
                            .read<DonationProcessCubit>()
                            .updateDonationProccess(dpState.copyWith(
                                paidTransactionFee:
                                    !dpState.paidTransactionFee));
                      }),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Include transaction fee',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Ensure your donee receives 100% of your donation amount.',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  BlocBuilder<DonationProcessCubit, DonationProcessEntity>(
                    builder: (context, donationProcessState) {
                      return BlocConsumer<GetPaymentMethodsCubit,
                          GetPaymentMethodsState>(
                        listener: (context, paymentState) {
                          if (paymentState is GetPaymentMethodsFailed) {
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, paymentState) {
                          if (paymentState is GetPaymentMethodsSuccessful) {
                            return BlocBuilder<DonationCartCubit,
                                List<DonationItemEntity>>(
                              builder: (context, cartState) {
                                var listOfamount =
                                    cartState.map((e) => e.amount).toList();
                                var amount = listOfamount.reduce(
                                    (value, element) => value + element);

                                double totalCharge = getCharge(
                                    amount, donationProcessState.currency);
                                context
                                    .read<DonationProcessCubit>()
                                    .updateDonationProccess(
                                        donationProcessState.copyWith(
                                      stripeFee: stripeRatio(paymentState
                                          .paymentMethods.data.first.country),
                                      idonatoiFee: amount * .03,
                                    ));
                                return BlocBuilder<GetdoneebycodeCubit,
                                    GetdoneebycodeState>(
                                  builder: (context, state) {
                                    if (state is GetdoneebycodeSuccess) {
                                      return Text(
                                          '${getCurrencySymbol('${state.doneeResponseData.country.currencyCode}', context)} ${amount == 0 ? 0 : totalCharge.toStringAsFixed(2)}');
                                    }
                                    return Text(
                                        '${getCurrencySymbol('gbp', context)} ${amount == 0 ? 0 : totalCharge.toStringAsFixed(2)}');
                                  },
                                );
                              },
                            );
                          } else if (paymentState is GetPaymentMethodsLoading) {
                            return const Text('0...');
                          } else {
                            return const Text('error..');
                          }
                        },
                      );
                    },
                  ),
                ],
              )),
        );
      },
    );
  }
}

class DonationCartDialogContent extends StatefulWidget {
  const DonationCartDialogContent({Key? key}) : super(key: key);

  @override
  State<DonationCartDialogContent> createState() =>
      _DonationCartDialogContentState();
}

class _DonationCartDialogContentState extends State<DonationCartDialogContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
      builder: (context, state) {
        if (state is GetdoneebycodeSuccess) {
          final donationTypes = state.doneeResponseData.donationTypes;
          // var cartState = ;

          return Column(
            children: donationTypes
                .map((e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          context.read<DonationCartCubit>().addToCart(
                                DonationItemEntity(
                                    description: e.description,
                                    id: e.id,
                                    type: e.type),
                              );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                                value: BlocProvider.of<DonationCartCubit>(
                                        context,
                                        listen: false)
                                    .state
                                    .map((e) => e.id)
                                    .contains(e.id),
                                onChanged: (onChanged) {
                                  setState(() {
                                    context.read<DonationCartCubit>().addToCart(
                                          DonationItemEntity(
                                              description: e.description,
                                              id: e.id,
                                              type: e.type),
                                        );
                                  });
                                }),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Level4Headline(text: e.type),
                                Text(e.description),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ))
                .toList(),
          );
        } else {
          return const Level2Headline(text: 'Error');
        }
      },
    );
  }
}

class DetailCardForOrganisationWidget extends StatelessWidget {
  const DetailCardForOrganisationWidget({
    Key? key,
    required this.name,
    this.address,
    required this.id,
  }) : super(key: key);
  final String? name;
  final String? address;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DoneeAvatarPlaceHolder(),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  '$name',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 16,
                        color: AppColor.text90Primary,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // address
                Text(
                  '$address',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 8,
                ),
                // donee id
                Text(
                  'Donee ID: $id',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified_outlined,
            color: AppColor.darkSecondaryGreen,
          ),
        ],
      ),
    );
  }
}

class DetailCardForIndividualWidget extends StatelessWidget {
  const DetailCardForIndividualWidget({
    Key? key,
    this.name,
    this.address,
    required this.id,
  }) : super(key: key);
  final String? name;
  final String? address;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DoneeAvatarPlaceHolder(),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  '$name',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 16,
                        color: AppColor.text90Primary,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // address
                Text(
                  '$address',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 8,
                ),
                // donee id
                Text(
                  'Donee ID: $id',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified_outlined,
            color: AppColor.darkSecondaryGreen,
          ),
        ],
      ),
    );
  }
}

class CartItemWdiget extends StatefulWidget {
  const CartItemWdiget(
    this._donationItemEntity, {
    Key? key,
  }) : super(key: key);
  final DonationItemEntity _donationItemEntity;

  @override
  State<CartItemWdiget> createState() => _CartItemWdigetState();
}

class _CartItemWdigetState extends State<CartItemWdiget> {
  late TextEditingController amountController;
  @override
  void initState() {
    amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amountController.clear();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget._donationItemEntity.type,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16, color: AppColor.text80Primary),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget._donationItemEntity.description,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          )),
          SizedBox(
              width: 96,
              height: 48,
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefix: BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                    builder: (context, state) {
                      if (state is GetdoneebycodeSuccess) {
                        return Text(getCurrencySymbol(
                            '${state.doneeResponseData.country.currencyCode}',
                            context));
                      }
                      return Text(getCurrencySymbol('gbp', context));
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    context.read<DonationCartCubit>().editAmount(
                          DonationItemEntity(
                            id: widget._donationItemEntity.id,
                            type: widget._donationItemEntity.type,
                            description: widget._donationItemEntity.description,
                            amount: double.tryParse(value) ?? 0.0,
                          ),
                        );
                  });
                },
              )),
        ],
      ),
    );
  }
}

double stripeRatio(String code) {
  return code.toLowerCase() == 'gbp' ? .0165 + .02 : .0315 + .02;
}

double getCharge(double amount, String currencyCode) {
  var stripeCharge = (amount * stripeRatio(currencyCode));
  var idonationCharge = amount * .03;
  var totalCharge = (stripeCharge + idonationCharge);
  return totalCharge;
}
