import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/get_saved_donees_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/save_donee_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/donee_avatar_place_holder.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

class AddNewDoneeScreen extends StatefulWidget {
  const AddNewDoneeScreen({Key? key}) : super(key: key);

  @override
  State<AddNewDoneeScreen> createState() => _AddNewDoneeScreenState();
}

class _AddNewDoneeScreenState extends State<AddNewDoneeScreen> {
  bool isSaveDonee = false;
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
                    BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                      builder: (context, state) {
                        if (state is GetdoneebycodeSuccess) {
                          return Level2Headline(
                              text: state.doneeResponseData.fullName);
                        }
                        return const Level2Headline(text: 'RCCG East London');
                      },
                    ),
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
              const SizedBox(
                height: 52,
              ),
              BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                builder: (context, getDoneeState) {
                  if (getDoneeState is GetdoneebycodeSuccess) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocConsumer<SaveDoneeCubit, SaveDoneeState>(
                          listener: (context, state) {
                            if (state is SaveDoneeSuccess) {
                              Fluttertoast.showToast(
                                  msg: state.successModel.message);

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  AppRouter.routeToPage(const HomeScreen()),
                                  (route) => false);

                              context
                                  .read<GetSavedDoneesCubit>()
                                  .getSavedDonee();
                            }
                          },
                          builder: (context, state) {
                            if (state is SaveDoneeLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () {
                                context.read<SaveDoneeCubit>().saveDonee({
                                  'donee_id': getDoneeState.doneeResponseData.id
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Save Donee'.toUpperCase()),
                                ],
                              ),
                            );
                          },
                        )
                        //
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                //
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
                        ? "has no website".toUpperCase()
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
