import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:idonatio/data/models/donation_models/donation_history_model.dart';
import 'package:idonatio/presentation/journeys/donation_history/donee_detail_history.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:intl/intl.dart';

import '../../widgets/labels/level_6_headline.dart';

class DonationHistoryDetialsScreen extends StatefulWidget {
  const DonationHistoryDetialsScreen(
      {Key? key, required this.donationHistoryData})
      : super(key: key);
  final DonationHistoryData donationHistoryData;

  @override
  State<DonationHistoryDetialsScreen> createState() =>
      _DonationHistoryDetialsScreenState();
}

class _DonationHistoryDetialsScreenState
    extends State<DonationHistoryDetialsScreen> {
  bool dialog = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  dialog = !dialog;
                });
              },
              icon: const Icon(FeatherIcons.moreVertical))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: gradientBoxDecoration(),
        child: Stack(
          children: [
            SingleChildScrollView(
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
                            text: widget.donationHistoryData.donee
                                        .organization ==
                                    null
                                ? '${widget.donationHistoryData.donee.firstName} ${widget.donationHistoryData.donee.firstName}'
                                : '${widget.donationHistoryData.donee.organization?.name}'),
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
                    child: Column(
                      children: [
                        Text(widget.donationHistoryData.donee.organization ==
                                null
                            ? '${widget.donationHistoryData.donee.addressLine_1} ${widget.donationHistoryData.donee.addressLine_2}'
                            : '${widget.donationHistoryData.donee.organization?.addressLine_1} ${widget.donationHistoryData.donee.organization?.addressLine_1}'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ),
                  child: Text(
                      'DONEE ID: ${widget.donationHistoryData.donee.doneeCode} '),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Level6Headline(
                      text:
                          ' ${DateFormat.yMMMMEEEEd().format(widget.donationHistoryData.createdAt)}, ${DateFormat.jm().format(widget.donationHistoryData.createdAt).toLowerCase()} '),
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
                              '£${widget.donationHistoryData.donationDetails.map((e) => e.amount).toList().reduce((value, element) => value! + element!)!}',
                        ),
                      ],
                    ),
                    const Divider(),
                    ...widget.donationHistoryData.donationDetails.map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${e.donationType?.type}'),
                            Text('£${e.amount!}'),
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
                          Text(widget.donationHistoryData.isAnonymous
                              ? 'yes'
                              : 'no'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('GiftAid enabled?'),
                          Text(widget.donationHistoryData.applyGiftAidToDonation
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
                            '${widget.donationHistoryData.cardType} **** ${widget.donationHistoryData.cardLastFourDigits}'),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                            'Exp. ${widget.donationHistoryData.expiryMonth}/${widget.donationHistoryData.expiryYear}'),
                      ],
                    )
                  ]),
                ),
              ],
            )),
            dialog
                ? Positioned(
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: FittedBox(
                        child: Column(children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  dialog = !dialog;
                                });
                                Navigator.push(
                                    context,
                                    DoneeDetailHistory.route(
                                        donationData:
                                            widget.donationHistoryData));
                              },
                              child: Text(
                                'Donee details',
                                style: Theme.of(context).textTheme.bodyText1,
                              ))
                        ]),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
