import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';

part 'get_remember_me_email_state.dart';

class GetRememberMeEmailCubit extends Cubit<String?> {
  GetRememberMeEmailCubit(this._userLocalDataSource) : super('');
  final UserLocalDataSource _userLocalDataSource;
  void getRememberMeEmail() async {
    try {
      final String? email = await _userLocalDataSource.getRememberMeEmail();
      emit((email));
    } catch (e) {
      emit('');
    }
  }
}
