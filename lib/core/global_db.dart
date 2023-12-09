import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/services/db_services/entities/task_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

final globalDbProvider =
    StateNotifierProvider.autoDispose<GlobalDbStateNotifier, List<TaskEntity>>(
        ((ref) => GlobalDbStateNotifier(ref: ref)));

class GlobalDbStateNotifier extends StateNotifier<List<TaskEntity>> {
  final StateNotifierProviderRef ref;
  GlobalDbStateNotifier({required this.ref}) : super([]);
  void addTask(String title, int installments) {
    final time = DateTime.now().microsecondsSinceEpoch;
    final task = TaskEntity(
        id: state.length + 1,
        title: title,
        progress: 0,
        totalInstallments: installments,
        createdAt: time,
        updatedAt: time);
    List<TaskEntity> prev = state;
    prev.add(task);
    state = prev;
  }
}
