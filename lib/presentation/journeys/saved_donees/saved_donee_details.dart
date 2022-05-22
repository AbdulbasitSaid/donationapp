import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/delete_save_donee_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/get_saved_donees_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/recentdonees_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/donation_summary_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';
import 'package:idonatio/presentation/widgets/veiw_all_button_widget.dart';

import '../../../data/models/donation_models/donee_model.dart';
import '../../widgets/buttons/logout_button_widget.dart';
import '../../widgets/donee_avatar_place_holder.dart';
import '../../widgets/labels/level_2_heading.dart';
import '../../widgets/loaders/primary_app_loader_widget.dart';
import '../new_donation/cubit/get_payment_methods_cubit.dart';
import '../new_donation/cubit/getdoneebycode_cubit.dart';
import '../new_donation/donation_details.dart';
import '../user/cubit/user_cubit.dart';

class SavedDoneeDetails extends StatefulWidget {
  const SavedDoneeDetails({Key? key, required this.donationData})
      : super(key: key);
  static Route<String> route({required Donee donationData}) {
    return MaterialPageRoute(
        builder: (_) => SavedDoneeDetails(
              donationData: donationData,
            ));
  }

  final Donee donationData;

  @override
  State<SavedDoneeDetails> createState() => _SavedDoneeDetailsState();
}

class _SavedDoneeDetailsState extends State<SavedDoneeDetails> {
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
                icon: const Icon(FeatherIcons.moreVertical))
          ],
        ),
        body: BlocListener<DeleteSaveDoneeCubit, DeleteSaveDoneeState>(
          listener: (context, state) {
            if (state is DeleteSaveDoneeSuccess) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: 'Deleted successfully');
              context.read<GetSavedDoneesCubit>().getSavedDonee();
              context.read<GetRecentdoneesCubit>().getRecentDonees();
            } else if (state is DeleteSaveDoneeFailed) {
              Fluttertoast.showToast(msg: state.errorMessage);
            }
          },
          child: Container(
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
                              text: widget.donationData.organization == null
                                  ? '${widget.donationData.firstName} ${widget.donationData.firstName}'
                                  : '${widget.donationData.organization?.name}'),
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
                          Flexible(
                            child: Column(
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
                                widget.donationData.organization
                                            ?.registrationNumber ==
                                        null
                                    ? const SizedBox.shrink()
                                    : Text(
                                        'UK Charity No.${widget.donationData.organization?.registrationNumber}'),
                              ],
                            ),
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
                              Text('donee id - ${widget.donationData.doneeCode}'
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
                                  '${widget.donationData.addressLine_1} ${widget.donationData.addressLine_2}'),
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
                              Text(widget.donationData.organization == null
                                  ? 'has no website'
                                  : "${widget.donationData.organization?.website}"),
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
                        ViewAllButtonWidget(
                          doneeId: widget.donationData.id!,
                        )
                      ],
                    ),
                  ),
                  const DonationSummaryWidget()
                ]),
                const Positioned(
                    right: 16,
                    top: 50,
                    child: SizedBox(
                        height: 72,
                        width: 72,
                        child: DoneeAvatarPlaceHolder())),
                dialog == false
                    ? const SizedBox.shrink()
                    : Positioned(
                        right: 14,
                        top: 0,
                        child: Container(
                          decoration:
                              whiteContainerBackGround().copyWith(boxShadow: [
                            const BoxShadow(
                                color: Color(0x0ff42a70),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                                spreadRadius: -2),
                            const BoxShadow(
                                color: Color(0x0ff42a70),
                                offset: Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: 0),
                          ]),
                          padding: const EdgeInsets.all(16),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  primary: AppColor.text80Primary),
                              onPressed: () {
                                setState(() {
                                  dialog = !dialog;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text('Delete donee?'),
                                          content: BlocBuilder<
                                              DeleteSaveDoneeCubit,
                                              DeleteSaveDoneeState>(
                                            builder: (context, state) {
                                              if (state
                                                  is DeleteSaveDoneeLoading) {
                                                return const Center(
                                                  child: PrimaryAppLoader(),
                                                );
                                              }
                                              return const Text(
                                                  'You will need to add this donee again to make a donation to them in the future.This action will not delete donations you have made to the donee in the past.');
                                            },
                                          ),
                                          actions: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .button!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                onPressed: () {
                                                  Navigator.pop(context);

                                                  context
                                                      .read<
                                                          DeleteSaveDoneeCubit>()
                                                      .deleteSavedDonee(widget
                                                          .donationData.id!);
                                                },
                                                child: Text(
                                                  'delete'.toUpperCase(),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .button!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                child: Text(
                                                    'cancel'.toUpperCase())),
                                          ],
                                        ));
                              },
                              child: const Text('Delete donee')),
                        )),
                BlocBuilder<DeleteSaveDoneeCubit, DeleteSaveDoneeState>(
                  builder: (context, state) {
                    if (state is DeleteSaveDoneeLoading) {
                      return const Center(
                        child: PrimaryAppLoader(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
        //todo change color
        floatingActionButton: Builder(builder: (context) {
          final userState = context.watch<UserCubit>().state;
          return FloatingActionButton.extended(
            onPressed: () {
              context
                  .read<GetdoneebycodeCubit>()
                  .getDoneeByCode(widget.donationData.doneeCode!);
              context.read<GetPaymentMethodsCubit>().getPaymentMethods();
              Navigator.push(
                  context,
                  AppRouter.routeToPage(DonationDetialsScreen(
                    isDonateAnonymously: userState is Authenticated
                        ? userState.userData.user.donor.donateAnonymously
                        : false,
                    isEnableGiftAid: userState is Authenticated
                        ? userState.userData.user.donor.giftAidEnabled
                        : false,
                  )));
            },
            label: Text('new donation'.toUpperCase()),
            icon: const Icon(
              Icons.add,
            ),
          );
        }));
  }
}
