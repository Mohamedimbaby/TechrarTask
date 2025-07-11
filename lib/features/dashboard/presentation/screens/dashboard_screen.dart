import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techrar_task/core/network/proxy_state_provider.dart';
import 'package:techrar_task/features/auth/presentation/screens/proxy_warning_screen.dart';
import 'package:techrar_task/features/tasks/presentation/providers/task_providers.dart';
import 'package:techrar_task/shared/widgets/task_card.dart';
import 'package:techrar_task/shared/widgets/team_member_card.dart';

@RoutePage()
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskNotifierProvider);
    final proxyState = ref.watch(proxyStateProvider);

    return proxyState.when(
      data: (proxyResult) {
        if (proxyResult.isSecurityThreat) {
          return ProxyWarningScreen(detectionResult: proxyResult);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Project Dashboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  // TODO: Implement notifications
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              // Check for proxy first
              await ref.read(proxyStateProvider.notifier).checkProxy();
              if (!ref.context.mounted) return;

              // If no proxy detected, refresh tasks
              final currentProxyState = ref.read(proxyStateProvider);
              if (currentProxyState.value?.isSecurityThreat == false) {
                ref.invalidate(taskNotifierProvider);
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Team Members',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const TeamMemberCard(
                        name: 'John Doe',
                        role: 'Developer',
                        isOnline: true,
                        avatarUrl: 'https://i.pravatar.cc/150?img=1',
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Recent Tasks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  tasksAsync.when(
                    data: (tasks) {
                      final recentTasks = tasks.take(5).toList();
                      if (recentTasks.isEmpty) {
                        return const Center(
                          child: Text('No tasks found'),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: recentTasks.length,
                        itemBuilder: (context, index) {
                          final task = recentTasks[index];
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
                ],
              ),
            ),
          ),
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
