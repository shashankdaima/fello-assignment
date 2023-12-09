import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/services/db_services/entities/time_base_entity.dart';

@entity
class TaskEntity extends TimeBaseEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final double progress;
  final int totalInstallments;
  TaskEntity(
      {required this.id,
      required this.title,
      required this.progress,
      required this.totalInstallments,
      required super.createdAt,
      required super.updatedAt});
}
