// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      assignedTo: json['assignedTo'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
          TaskStatus.completed,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'assignedTo': instance.assignedTo,
      'dueDate': instance.dueDate.toIso8601String(),
      'status': _$TaskStatusEnumMap[instance.status]!,
      'description': instance.description,
    };

const _$TaskStatusEnumMap = {
  TaskStatus.notCompleted: 'notCompleted',
  TaskStatus.completed: 'completed',
};
