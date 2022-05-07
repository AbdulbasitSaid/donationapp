import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:idonatio/di/get_it.dart' as get_it;
import 'package:idonatio/presentation/bloc/simple_bloc_observer.dart';

import 'common/hive_initiator.dart';
import 'di/get_it.dart';
import 'presentation/bloc/app_session_manager_bloc.dart';
import 'presentation/bloc/loader_cubit/loading_cubit.dart';
import 'presentation/bloc/login/login_cubit.dart';
import 'presentation/bloc/referesh_timer_bloc.dart';
import 'presentation/bloc/register/register_cubit.dart';
import 'presentation/bloc/registration_steps/cubit/registration_steps_cubit.dart';
import 'presentation/journeys/donation_history/cubit/donation_history_cubit.dart';
import 'presentation/journeys/donation_history/cubit/donation_history_summary_cubit.dart';
import 'presentation/journeys/donation_history/cubit/get_donation_history_by_donee_id_cubit.dart';
import 'presentation/journeys/email_verification/cubit/verification_cubit.dart';
import 'presentation/journeys/i_donation_app.dart';
import 'presentation/journeys/manage_account/cubit/change_password_cubit.dart';
import 'presentation/journeys/manage_account/cubit/contact_support_cubit.dart';
import 'presentation/journeys/manage_account/cubit/cubit/close_account_cubit.dart';
import 'presentation/journeys/manage_account/cubit/logout_cubit.dart';
import 'presentation/journeys/manage_account/cubit/update_profile_cubit.dart';
import 'presentation/journeys/new_donation/cubit/donation_cart_cubit.dart';
import 'presentation/journeys/new_donation/cubit/donation_process_cubit.dart';
import 'presentation/journeys/new_donation/cubit/get_donation_fees_cubit.dart';
import 'presentation/journeys/new_donation/cubit/get_payment_methods_cubit.dart';
import 'presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'presentation/journeys/new_donation/cubit/makedonation_cubit.dart';
import 'presentation/journeys/new_donation/cubit/select_payment_method_cubit.dart';
import 'presentation/journeys/onboarding/cubit/create_setup_intent_cubit.dart';
import 'presentation/journeys/onboarding/cubit/getcountreis_cubit.dart';
import 'presentation/journeys/onboarding/cubit/onboarding_cubit.dart';
import 'presentation/journeys/onboarding/cubit/onboardingdataholder_cubit.dart';
import 'presentation/journeys/reset_password/cubit/resend_otp_forgot_password_cubit.dart';
import 'presentation/journeys/reset_password/cubit/reset_password_cubit.dart';
import 'presentation/journeys/reset_password/cubit/send_otp_forgot_password_cubit.dart';
import 'presentation/journeys/reset_password/cubit/validate_otp_forgot_password_cubit.dart';
import 'presentation/journeys/saved_donees/cubit/delete_save_donee_cubit.dart';
import 'presentation/journeys/saved_donees/cubit/get_saved_donees_cubit.dart';
import 'presentation/journeys/saved_donees/cubit/recentdonees_cubit.dart';
import 'presentation/journeys/saved_donees/cubit/save_donee_cubit.dart';
import 'presentation/journeys/user/cubit/get_authenticated_user_cubit.dart';
import 'presentation/journeys/user/cubit/user_cubit.dart';
import 'presentation/widgets/buttons/cubit/resend_otp_cubit.dart';
import 'presentation/widgets/input_fields/get_remember_me_email_cubit.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51HSkkpGqiuzQS1fhELMeWYfVhxf2olIBOiUabSjrML7zaqCwxBpjuiv63MUU1XDE45HkWa9l7M1bCQyuaRzbmF2V00RqyUZAyG";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';

  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(get_it.init());

  BlocOverrides.runZoned(
    () async {
      await HiveInitiator.initialize();
      runApp(
        Listener(
          onPointerDown: (event) {
            // log('Awww!! you touched me!');
          },
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LoginCubit>(
                create: (context) =>
                    LoginCubit(getItInstance(), getItInstance()),
              ),
              BlocProvider<RegisterCubit>(
                create: (context) => RegisterCubit(
                  getItInstance(),
                  getItInstance(),
                ),
              ),
              BlocProvider<LoadingCubit>(
                create: (context) => LoadingCubit(),
              ),
              BlocProvider<VerificationCubit>(
                create: (context) => VerificationCubit(getItInstance()),
              ),
              BlocProvider<OnboardingCubit>(
                create: (context) => OnboardingCubit(getItInstance()),
              ),
              BlocProvider<RegistrationStepsCubit>(
                create: (context) => RegistrationStepsCubit(),
              ),
              BlocProvider<OnboardingdataholderCubit>(
                  create: (context) => OnboardingdataholderCubit()),
              BlocProvider<GetcountreisCubit>(
                  create: (context) => GetcountreisCubit(getItInstance())),
              BlocProvider(
                create: (context) => LogoutCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => GetPaymentMethodsCubit(getItInstance()),
              ),
              BlocProvider(
                  create: (context) => CreateSetupIntentCubit(getItInstance())),
              BlocProvider(
                  create: (context) => UserCubit(
                        getItInstance(),
                      )),
              BlocProvider(
                create: (context) => MakedonationCubit(
                  getItInstance(),
                ),
              ),
              BlocProvider(
                create: (context) => GetdoneebycodeCubit(
                  doneeRepository: getItInstance(),
                ),
              ),
              BlocProvider(
                create: (context) => DonationProcessCubit(),
              ),
              BlocProvider(
                create: (context) => DonationCartCubit(),
              ),
              BlocProvider(
                create: (context) => SelectPaymentMethodCubit(),
              ),
              BlocProvider(
                create: (context) => GetRecentdoneesCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => GetSavedDoneesCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => UpdateProfileCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => ChangePasswordCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => ContactSupportCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => CloseAccountCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => DonationHistoryCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => DonationHistoryCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => DeleteSaveDoneeCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => SaveDoneeCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) =>
                    DonationHistorySummaryCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) =>
                    GetDonationHistoryByDoneeIdCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => ResendOtpCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => GetRememberMeEmailCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => GetDonationFeesCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) =>
                    SendOtpForgotPasswordCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) =>
                    ResendOtpForgotPasswordCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) =>
                    ValidateOtpForgotPasswordCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => ResetPasswordCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => GetAuthenticatedUserCubit(getItInstance()),
              ),
              BlocProvider(
                create: (context) => AppSessionManagerBloc(getItInstance()),
              ),
              BlocProvider(
                create: (context) => RefereshTimerBloc(
                    localDataSource: getItInstance(),
                    refereshTicker: getItInstance(),
                    userRemoteDataSource: getItInstance()),
              ),
            ],
            child: const IdonatioApp(),
          ),
        ),
      );
    },
    blocObserver: SimpleBlocObserver(),
  );
}
