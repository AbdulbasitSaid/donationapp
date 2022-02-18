import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import '../../reusables.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Container(
        decoration: gradientBoxDecoration(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.all(16),
                child: Level2Headline(
                  text: 'Your donations',
                )),
            const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'A history of donations you’ve made through this app. Select a donation to view more details.',
                )),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Get started by making a donation.',
                        style: Theme.of(context).textTheme.subtitle1),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'A list of your past donations will appear here once you make a donation.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * .6,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: AppColor.basePrimary)),
                        child: Row(children: const [
                          Icon(
                            Icons.add,
                            color: AppColor.basePrimary,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'New Donation',
                            style: TextStyle(
                                color: AppColor.basePrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ]),
                      ),
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: whiteContainerBackGround(),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    ));
  }
}
