import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../journeys/new_donation/cubit/donation_cart_cubit.dart';
import '../../journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import '../../journeys/new_donation/entities/donation_item_entity.dart';
import '../labels/level_2_heading.dart';
import '../labels/level_4_headline.dart';

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
            children: donationTypes!
                .map((e) => TextButton(
                      onPressed: () {
                        setState(() {
                          context.read<DonationCartCubit>().addToCart(
                                DonationItemEntity(
                                    description: e.description,
                                    id: e.id,
                                    type: e.type!),
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
                                              type: e.type!),
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
                                Level4Headline(
                                    text: e.type == null
                                        ? '${e.name}'
                                        : '${e.type}'),
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

