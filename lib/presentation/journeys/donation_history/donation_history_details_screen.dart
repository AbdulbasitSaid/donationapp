import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:idonatio/data/models/donation_models/donee_history_datum_model.dart';
import 'package:idonatio/presentation/journeys/donation_history/donee_detail_history.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/widgets/donee_logo_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:intl/intl.dart';

import '../../widgets/buttons/logout_button_widget.dart';
import '../../widgets/deactivated_sign_widget.dart';
import '../../widgets/labels/level_6_headline.dart';

class DonationHistoryDetialsScreen extends StatefulWidget {
  const DonationHistoryDetialsScreen(
      {Key? key, required this.donationHistoryData})
      : super(key: key);
  final DonationHistoryDatumModel donationHistoryData;

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
          const LogoutButton(),
          IconButton(
              onPressed: () {
                setState(() {
                  dialog = !dialog;
                });
              },
              icon: const Icon(FeatherIcons.moreVertical)),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ),
                  child: Text('Donation to:'.toUpperCase()),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Level2Headline(
                                text:
                                    widget.donationHistoryData.donee.fullName),
                            const SizedBox(
                              height: 8,
                            ),
                            widget.donationHistoryData.donee.isActive == false
                                ? const DeactivatedSignWidget()
                                : const SizedBox.shrink()
                          ],
                        ),
                        DoneeLogoWidget(
                          imageUrl: widget.donationHistoryData.donee.imageUrl,
                        ),
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
                        Text(widget.donationHistoryData.donee.fullAddress),
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
                          ' ${DateFormat.yMMMMEEEEd().format(widget.donationHistoryData.createdAt)}, ${DateFormat.jm().format(widget.donationHistoryData.createdAt.toLocal()).toLowerCase()} '),
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
                              '£${(widget.donationHistoryData.totalPayment).toStringAsFixed(2)}',
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
                            Text('${e.donationType.type}'),
                            Text('£${e.amount.toStringAsFixed(2)}'),
                          ],
                        ),
                      ),
                    ),
                    widget.donationHistoryData.paidTransactionFee
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Included transaction fee'),
                                Text(widget.donationHistoryData.transationFee
                                    .toStringAsFixed(2)),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
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
