import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/presentation/bloc/registration_steps/cubit/registration_steps_cubit.dart';
import 'package:idonatio/presentation/widgets/input_fields/base_text_field.dart';
import 'package:idonatio/presentation/widgets/linked_span_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String titleValue = 'Mr';

  @override
  Widget build(BuildContext context) {
    return Form(
      child: BlocBuilder<RegistrationStepsCubit, RegistrationStepsState>(
        builder: (context, state) {
          switch (state.stage) {
            case 1:
              return registrationStepOne(context);
            case 2:
              return registrationStepTwo(context);
            default:
              return registrationStepOne(context);
          }
        },
      ),
    );
  }

  Column registrationStepOne(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('1/2'),
        Text(
          TranslationConstants.whatShouldWeCallYou,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text('Title'),
        Row(
          children: [
            Flexible(
              child: DropdownButtonFormField(
                value: titleValue,
                isExpanded: false,
                isDense: true,
                onChanged: (String? newTitle) {
                  setState(() {
                    titleValue = newTitle!;
                  });
                },
                items: <String>['Mr', 'Mrs', 'Alhaji', 'Doctor']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const BaseTextField(
          hintText: 'First Name',
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Last Name',
            labelText: 'Last Name',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        AspectRatio(
          aspectRatio: 3 / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<RegistrationStepsCubit>(context)
                        .nextStage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Next'.toUpperCase(),
                      ),
                      const Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column registrationStepTwo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('2/2'),
        Text(
          TranslationConstants.yourConactAndLoginDetails,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 16,
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: TranslationConstants.mobileOptional,
            labelText: TranslationConstants.mobileOptional,
            prefixIcon: Icon(Icons.phone_outlined),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: TranslationConstants.emailAddress,
            labelText: TranslationConstants.emailAddress,
            prefixIcon: Icon(Icons.mail_outline),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: TranslationConstants.password,
            labelText: TranslationConstants.password,
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: Icon(Icons.remove_red_eye_sharp),
          ),
        ),
        Row(
          children: [
            Checkbox(value: true, onChanged: (fasle) {}),
            Flexible(
              child: RichText(
                text: TextSpan(
                  text: TranslationConstants.iHaveReadAndUnderstood,
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    linkedSpanButton(
                        onTap: () {},
                        text: TranslationConstants.termsOfService),
                    TextSpan(
                      text: TranslationConstants.and,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    linkedSpanButton(
                        onTap: () {}, text: TranslationConstants.privacyPolicy),
                  ],
                ),
              ),
            )
          ],
        ),
        AspectRatio(
          aspectRatio: 3 / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteList.verifyEmail),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Register'.toUpperCase(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
