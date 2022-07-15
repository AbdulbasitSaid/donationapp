import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'referesh_token_state.dart';

class RefereshTokenCubit extends Cubit<RefereshTokenState> {
  RefereshTokenCubit() : super(RefereshTokenInitial());
}
