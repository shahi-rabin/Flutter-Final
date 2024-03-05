// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackagehomeHiveModelAdapter extends TypeAdapter<PackagehomeHiveModel> {
  @override
  final int typeId = 1;

  @override
  PackagehomeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackagehomeHiveModel(
      packageId: fields[0] as String?,
      packageName: fields[1] as String,
      packageDescription: fields[2] as String,
      packageTime: fields[3] as String,
      location: fields[4] as String,
      price: fields[5] as int?,
      remaining: fields[6] as int?,
      route: fields[7] as String?,
      packageCover: fields[8] as String?,
      packagePlan: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PackagehomeHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.packageId)
      ..writeByte(1)
      ..write(obj.packageName)
      ..writeByte(2)
      ..write(obj.packageDescription)
      ..writeByte(3)
      ..write(obj.packageTime)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.remaining)
      ..writeByte(7)
      ..write(obj.route)
      ..writeByte(8)
      ..write(obj.packageCover)
      ..writeByte(9)
      ..write(obj.packagePlan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackagehomeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
