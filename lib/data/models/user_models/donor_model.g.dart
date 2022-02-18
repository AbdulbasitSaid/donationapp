// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonorModelAdapter extends TypeAdapter<DonorModel> {
  @override
  final int typeId = 0;

  @override
  DonorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonorModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      firstName: fields[2] as String,
      lastName: fields[3] as String,
      isOnboarded: fields[4] as bool,
      title: fields[5] as String,
      phoneNumber: fields[6] as String?,
      phoneReceiveSecurityAlert: fields[8] as bool,
      giftAidEnabled: fields[9] as bool,
      address: fields[10] as dynamic,
      city: fields[11] as dynamic,
      countryId: fields[12] as dynamic,
      postalCode: fields[13] as dynamic,
      paymentMethod: fields[14] as dynamic,
      sendMarketingMail: fields[16] as bool,
      stripeCustomerId: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DonorModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.isOnboarded)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(8)
      ..write(obj.phoneReceiveSecurityAlert)
      ..writeByte(9)
      ..write(obj.giftAidEnabled)
      ..writeByte(10)
      ..write(obj.address)
      ..writeByte(11)
      ..write(obj.city)
      ..writeByte(12)
      ..write(obj.countryId)
      ..writeByte(13)
      ..write(obj.postalCode)
      ..writeByte(14)
      ..write(obj.paymentMethod)
      ..writeByte(15)
      ..write(obj.stripeCustomerId)
      ..writeByte(16)
      ..write(obj.sendMarketingMail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
