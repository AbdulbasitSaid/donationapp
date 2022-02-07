import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/presentation/journeys/new_donation/entities/donation_item_entity.dart';

part 'donation_cart_state.dart';

class DonationCartCubit extends Cubit<List<DonationItemEntity>> {
  DonationCartCubit() : super([]);
  void addToCart(DonationItemEntity donationItemEntity) async {
    List<DonationItemEntity> newList = [];
    if (state.contains(donationItemEntity)) {
      state.remove(donationItemEntity);
      newList.addAll(state);
      emit(newList);
    } else {
      state.add(donationItemEntity);
      newList.addAll(state);
      emit(newList);
    }
    log(state.toString());
  }

  void emptyCart() {
    List<DonationItemEntity> newList = [];
    emit(newList);
  }

  void editAmount(DonationItemEntity donationItemEntity) {
    List<DonationItemEntity> newList = [];
    state.firstWhere((element) => element == donationItemEntity).amount =
        donationItemEntity.amount;
    newList.addAll(state);
    emit(newList);
    log(state.toString());
  }
}
