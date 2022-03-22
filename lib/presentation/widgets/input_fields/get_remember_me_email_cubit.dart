import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';

part 'get_remember_me_email_state.dart';

class GetRememberMeEmailCubit extends Cubit<GetRememberMeEmailState> {
  GetRememberMeEmailCubit(this._userLocalDataSource) : super(GetRememberMeEmailInitial());
  final UserLocalDataSource _userLocalDataSource;
  void getRememberMeEmail( )async{
      emit(GetRememberMeEmailLoading());
      try{
       final String email =  await _userLocalDataSource.getRememberMeEmail();
        emit(GetRememberMeEmailSuccessful(email));
      }catch(e){
        emit(GetRememberMeEmailFailed());
      }
  }


}


