import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/donation_history_summary_cubit.dart';
import 'package:idonatio/presentation/journeys/donations_to_donee/donations_to_donee_screen.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/save_donee_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';
import 'package:idonatio/presentation/widgets/veiw_all_button_widget.dart';

import '../../../data/models/donation_models/donation_history_model.dart';
import '../../widgets/donation_summary_widget.dart';
import '../../widgets/donee_avatar_place_holder.dart';
import '../../widgets/labels/level_2_heading.dart';
import '../new_donation/cubit/get_payment_methods_cubit.dart';
import '../new_donation/cubit/getdoneebycode_cubit.dart';
import '../new_donation/donation_details.dart';

class DoneeDetailHistory extends StatefulWidget {
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
  State<DoneeDetailHistory> createState() => _DoneeDetailHistoryState();
}

class _DoneeDetailHistoryState extends State<DoneeDetailHistory> {
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
                            text: widget.donationData.donee.fullName),
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
                              Text(
                                  'UK Charity No.${widget.donationData.donee.id}'),
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
                            Text(
                                'donee id - ${widget.donationData.donee.doneeCode}'
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
                                '${widget.donationData.donee.addressLine_1} ${widget.donationData.donee.addressLine_2}'),
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
                            Text(widget.donationData.donee.organization == null
                                ? 'has no website'
                                : "${widget.donationData.donee.organization?.website}"),
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
                        doneeId: widget.donationData.doneeId,
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
                      height: 72, width: 72, child: DoneeAvatarPlaceHolder())),
              dialog
                  ? BlocListener<SaveDoneeCubit, SaveDoneeState>(
                      listener: (context, state) {
                        if (state is SaveDoneeSuccess) {
                          Fluttertoast.showToast(
                              msg: state.successModel.message);
                        }
                      },
                      child: Positioned(
                          right: 14,
                          top: 0,
                          child: Container(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: AppColor.text80Primary),
                                onPressed: () {
                                  setState(() {
                                    dialog = !dialog;
                                  });
                                  context.read<SaveDoneeCubit>().saveDonee({
                                    'donee_id': widget.donationData.donee.id
                                  });
                                },
                                child: const Text('Save donees')),
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
                          )),
                    )
                  : SizedBox.fromSize(),
              BlocConsumer<SaveDoneeCubit, SaveDoneeState>(
                listener: (context, state) {
                  if (state is SaveDoneeSuccess) {
                    Fluttertoast.showToast(msg: state.successModel.message);
                  }
                },
                builder: (context, state) {
                  if (state is SaveDoneeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox.fromSize();
                },
              )
            ],
          ),
        ),
        //todo change color
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context
                .read<GetdoneebycodeCubit>()
                .getDoneeByCode(widget.donationData.donee.doneeCode!);
            context.read<GetPaymentMethodsCubit>().getPaymentMethods();
            Navigator.push(
                context, AppRouter.routeToPage(const DonationDetialsScreen()));
          },
          label: Text('new donation'.toUpperCase()),
          icon: const Icon(
            Icons.add,
          ),
        ));
  }
}
