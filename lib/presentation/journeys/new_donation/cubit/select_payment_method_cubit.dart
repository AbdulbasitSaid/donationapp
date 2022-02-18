import 'package:bloc/bloc.dart';
import 'package:idonatio/data/models/user_models/payment_method_model.dart';

class SelectPaymentMethodCubit extends Cubit<PaymentMethodDatum?> {
  SelectPaymentMethodCubit() : super(null);
  void selectPaymentMethod(PaymentMethodDatum paymentMethod) {
    emit(paymentMethod);
  }
}
