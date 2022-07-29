import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/models/user_models/user_data_model.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/onboarding/gift_aid_screen.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/label_10_medium.dart';
import 'package:idonatio/presentation/widgets/labels/level_1_headline.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key, required this.localUserObject})
      : super(key: key);
  final UserData localUserObject;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (buider) => AlertDialog(
                title: const Text('Exit setup?'),
                content: const Text(
                    'We recommend that you setup your preferences before using the app to help you get started donating quickly.If you exit now, you will still need to setup your options later.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Continue setup'.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  TextButton(
                      onPressed: () {
                        context.read<UserCubit>().setUserState(
                            getItInstance(), AuthStatus.unauthenticated);
                        Navigator.pushAndRemoveUntil(
                            context,
                            AppRouter.routeToPage(const AuthGaurd()),
                            (route) => false);
                      },
                      child: Text(
                        'Exit'.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: AppBackgroundWidget(
          childWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Label10Medium(
                text: 'Get Started'.toUpperCase(),
              ),
              const SizedBox(
                height: 16,
              ),
              Flexible(
                child: Level1Headline(
                  text:
                      'Welcome, ${localUserObject.user.donor!.firstName} ${localUserObject.user.donor!.lastName}!',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'You are one step closer to giving effortlessly to the people and organisations you care about.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AppColor.darkSecondaryGreen, fontSize: 18),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Get started by setting up a few preferences that’ll help you get the most out of your donation experience.',
              ),
              const SizedBox(
                height: 64,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedNextIconButton(
                    text: 'Setup Preferences'.toUpperCase(),
                    onPressed: () => Navigator.push(
                        context, AppRouter.routeToPage(const GiftAidScreen())),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '(You can manage your preferences at any time in your account area.)',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedNextIconButton extends StatelessWidget {
  const ElevatedNextIconButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(
              width: 8,
            ),
            const Icon(Icons.arrow_forward)
          ],
        ));
  }
}
