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

  void addProgresstoThisTask(TaskEntity listOfTask) {
    final time = DateTime.now().microsecondsSinceEpoch;
    final task = TaskEntity(
      id: listOfTask.id,
      title: listOfTask.title,
      progress: listOfTask.progress + (1 / listOfTask.totalInstallments) * 100,
      totalInstallments: listOfTask.totalInstallments,
      createdAt: listOfTask.createdAt,
      updatedAt: time,
    );

    List<TaskEntity> prev =
        List.from(state); // Create a copy to avoid mutating the original list
    int indexToUpdate = prev.indexWhere((element) => element.id == task.id);

    if (indexToUpdate != -1) {
      prev[indexToUpdate] = task; // Replace the element at the found index
      state = List.from(prev); // Update the state with the modified list
    } else {
      print('Error: Element with id ${task.id} not found in the list.');
    }
  }
}
