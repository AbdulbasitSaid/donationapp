import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../../data/models/donation_models/donation_history_model.dart';
import '../../widgets/donee_avatar_place_holder.dart';
import '../../widgets/labels/level_2_heading.dart';

class DoneeDetailHistory extends StatelessWidget {
  const DoneeDetailHistory({Key? key, required this.donationData})
      : super(key: key);
  static Route<String> route({required DonationHistoryData donationData}) {
    return MaterialPageRoute(
        builder: (_) => DoneeDetailHistory(
              donationData: donationData,
            ));
  }

  final DonationHistoryData donationData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: gradientBoxDecoration(),
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                            text: donationData.donee.organization == null
                                ? '${donationData.donee.firstName} ${donationData.donee.firstName}'
                                : '${donationData.donee.organization?.name}'),
                      ]),
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: whiteContainerBackGround(),
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.verified,
                          color: AppColor.darkSecondaryGreen,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verified',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color: AppColor.darkSecondaryGreen,
                                  ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),

                            ///Todo get UkCharity number
                            Text('UK Charity No.${donationData.donee.id}'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          FeatherIcons.hash,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('donee id - ${donationData.donee.doneeCode}'
                                .toUpperCase()),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          FeatherIcons.mapPin,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${donationData.donee.addressLine_1} ${donationData.donee.addressLine_2}'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          FeatherIcons.globe,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(donationData.donee.organization == null
                                ? 'has no website'
                                : "${donationData.donee.organization?.website}"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          FeatherIcons.calendar,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            //todo get date from api
                            Text("Added Sunday, 05 June 2021"),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Level6Headline(text: 'Donation history'),
                      TextButton(
                          //todo create veiw all page
                          onPressed: () {},
                          child: Text('view all'.toUpperCase()))
                    ],
                  ),
                ),
                Container(
                  decoration: whiteContainerBackGround(),
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    //todo populate donation history from api
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Number of donations '),
                          Text('10 '),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Average donation amount '),
                          Text('£35.00 '),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Total donation amount '),
                          Text('£350.00'),
                        ],
                      ),
                    ),
                  ]),
                )
              ]),
              const Positioned(
                  right: 16,
                  top: 50,
                  child: SizedBox(
                      height: 72, width: 72, child: DoneeAvatarPlaceHolder()))
            ],
          ),
        ),
        //todo change color
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //todo naviga to donation for the save donee
            Navigator.pushAndRemoveUntil(context,
                AppRouter.routeToPage(const HomeScreen()), (route) => false);
          },
          label: Text('new donation'.toUpperCase()),
          icon: Icon(
            Icons.add,
          ),
        ));
  }
}
