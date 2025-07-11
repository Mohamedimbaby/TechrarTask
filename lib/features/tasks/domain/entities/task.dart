import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techrar_task/features/tasks/domain/entities/task_status.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String assignedTo,
    required DateTime dueDate,
    @Default(TaskStatus.completed) TaskStatus status,
    String? description,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
