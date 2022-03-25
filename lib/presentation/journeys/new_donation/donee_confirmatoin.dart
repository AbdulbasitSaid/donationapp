import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_process_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_payment_methods_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/donation_details.dart';
import 'package:idonatio/presentation/journeys/new_donation/entities/donation_process_entity.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

class DoneeConfirmationScreen extends StatefulWidget {
  const DoneeConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<DoneeConfirmationScreen> createState() =>
      _DoneeConfirmationScreenState();
}

class _DoneeConfirmationScreenState extends State<DoneeConfirmationScreen> {
  bool isSaveDonee = false;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(gradient: AppColor.appBackground),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add new Donee'.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: AppColor.darkSecondaryGreen,
                            fontSize: 10,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Level2Headline(text: 'RCCG East London'),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: const [
                  DoneeCardWidget(),
                  Positioned(
                    top: -60,
                    right: 20,
                    child: DoneeAvatarPlaceHolder(),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              ListTile(
                leading: Checkbox(
                  onChanged: (value) {
                    setState(() {
                      isSaveDonee = value!;
                    });
                  },
                  value: isSaveDonee,
                ),
                title: const Text('Add to my Saved Donees list'),
                subtitle: Text(
                  'Save this donee to your list for easy access when making a future donation. You can remove a saved donee from your list at any time.',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.text70Primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                ),
              ),
              const SizedBox(
                height: 52,
              ),
              BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                builder: (context, state) {
                  if (state is GetdoneebycodeSuccess) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<DonationProcessCubit,
                            DonationProcessEntity>(
                          builder: (context, dpState) {
                            return ElevatedButton(
                              onPressed: () {
                                context
                                    .read<GetPaymentMethodsCubit>()
                                    .getPaymentMethods();
                                context
                                    .read<DonationProcessCubit>()
                                    .updateDonationProccess(dpState.copyWith(
                                      stripeConnectedAccountId: state
                                          .doneeResponseData
                                          .stripeConnectedAccountId,
                                      saveDonee: true,
                                      doneeId: state.doneeResponseData.id,
                                      currency: (state.doneeResponseData
                                                  .organization?.id ==
                                              null)
                                          ? state.doneeResponseData.country
                                              .currencyCode
                                          : state
                                              .doneeResponseData
                                              .organization!
                                              .country!
                                              .currencyCode,
                                    ));
                                Navigator.push(
                                    context,
                                    AppRouter.routeToPage(
                                        const DonationDetialsScreen()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Continue'.toUpperCase()),
                                  const Icon(Icons.arrow_right_alt_rounded)
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

///
class DoneeCardWidget extends StatelessWidget {
  const DoneeCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
      builder: (context, state) {
        if (state is GetdoneebycodeSuccess) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: [
                state.doneeResponseData.verifiedAt.isNotEmpty
                    ? ListTile(
                        iconColor: AppColor.darkSecondaryGreen,
                        leading: const Icon(Icons.verified_user),
                        title: Text(
                          'Verified',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppColor.darkSecondaryGreen,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        subtitle: Text(
                          'UK Charity No. 22345789001',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                      )
                    : const SizedBox.shrink(),
                ListTile(
                  leading: const Icon(Icons.tag),
                  iconColor: AppColor.baseText80Primary,
                  title: Text(
                    'Donee ID - ${state.doneeResponseData.doneeCode}'
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.baseText80Primary,
                        ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_pin),
                  iconColor: AppColor.baseText80Primary,
                  title: Text(
                    '${state.doneeResponseData.organization?.addressLine_1}'
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.baseText80Primary,
                        ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.web),
                  iconColor: AppColor.baseText80Primary,
                  title: Text(
                    state.doneeResponseData.organization?.website == null
                        ? "has not website".toUpperCase()
                        : '${state.doneeResponseData.organization?.website}'
                            .toLowerCase(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.baseText80Primary,
                        ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('Failed To get Donee');
        }
      },
    );
  }
}
