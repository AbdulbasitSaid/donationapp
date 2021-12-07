import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class LoginFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.email,
      FieldBlocValidators.required,
    ],
  );
  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.passwordMin6Chars,
      FieldBlocValidators.required,
    ],
  );
  final showSuccessResponse = BooleanFieldBloc();
  LoginFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
        showSuccessResponse,
      ],
    );
  }
  @override
  void onSubmitting() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (showSuccessResponse.value) {
      emitSuccess();
    } else {
      emitFailure(failureResponse: 'This is an awesome error!');
    }
  }
}
