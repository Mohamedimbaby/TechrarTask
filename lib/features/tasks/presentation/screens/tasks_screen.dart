import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techrar_task/core/network/proxy_state_provider.dart';
import 'package:techrar_task/features/auth/presentation/screens/proxy_warning_screen.dart';
import 'package:techrar_task/features/tasks/domain/entities/task_status.dart';
import 'package:techrar_task/features/tasks/presentation/providers/task_providers.dart';
import 'package:techrar_task/features/tasks/presentation/widgets/create_task_form.dart';
import 'package:techrar_task/shared/widgets/task_card.dart';

@RoutePage()
class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedStatus = ref.watch(selectedTaskStatusProvider);
    final tasksAsync = ref.watch(taskNotifierProvider);
    final proxyState = ref.watch(proxyStateProvider);

    return proxyState.when(
      data: (proxyResult) {
        if (proxyResult.isSecurityThreat) {
          return ProxyWarningScreen(detectionResult: proxyResult);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: DropdownButton<TaskStatus?>(
                  value: selectedStatus,
                  hint: const Text('Filter'),
                  items: [
                    const DropdownMenuItem<TaskStatus?>(
                      value: null,
                      child: Text('All'),
                    ),
                    ...TaskStatus.values.map(
                      (status) => DropdownMenuItem<TaskStatus>(
                        value: status,
                        child: Text(status.displayName),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    ref
                        .read(selectedTaskStatusProvider.notifier)
                        .setStatus(value);
                    ref.read(taskNotifierProvider.notifier).filterTasks(value);
                  },
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              // Check for proxy first
              await ref.read(proxyStateProvider.notifier).checkProxy();
              if (!mounted) return;

              // If no proxy detected, refresh tasks
              final currentProxyState = ref.read(proxyStateProvider);
              if (currentProxyState.value?.isSecurityThreat == false) {
                ref.invalidate(taskNotifierProvider);
              }
            },
            child: tasksAsync.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text('No tasks found'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TaskCard(
                        title: task.title,
                        assignedTo: task.assignedTo,
                        dueDate:
                            '${task.dueDate.year}-${task.dueDate.month.toString().padLeft(2, '0')}-${task.dueDate.day.toString().padLeft(2, '0')}',
                        status: task.status,
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: ()=> _showCreateTaskSheet(context)),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
void _showCreateTaskSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: const CreateTaskForm(),
      );
    },
  );
}