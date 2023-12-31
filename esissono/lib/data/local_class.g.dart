// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalClassAdapter extends TypeAdapter<LocalClass> {
  @override
  final int typeId = 1;

  @override
  LocalClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalClass(
      nomLocal: fields[0] as String,
      typeConnexion: fields[1] as String,
      nomDevice: fields[2] as String,
      passwordDevice: fields[3] as String,
      lastConnexion: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocalClass obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nomLocal)
      ..writeByte(1)
      ..write(obj.typeConnexion)
      ..writeByte(2)
      ..write(obj.nomDevice)
      ..writeByte(3)
      ..write(obj.passwordDevice)
      ..writeByte(4)
      ..write(obj.lastConnexion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
