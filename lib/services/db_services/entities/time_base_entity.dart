import 'package:floor/floor.dart';

class TimeBaseEntity {
  @ColumnInfo(name: 'created_at')
  final int createdAt;

  @ColumnInfo(name: 'updated_at')
  final int updatedAt;

  TimeBaseEntity({required this.createdAt, required this.updatedAt});
}
