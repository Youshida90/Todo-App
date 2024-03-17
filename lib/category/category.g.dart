// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Category1Adapter extends TypeAdapter<Category1> {
  @override
  final int typeId = 2;

  @override
  Category1 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category1(
      name: fields[0] as String,
      icon: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Category1 obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category1Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
