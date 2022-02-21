import 'package:flutter/material.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
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
          ],
        )),
      ),
    );
  }
}
