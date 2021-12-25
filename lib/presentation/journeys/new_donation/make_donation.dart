import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:idonatio/presentation/journeys/new_donation/add_donee_by_id.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

class MakeDonationScreen extends StatelessWidget {
  const MakeDonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColor.appBackground),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Level2Headline(text: 'Make a donation'),
                SizedBox(
                  height: 16,
                ),
                BaseLabelText(
                    text:
                        'Add or select a donee you’ll like to make a donation to.'),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Level6Headline(
                  text: 'New donee',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          AppRouter.routeToPage(const AddDoneeByIdScreen())),
                      child: ListTile(
                        iconColor: Theme.of(context).primaryColor,
                        dense: true,
                        leading: const Icon(Icons.add_circle_outline_rounded),
                        title: Text(
                          'Add by ID',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.text80Primary,
                                  ),
                        ),
                      ),
                    ),
                    ListTile(
                      iconColor: Theme.of(context).primaryColor,
                      dense: true,
                      leading: const Icon(Icons.qr_code_2),
                      title: Text(
                        'Scan QR Code',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.text80Primary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          // recent saved donees
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Level6Headline(
                      text: 'Recent',
                    ),
                    Text(
                      "Saved Donees".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                // empty list
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get started by adding a donee above.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'A list of your recent donees will appear here once you make a donation or add a donee to your list.',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                    ),
                  ],
                ),
                // end empty list
              ],
            ),
          ),
          // end recent saved donees
        ],
      ),
    );
  }
}
