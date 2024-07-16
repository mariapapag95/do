import 'dart:convert';

class Task {
  final int id;
  final String label;
  final String? details;
  final DateTime? date;
  final DateTime? time;
  final DateTime createdOn;

  const Task({
    required this.id,
    required this.label,
    this.details,
    this.date,
    this.time,
    required this.createdOn,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json['id'],
        label: json['label'],
        details: json['details'],
        date: json['date'] != null ? DateTime.parse(json['date']) : null,
        time: json['time'] != null ? DateTime.parse(json['time']) : null,
        createdOn: DateTime.parse(json['createdOn']),
      );

  Map<String, dynamic> toMap() => {
        'label': label,
        'details': details,
        'date': date?.toIso8601String(),
        'time': time?.toIso8601String(),
        'createdOn': createdOn.toIso8601String(),
      };

  Task taskFromJson(String str) {
    final jsonData = json.decode(str);
    return Task.fromMap(jsonData);
  }

  String taskToJson(Task data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }
}
