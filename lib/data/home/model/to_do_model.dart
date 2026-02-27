import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? deadline; // 👈 جديد

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.deadline, // 👈 جديد
  });

  factory TodoModel.fromJson(Map<String, dynamic> json, String id) {
    return TodoModel(
      id: id,
      title: json['title'],
      description: json['description'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      deadline: json['deadline'] != null
          ? (json['deadline'] as Timestamp).toDate()
          : null, // 👈 جديد
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
      'deadline': deadline != null
          ? Timestamp.fromDate(deadline!)
          : null, // 👈 جديد
    };
  }
}