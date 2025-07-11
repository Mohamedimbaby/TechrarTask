import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techrar_task/core/config/dependency_injection.dart';
import 'package:techrar_task/features/tasks/domain/entities/task.dart';
import 'package:techrar_task/features/tasks/domain/entities/task_status.dart';
import 'package:techrar_task/features/tasks/domain/repositories/task_repository.dart';

part 'task_providers.g.dart';

@riverpod
TaskRepository taskRepository(Ref ref) {
  return getIt<TaskRepository>();
}

@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  Future<List<Task>> build() async {
    return ref.watch(taskRepositoryProvider).getTasks();
  }

  Future<void> filterTasks(TaskStatus? status) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(taskRepositoryProvider).getTasks(status: status));
  }

  Future<void> createTask(Task task) async {
    await ref.read(taskRepositoryProvider).createTask(task);
    ref.invalidateSelf();
  }




}

@riverpod
class SelectedTaskStatus extends _$SelectedTaskStatus {
  @override
  TaskStatus? build() => null;

  void setStatus(TaskStatus? status) {
    state = status;
  }
}
