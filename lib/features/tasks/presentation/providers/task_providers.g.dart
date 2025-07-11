// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskRepositoryHash() => r'bc6f386194bbcef8090cfb23b170b53cc579878d';

/// See also [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = AutoDisposeProvider<TaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskRepositoryRef = AutoDisposeProviderRef<TaskRepository>;
String _$taskNotifierHash() => r'97576382d56334ddc7f160a6bbebb28e768c8f1a';

/// See also [TaskNotifier].
@ProviderFor(TaskNotifier)
final taskNotifierProvider =
    AutoDisposeAsyncNotifierProvider<TaskNotifier, List<Task>>.internal(
  TaskNotifier.new,
  name: r'taskNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskNotifier = AutoDisposeAsyncNotifier<List<Task>>;
String _$selectedTaskStatusHash() =>
    r'2169665b54f1cf1aa05388b3a1ef72d2c8419d5f';

/// See also [SelectedTaskStatus].
@ProviderFor(SelectedTaskStatus)
final selectedTaskStatusProvider =
    AutoDisposeNotifierProvider<SelectedTaskStatus, TaskStatus?>.internal(
  SelectedTaskStatus.new,
  name: r'selectedTaskStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedTaskStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedTaskStatus = AutoDisposeNotifier<TaskStatus?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
