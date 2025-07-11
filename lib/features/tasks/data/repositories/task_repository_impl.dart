import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:techrar_task/features/tasks/domain/entities/task.dart';
import 'package:techrar_task/features/tasks/domain/entities/task_status.dart';
import 'package:techrar_task/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final http.Client _client;
  final String _baseUrl;

  TaskRepositoryImpl({
    http.Client? client,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? 'https://jsonplaceholder.typicode.com';

  Map<String, String> get _headers => {
        'User-Agent': 'PostmanRuntime/7.29.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      };

  @override
  Future<List<Task>> getTasks({TaskStatus? status}) async {
    try {
      dev.log('Fetching tasks from $_baseUrl/todos');
      final response = await _client.get(
        Uri.parse('$_baseUrl/todos'),
        headers: _headers,
      );
      dev.log('Response status code: ${response.statusCode}');
      dev.log(
          'Response body: ${response.body.substring(0, min(100, response.body.length))}...');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final tasks = jsonList.map((json) {
          // Convert JSONPlaceholder format to our Task format
          return Task(
            id: json['id'].toString(),
            title: json['title'],
            assignedTo: 'John Doe', // Dummy data as API doesn't provide this
            dueDate: DateTime.now().add(const Duration(days: 7)), // Dummy date
            status: json['completed']
                ? TaskStatus.completed
                : TaskStatus.notCompleted,
          );
        }).toList();

        if (status != null) {
          return tasks.where((task) => task.status == status).toList();
        }

        return tasks;
      } else {
        dev.log(
            'Failed to load tasks with status code: ${response.statusCode}');
        throw Exception('Failed to load tasks');
      }
    } catch (e, stackTrace) {
      dev.log('Error loading tasks: $e\n$stackTrace');
      throw Exception('Failed to load tasks: $e');
    }
  }


  @override
  Future<Task> createTask(Task task) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/todos'),
        headers: {
          ..._headers,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': task.title,
          'completed': task.status == TaskStatus.completed,
          'userId': 1, // Required by JSONPlaceholder
        }),
      );

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return task.copyWith(id: json['id'].toString());
      } else {
        throw Exception('Failed to create task');
      }
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

}
