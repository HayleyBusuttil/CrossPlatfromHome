// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletTransactionAdapter extends TypeAdapter<WalletTransaction> {
  @override
  final int typeId = 1;

  @override
  WalletTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletTransaction(
      title: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      type: fields[3] as TxType,
      category: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WalletTransaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TxTypeAdapter extends TypeAdapter<TxType> {
  @override
  final int typeId = 0;

  @override
  TxType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TxType.expense;
      case 1:
        return TxType.income;
      default:
        return TxType.expense;
    }
  }

  @override
  void write(BinaryWriter writer, TxType obj) {
    switch (obj) {
      case TxType.expense:
        writer.writeByte(0);
        break;
      case TxType.income:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TxTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
