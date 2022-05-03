import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'referesh_token_state.dart';

class RefereshTokenCubit extends Cubit<RefereshTokenState> {
  RefereshTokenCubit() : super(RefereshTokenInitial());
}
