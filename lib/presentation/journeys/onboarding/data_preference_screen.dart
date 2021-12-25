import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboarding_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboardingdataholder_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/entities/onboarding_entity.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_error_dailog.dart';
import 'package:idonatio/presentation/widgets/labels/label_10_medium.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';

class OnboardingDataPreferencesScreen extends StatefulWidget {
  const OnboardingDataPreferencesScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingDataPreferencesScreen> createState() =>
      _OnboardingDataPreferencesScreenState();
}

class _OnboardingDataPreferencesScreenState
    extends State<OnboardingDataPreferencesScreen> {
  bool isMarketing = false;
  bool isDonateAnonymously = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AppBackgroundWidget(
          childWidget: SingleChildScrollView(
            child: BlocConsumer<OnboardingCubit, OnboardingState>(
              listener: (context, state) {
                if (state is OnboardingSuccess) {
                  context
                      .read<AuthBloc>()
                      .add(const ChangeAuth(AuthStatus.authenticated));
                  Navigator.push(
                      context, AppRouter.routeToPage(const AuthGaurd()));
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Label10Medium(text: '4/4'),
                    const SizedBox(
                      height: 8,
                    ),
                    const Level2Headline(text: 'Your data preferences'),
                    const SizedBox(
                      height: 40,
                    ),
                    const Level4Headline(
                        text: 'Additional ways in which we may use your data'),
                    const SizedBox(
                      height: 16,
                    ),
                    state is OnboardingLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Form(
                            child: Column(
                            children: [
                              state is OnboardingFailure
                                  ? AppErrorDialogWidget(
                                      title: 'Error',
                                      message: state.errorMessage)
                                  : const SizedBox.shrink(),
                              Text(
                                'We securely process and manage basic data about you to provide this service, in accordance with our Terms of Service and Privacy Policy.To provide the best possible donations experience we may also use or share your data in additional ways, including the below. Please indicate your preferences by selecting which of these you are happy with.You can manage your preferences at any time in your account area.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Checkbox(
                                          value: isMarketing,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isMarketing = value!;
                                            });
                                          }),
                                      title: Text(
                                        'iDonatio may contact me for marketing and/or research purposes.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 14,
                                              color: const Color(0xff425A70),
                                            ),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Checkbox(
                                          value: isDonateAnonymously,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isDonateAnonymously = value!;
                                            });
                                          }),
                                      title: Text(
                                        'iDonatio may share basic information about me (e.g. Name, Email) with organisations and individuals I donate to (Donees).',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 14,
                                              color: const Color(0xff425A70),
                                            ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          '(You will also be able to manage this preference on a per donation basis.)Note that information shared with Donees will be subject to their respective Terms of Service and Privacy Policies.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 12,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 42,
                              ),
                              BlocBuilder<OnboardingdataholderCubit,
                                  OnboardingdataholderState>(
                                builder: (context, state) {
                                  if (state is OnboardingdataUpdated) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<OnboardingdataholderCubit>()
                                            .updateOnboardingData(
                                                OnboardingEntity(
                                              giftAidEnabled: state
                                                  .onboardingEntity
                                                  .giftAidEnabled,
                                              address: state
                                                  .onboardingEntity.address,
                                              city: state.onboardingEntity.city,
                                              county:
                                                  state.onboardingEntity.county,
                                              countryId: state
                                                  .onboardingEntity.countryId,
                                              paymentMethod: state
                                                  .onboardingEntity
                                                  .paymentMethod,
                                              postalCode: state
                                                  .onboardingEntity.postalCode,
                                              sendMarketingMail: isMarketing,
                                              isOnboarded: true,
                                              donateAnonymously:
                                                  isDonateAnonymously,
                                            ));
                                        context
                                            .read<OnboardingCubit>()
                                            .onBoardUser(OnboardingEntity(
                                              giftAidEnabled: state
                                                  .onboardingEntity
                                                  .giftAidEnabled,
                                              address: state
                                                  .onboardingEntity.address,
                                              city: state.onboardingEntity.city,
                                              county:
                                                  state.onboardingEntity.county,
                                              countryId: state
                                                  .onboardingEntity.countryId,
                                              paymentMethod: state
                                                  .onboardingEntity
                                                  .paymentMethod,
                                              postalCode: state
                                                  .onboardingEntity.postalCode,
                                              sendMarketingMail: isMarketing,
                                              isOnboarded: true,
                                              donateAnonymously:
                                                  isDonateAnonymously,
                                            ).toJson());
                                      },
                                      child:
                                          Text('Complete setup'.toUpperCase()),
                                    );
                                  } else {
                                    return TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              AppRouter.routeToPage(
                                                  const AuthGaurd()));
                                        },
                                        child: const Text(
                                            'Please restart onboarding process'));
                                  }
                                },
                              )
                            ],
                          ))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
