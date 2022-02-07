import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/data/core/validator.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/domain/entities/register_request_params.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/register/register_cubit.dart';
import 'package:idonatio/presentation/bloc/registration_steps/cubit/registration_steps_cubit.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
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
  late TextEditingController _firsNametTextController,
      _lastNameTextController,
      _mobileNumberTextController,
      _emailTextController,
      _passwordEditingController;

  bool hidePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _checkboxValue = false;

  @override
  void initState() {
    super.initState();

    _firsNametTextController = TextEditingController();
    _lastNameTextController = TextEditingController();
    _mobileNumberTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _firsNametTextController.dispose();
    _lastNameTextController.dispose();
    _mobileNumberTextController.dispose();
    _emailTextController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
        TextFormField(
          controller: _firsNametTextController,
          onChanged: (value) {
            Validator.validateField(formKey: _formKey);
          },
          validator: MultiValidator([
            RequiredValidator(errorText: 'First Name is required'),
            MinLengthValidator(3, errorText: 'Lenght should be greater than 3')
          ]),
          decoration: const InputDecoration(
            hintText: 'First Name',
            labelText: 'First Name',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          onChanged: (value) {
            Validator.validateField(formKey: _formKey);
          },
          controller: _lastNameTextController,
          validator: MultiValidator([
            RequiredValidator(errorText: 'Last Name is required'),
            MinLengthValidator(3, errorText: 'Lenght should be greater than 3')
          ]),
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
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<RegistrationStepsCubit>(context)
                          .nextStage();
                    }
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
          controller: _mobileNumberTextController,
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
          controller: _emailTextController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => Validator.validateField(formKey: _formKey),
          validator: MultiValidator([
            RequiredValidator(errorText: 'Email is required'),
            EmailValidator(errorText: 'Please provide a valide email.')
          ]),
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
          controller: _passwordEditingController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: hidePassword,
          onChanged: (value) => Validator.validateField(formKey: _formKey),
          validator: MultiValidator([
            RequiredValidator(errorText: 'Password is required'),
            MinLengthValidator(8,
                errorText: 'Password should be a mininum of 8 characters')
          ]),
          decoration: InputDecoration(
            hintText: TranslationConstants.password,
            labelText: TranslationConstants.password,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: const Icon(Icons.remove_red_eye_sharp),
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        FormField<bool>(
          builder: (state) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Checkbox(
                        value: _checkboxValue,
                        onChanged: (value) {
                          setState(() {
                            _checkboxValue = value!;
                            state.didChange(value);
                          });
                        }),
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
                                onTap: () {},
                                text: TranslationConstants.privacyPolicy),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  state.errorText ?? '',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                )
              ],
            );
          },
          validator: (value) {
            if (!_checkboxValue) {
              return 'You need to accept Terms of Service';
            } else {
              return null;
            }
          },
        ),
        AspectRatio(
          aspectRatio: 3 / 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      context.read<UserCubit>().setUserState(
                          getItInstance(), AuthStatus.authenticated);
                      Navigator.push(
                          context, AppRouter.routeToPage(const AuthGaurd()));
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegisterCubit>().initiateRegistration(
                                RegisterUserRequestParameter(
                                        title: titleValue,
                                        firstName:
                                            _firsNametTextController.text,
                                        lastName: _lastNameTextController.text,
                                        email: _emailTextController.text,
                                        password:
                                            _passwordEditingController.text,
                                        phoneNumber:
                                            _mobileNumberTextController.text,
                                        platform: 'mobile',
                                        deviceUid: '272892-08287-398903903',
                                        os: 'ios',
                                        osVersion: '10',
                                        model: 'samsung s21',
                                        ipAddress: '198.0.2.3',
                                        screenResolution: '1080p')
                                    .toJson());
                            context.read<UserCubit>().setUserState(
                                getItInstance(), AuthStatus.authenticated);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Register'.toUpperCase(),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
