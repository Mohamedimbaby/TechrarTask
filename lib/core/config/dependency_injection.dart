import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techrar_task/core/config/env_manager.dart';
import 'package:techrar_task/core/network/proxy_detector.dart';
import 'package:techrar_task/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:techrar_task/features/tasks/domain/repositories/task_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Core
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton(prefs);

  getIt.registerLazySingleton(
    () => ProxyDetector(prefs: getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton(() => http.Client(

  ));

  // Repositories
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      client: getIt<http.Client>(),
      baseUrl: EnvManager.apiBaseUrl
    ),
  );
}
