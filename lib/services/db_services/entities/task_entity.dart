import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/services/db_services/entities/time_base_entity.dart';

@entity
class TaskEntity extends TimeBaseEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final double progress;
  final int stage;

  TaskEntity(
      {required this.id,
      required this.title,
      required this.progress,
      required this.stage,
      required super.createdAt,
      required super.updatedAt});
}
