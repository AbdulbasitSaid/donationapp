import 'package:flutter/material.dart';
import 'package:idonatio/presentation/widgets/donee_logo_widget.dart';
import 'package:intl/intl.dart';

import '../../themes/app_color.dart';

class DonationHistoryListCard extends StatelessWidget {
  final DonationHistoryListCardEntity donationHistoryListCardEntity;
  const DonationHistoryListCard({
    Key? key,
    required this.donationHistoryListCardEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        donationHistoryListCardEntity.rank == 1
            ? Column(
                children: [
                  Text(
                    '${DateFormat.EEEE().format(donationHistoryListCardEntity.dontionDate)},${DateFormat.d().format(donationHistoryListCardEntity.dontionDate)} ${DateFormat.MMMM().format(donationHistoryListCardEntity.dontionDate)}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.text70Primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              )
            : const SizedBox.shrink(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DoneeLogoWidget(
                  imageUrl: donationHistoryListCardEntity.imgUrl,
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      donationHistoryListCardEntity.name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                            color: AppColor.text80Primary,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      donationHistoryListCardEntity.donationType,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 12,
                            color: AppColor.text70Primary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '£${donationHistoryListCardEntity.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    color: AppColor.text80Primary,
                  ),
            )
          ],
        )
      ],
    );
  }
}

class DonationHistoryListCardEntity {
  final String name;
  final String donationType;
  final double amount;
  final DateTime dontionDate;
  final int rank;
  final String? imgUrl;
  DonationHistoryListCardEntity({
    required this.name,
    required this.donationType,
    required this.amount,
    required this.dontionDate,
    required this.rank,
    required this.imgUrl,
  });
}
