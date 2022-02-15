import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/contact_support_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/presentation/reusables.dart';

part 'contact_support_state.dart';

class ContactSupportCubit extends Cubit<ContactSupportState> {
  final ContactSupportRepository contactSupportRepository;
  ContactSupportCubit(this.contactSupportRepository)
      : super(ContactSupportInitial());
  void contactSupport(String message) async {
    emit(ContactSupportLoading());
    final result =
        await contactSupportRepository.contactSupport({'message': message});
    emit(result.fold(
        (l) => ContactSupportFailed(
            getErrorMessage(l.appErrorType), l.appErrorType),
        (r) => const ContactSupportSuccessful('message sent')));
  }
}
