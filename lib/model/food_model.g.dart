// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodAdapter extends TypeAdapter<Food> {
  @override
  final int typeId = 1;

  @override
  Food read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Food(
      foodImagePath: fields[0] as String?,
      title: fields[1] as String,
      cookTime: fields[2] as String,
      type: fields[3] as String,
      category: fields[4] as String,
      difficulty: fields[5] as String,
      ingredients: (fields[6] as List).cast<String>(),
      preparation: fields[7] as String,
      calories: fields[8] as String,
      protein: fields[9] as String,
      carbohydrates: fields[10] as String,
      fats: fields[11] as String,
      isCollected: fields[13] as bool,
      isAddedtoPlan: fields[14] as bool,
      id: fields[12] as int?,
    )..addedtoList = fields[15] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Food obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.foodImagePath)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.cookTime)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.difficulty)
      ..writeByte(6)
      ..write(obj.ingredients)
      ..writeByte(7)
      ..write(obj.preparation)
      ..writeByte(8)
      ..write(obj.calories)
      ..writeByte(9)
      ..write(obj.protein)
      ..writeByte(10)
      ..write(obj.carbohydrates)
      ..writeByte(11)
      ..write(obj.fats)
      ..writeByte(12)
      ..write(obj.id)
      ..writeByte(13)
      ..write(obj.isCollected)
      ..writeByte(14)
      ..write(obj.isAddedtoPlan)
      ..writeByte(15)
      ..write(obj.addedtoList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
