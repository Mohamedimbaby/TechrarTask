import 'package:flutter/material.dart';

enum TaskStatus {
  notCompleted,
  completed;

  String get displayName {
    switch (this) {
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.notCompleted:
        return 'Not Completed';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.notCompleted:
        return Colors.grey;
      case TaskStatus.completed:
        return Colors.green;

    }
  }
}
