import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_remember_me_email_state.dart';

class GetRememberMeEmailCubit extends Cubit<GetRememberMeEmailState> {
  GetRememberMeEmailCubit() : super(GetRememberMeEmailInitial());
}
