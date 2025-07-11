import 'package:techrar_task/features/tasks/domain/entities/task.dart';
import 'package:techrar_task/features/tasks/domain/entities/task_status.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks({TaskStatus? status});
  Future<Task> createTask(Task task);
}
