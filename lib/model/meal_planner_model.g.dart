// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_planner_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealPlannerModelAdapter extends TypeAdapter<MealPlannerModel> {
  @override
  final int typeId = 2;

  @override
  MealPlannerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealPlannerModel(
      day: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MealPlannerModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealPlannerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
