// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepoModelAdapter extends TypeAdapter<RepoModel> {
  @override
  final int typeId = 0;

  @override
  RepoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepoModel(
      id: fields[0] as int?,
      name: fields[1] as String,
      isFavorite: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RepoModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
