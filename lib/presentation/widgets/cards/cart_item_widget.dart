import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../journeys/new_donation/cubit/donation_cart_cubit.dart';
import '../../journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import '../../journeys/new_donation/entities/donation_item_entity.dart';
import '../../reusables.dart';
import '../../themes/app_color.dart';

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
          const SizedBox(
            width: 16,
          ),
          SizedBox(
              width: 96,
              height: 48,
              child: TextFormField(
                // controller: amountController,
                initialValue: widget._donationItemEntity.amount.toString(),
                textAlign: TextAlign.end,
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
