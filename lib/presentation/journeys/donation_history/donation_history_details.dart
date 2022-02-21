import 'package:flutter/material.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:intl/intl.dart';

import '../../widgets/labels/level_6_headline.dart';

class DonationHistoryDetialsScreen extends StatelessWidget {
  const DonationHistoryDetialsScreen(
      {Key? key, required this.donationHistoryData})
      : super(key: key);
  final DonationHistoryData donationHistoryData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: gradientBoxDecoration(),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ),
              child: Text('Donation to:'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Level2Headline(
                        text: donationHistoryData.donee.organization == null
                            ? '${donationHistoryData.donee.firstName} ${donationHistoryData.donee.firstName}'
                            : '${donationHistoryData.donee.organization?.name}'),
                    const DoneeAvatarPlaceHolder(),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: Flexible(
                  child: Text(donationHistoryData.donee.organization == null
                      ? '${donationHistoryData.donee.addressLine_1} ${donationHistoryData.donee.addressLine_2}'
                      : '${donationHistoryData.donee.organization?.addressLine_1} ${donationHistoryData.donee.organization?.addressLine_1}'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ),
              child: Flexible(
                child:
                    Text('DONEE ID: ${donationHistoryData.donee.doneeCode} '),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: Flexible(
                child: Level6Headline(
                    text:
                        ' ${DateFormat.yMMMMEEEEd().format(donationHistoryData.createdAt)}, ${DateFormat.jm().format(donationHistoryData.createdAt).toLowerCase()} '),
              ),
            ),
            Container(
              decoration: whiteContainerBackGround(),
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Level4Headline(text: 'Total payment'),
                    Level4Headline(
                      text:
                          '£${donationHistoryData.donationDetails.map((e) => e.amount).toList().reduce((value, element) => value! + element!)! / 100}',
                    ),
                  ],
                ),
                const Divider(),
                ...donationHistoryData.donationDetails.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${e.donationType?.type}'),
                        Text('£${e.amount! / 100}'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Anonymous donation?'),
                      Text(donationHistoryData.isAnonymous ? 'yes' : 'no'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('GiftAid enabled?'),
                      Text(donationHistoryData.applyGiftAidToDonation
                          ? 'yes'
                          : 'no'),
                    ],
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Level6Headline(text: 'Payment method'),
            ),
            Container(
              decoration: whiteContainerBackGround(),
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                const Icon(Icons.payments),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${donationHistoryData.cardType} **** ${donationHistoryData.cardLastFourDigits}'),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                        'Exp. ${donationHistoryData.expiryMonth}/${donationHistoryData.expiryYear}'),
                  ],
                )
              ]),
            ),
          ],
        )),
      ),
    );
  }
}
