import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';
import 'package:idonatio/presentation/bloc/register/register_cubit.dart';
import 'package:idonatio/presentation/bloc/registration_steps/cubit/registration_steps_cubit.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/donation_history_cubit.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/donation_history_summary_cubit.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/get_donation_history_by_donee_id_cubit.dart';
import 'package:idonatio/presentation/journeys/email_verification/cubit/verification_cubit.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/change_password_cubit.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/contact_support_cubit.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/cubit/close_account_cubit.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/update_profile_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_cart_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_process_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_donation_fees_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/select_payment_method_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/create_setup_intent_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/getcountreis_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboardingdataholder_cubit.dart';
import 'package:idonatio/presentation/journeys/reset_password/bloc/resetpassword_bloc.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/delete_save_donee_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/get_saved_donees_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/recentdonees_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/save_donee_cubit.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';

import 'package:idonatio/presentation/themes/app_theme_data.dart';
import 'package:idonatio/presentation/widgets/buttons/cubit/resend_otp_cubit.dart';

import '../widgets/input_fields/get_remember_me_email_cubit.dart';
import 'auth_guard.dart';
import 'manage_account/cubit/logout_cubit.dart';
import 'new_donation/cubit/get_payment_methods_cubit.dart';
import 'new_donation/cubit/makedonation_cubit.dart';
import 'onboarding/cubit/onboarding_cubit.dart';

class IdonatioApp extends StatefulWidget {
  const IdonatioApp({Key? key}) : super(key: key);

  @override
  State<IdonatioApp> createState() => _IdonatioAppState();
}

class _IdonatioAppState extends State<IdonatioApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(getItInstance(), getItInstance()),
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
          BlocProvider<ResetpasswordBloc>(
            create: (context) =>
                ResetpasswordBloc(getItInstance(), getItInstance()),
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
              create: (context) => UserCubit(getItInstance(), getItInstance())),
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
            create: (context) => DonationHistorySummaryCubit(getItInstance()),
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
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => UserLocalDataSource(),
            ),
            RepositoryProvider(
              create: (context) =>
                  UserRepository(getItInstance(), getItInstance()),
            ),
          ],
          child: MaterialApp(
            title: 'Idonation',
            theme: AppThemeData.appTheme(),
            home: const AuthGaurd(),
          ),
        ),
      ),
    );
  }
}
