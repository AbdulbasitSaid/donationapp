import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/data/models/user_models/user_data_model.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: gradientBoxDecoration(),
        child: ValueListenableBuilder(
            valueListenable: Hive.box<UserData>('user_box').listenable(),
            builder: (context, Box<UserData> box, widget) {
              final userData = box.get('user_data');
              final user = userData?.user;
              final donor = user?.donor;
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16),
                    child: GestureDetector(
                      child: const Icon(Icons.arrow_back),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Level2Headline(
                      text: 'My profile',
                    ),
                  ),
                  //
                  const SizedBox(height: 32),
                  //name
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: Level6Headline(text: 'Name'),
                  ),

                  Container(
                    decoration: whiteContainerBackGround(),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                              '${donor?.title} ${donor?.firstName} ${donor?.lastName}'),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: AppColor.basePrimary,
                            ))
                      ],
                    ),
                  ),
                  //
                  //contact details
                  const SizedBox(height: 32),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: Level6Headline(text: 'Contact details'),
                  ),
                  Container(
                    decoration: whiteContainerBackGround(),
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      //Phone number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.call)),
                          Flexible(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${donor?.phoneNumber}'),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.edit,
                                          color: AppColor.basePrimary,
                                        )),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          )
                        ],
                      ),
                      // end
                      //address
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.place_outlined)),
                          Flexible(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${donor?.address}'),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.edit,
                                          color: AppColor.basePrimary,
                                        )),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          )
                        ],
                      ),
                      // end address
                      // email
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.mail_outline)),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${user?.email}'),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.edit,
                                          color: AppColor.basePrimary,
                                        )),
                                  ],
                                ),
                                Text(
                                    'Your email address is also your login ID.',
                                    style: Theme.of(context).textTheme.caption),
                              ],
                            ),
                          )
                        ],
                      ),
                      //end email
                    ]),
                  ),
                  //end contact details
                  //password
                  const SizedBox(height: 32),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: Level6Headline(text: 'Password'),
                  ),
                  Container(
                    decoration: whiteContainerBackGround(),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.lock_outline)),
                            const Text('*********'),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: AppColor.basePrimary,
                            ))
                      ],
                    ),
                  ),
                  // end password
                  // preferences
                  const SizedBox(height: 32),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: Level6Headline(text: 'Preferences'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: whiteContainerBackGround(),
                    child: Column(children: [
                      // enable disable giftaid
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Enable GiftAid on eligible donations'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Your favourite charities get an additional 25% on eligible donations – at no extra cost to you.',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child:
                                        const Text('Learn more about GiftAid'))
                              ],
                            ),
                          ),
                          Switch(
                              value: donor!.giftAidEnabled,
                              onChanged: (onChanged) {})
                        ],
                      ),
                      const Divider(),
                      // end enable disable giftaid
                      //enable disable marketing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'iDonatio may contact me for marketing and/or research purposes.'),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text('How we use your data'))
                              ],
                            ),
                          ),
                          Switch(
                              value: donor.sendMarketingMail,
                              onChanged: (onChanged) {})
                        ],
                      ),
                      const Divider(),
                      //end enable disable marketing
                      // basic information toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'iDonatio may share basic information about me (e.g. Name, Email) with organisations and individuals I donate to.'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'You can override this setting for each donation by selecting or deselecting the “Donate anonymously” option when making a donation. Information shared with a Donee is subject to the Donee’s Terms of Service and Privacy Policy.',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child:
                                        const Text('Learn more about GiftAid'))
                              ],
                            ),
                          ),
                          Switch(
                              value: donor.sendMarketingMail,
                              onChanged: (onChanged) {})
                        ],
                      ),
                      // end basic information toggle
                    ]),
                  ),
                  // end preferences
                  const SizedBox(
                    height: 48,
                  ),
                ],
              ));
            }),
      ),
    );
  }
}
