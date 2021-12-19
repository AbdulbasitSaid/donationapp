import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';import 'package:idonatio/data/models/local_user_object.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/journeys/onboarding/enable_gift_aid_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/label_10_medium.dart';
import 'package:idonatio/presentation/widgets/labels/level_1_headline.dart';

import '../../../enums.dart';
import 'cubit/onboarding_cubit.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key, required this.localUserObject})
      : super(key: key);
  final LocalUserObject localUserObject;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BlocListener<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingSuccess) {
              final snackBar = SnackBar(
                content: const Text('Success!'),
                action: SnackBarAction(
                  label: 'Ok',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              context
                  .read<AuthBloc>()
                  .add(const ChangeAuth(AuthStatus.verifiedEmail));
            }
          },
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context
                  .read<OnboardingCubit>()
                  .onBoardUser({'is_onboarded': true});
            },
          ),
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
                      'Welcome,${localUserObject.firstName} ${localUserObject.lastName}!',
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
                    .copyWith(color: AppColor.darkSecondaryGreen),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Get started by setting up a few preferences that’ll help you get the most out of your donation experience.',
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedNextIconButton(
                text: 'Setup Preferences',
                onPressed: () => Navigator.push(
                    context, AppRouter.routeToPage(const EnableGiftAidForm())),
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
