import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/data/models/user_models/user_data_model.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/update_profile_cubit.dart';
import 'package:idonatio/presentation/journeys/manage_account/edit_address_screen.dart';
import 'package:idonatio/presentation/journeys/manage_account/edit_email_screen.dart';
import 'package:idonatio/presentation/journeys/manage_account/edit_name_screen.dart';
import 'package:idonatio/presentation/journeys/manage_account/edit_phone_number_screen.dart';
import 'package:idonatio/presentation/journeys/user/cubit/get_authenticated_user_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../onboarding/cubit/getcountreis_cubit.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getUserState = context.watch<GetAuthenticatedUserCubit>().state;
    return Scaffold(
      appBar: AppBar(),
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
                  child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
                listener: (context, state) {
                  if (state is UpdateProfileLoading) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => const AlertDialog(
                              title: Text('Updating profile'),
                              content: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                      child: CircularProgressIndicator
                                          .adaptive())),
                            ));
                  } else if (state is UpdateProfileSuccessfull) {
                    Fluttertoast.showToast(msg: state.successMessage);
                    context
                        .read<GetAuthenticatedUserCubit>()
                        .getAuthenticatedUser();
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  '${donor?.title} ${donor?.firstName} ${donor?.lastName}'),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  AppRouter.routeToPage(
                                      const EditNameScreen()));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: AppColor.basePrimary,
                            ),
                          ),
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                AppRouter.routeToPage(
                                                    const EditPhoneNumberScreen()));
                                          },
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          AppRouter.routeToPage(
                                              const EditAddressScreen()));
                                    },
                                    icon: const Icon(Icons.place_outlined)),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: Text(
                                    '${donor?.address}',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<GetcountreisCubit>()
                                      .getCountries();
                                  Navigator.push(
                                      context,
                                      AppRouter.routeToPage(
                                          const EditAddressScreen()));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColor.basePrimary,
                                )),
                          ],
                        ),
                        const Divider(),
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                AppRouter.routeToPage(
                                                    EditEmailScreen(
                                                  initialEmail:
                                                      '${user?.email}',
                                                )));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: AppColor.basePrimary,
                                          )),
                                    ],
                                  ),
                                  Text(
                                      'Your email address is also your login ID.',
                                      style:
                                          Theme.of(context).textTheme.caption),
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
                            children: const [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.lock_outline)),
                              Text('*********'),
                            ],
                          ),
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
                                        const Text('Learn more about GiftAid'),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                                value: donor!.giftAidEnabled,
                                onChanged: (onChanged) {
                                  onChanged == false
                                      ? showDialog(
                                          context: context,
                                          builder: (builder) => AlertDialog(
                                                title: const Text(
                                                    'Disable GiftAid for this donation?'),
                                                content: const Text(
                                                  'When you disable GiftAid on an eligible donation your donee will be unable to claim an additional 25% on the value of your donation.If you are a tax paying UK resident, this is at no extra cost to you.',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              UpdateProfileCubit>()
                                                          .editGiftAidOption(
                                                              giftAidOption:
                                                                  onChanged);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                        'Ok'.toUpperCase(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Cancel'.toUpperCase(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ))
                                      : context
                                          .read<UpdateProfileCubit>()
                                          .editGiftAidOption(
                                              giftAidOption: onChanged);
                                })
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
                                onChanged: (onChanged) {
                                  context
                                      .read<UpdateProfileCubit>()
                                      .editSendMarketingEmailOption(
                                          editSendMarketingEmailOption:
                                              onChanged);
                                })
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
                                      child: const Text(
                                          'Learn more about GiftAid'))
                                ],
                              ),
                            ),
                            Switch(
                                value: donor.donateAnonymously,
                                onChanged: (onChanged) {
                                  context
                                      .read<UpdateProfileCubit>()
                                      .editAnonymousOption(
                                          anonymousOption: onChanged);
                                })
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
                ),
              ));
            }),
      ),
    );
  }
}
