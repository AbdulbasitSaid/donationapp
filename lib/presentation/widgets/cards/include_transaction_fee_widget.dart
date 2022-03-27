import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/models/fees_model.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_payment_methods_cubit.dart';

import '../../../common/stripe_charges_calculations.dart';
import '../../journeys/new_donation/cubit/donation_cart_cubit.dart';
import '../../journeys/new_donation/cubit/donation_process_cubit.dart';
import '../../journeys/new_donation/cubit/get_donation_fees_cubit.dart';
import '../../journeys/new_donation/entities/donation_item_entity.dart';
import '../../journeys/new_donation/entities/donation_process_entity.dart';
import '../../reusables.dart';

class IncludeTransactionFeeWidget extends StatefulWidget {
  const IncludeTransactionFeeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<IncludeTransactionFeeWidget> createState() =>
      _IncludeTransactionFeeWidgetState();
}

class _IncludeTransactionFeeWidgetState
    extends State<IncludeTransactionFeeWidget> {
  @override
  void initState() {
    context.read<GetDonationFeesCubit>().getFees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationProcessCubit, DonationProcessEntity>(
      builder: (context, dpState) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                    value: dpState.paidTransactionFee,
                    onChanged: (value) {
                      context
                          .read<DonationProcessCubit>()
                          .updateDonationProccess(
                              dpState.copyWith(paidTransactionFee: value));
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
                BlocBuilder<DonationCartCubit, List<DonationItemEntity>>(
                  builder: (context, cartState) {
                    double amount =
                        cartState.map((e) => e.amount).toList().reduce(
                              (value, element) => value + element,
                            );
                    return BlocBuilder<GetDonationFeesCubit,
                        GetDonationFeesState>(builder: (context, feeState) {
                      if (feeState is GetDonationFeesLoading) {
                        return const Text('load...');
                      }
                      if (feeState is GetDonationFeesFailed) {
                        return const Text('error.');
                      }
                      if (feeState is GetDonationFeesSuccess) {
                        return BlocBuilder<GetPaymentMethodsCubit,
                            GetPaymentMethodsState>(
                          buildWhen: (previous, current) =>
                              current is GetPaymentMethodsSuccessful,
                          builder: (context, state) {
                            if (state is GetPaymentMethodsSuccessful) {
                              double amount = cartState
                                  .map((e) => e.amount)
                                  .toList()
                                  .reduce((value, element) => value + element);
                              String cardCurrency =
                                  state.paymentMethods.data.first.country;
                              List<FeeData> feeData = feeState.feesModel.data;
                              return Text(
                                '${getCurrencySymbol('gbp', context)}${getCharges(amount: amount, cardCurrency: cardCurrency, feeData: feeData).totalFee}',
                              );
                            } else {
                              return Text(
                                  '${getCurrencySymbol('gbp', context)} ...');
                            }
                          },
                        );
                      }
                      return Text('${getCurrencySymbol('gbp', context)} 0.0');
                    });
                  },
                )
              ],
            ));
      },
    );
  }
}
