import 'package:day59/models/user/UserModel.dart';

class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String body;
  final UserModel user;
  final bool isRead;
  final DateTime time;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.user,
    required this.isRead,
    required this.time,
  });

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? "",
      title: json['title'] ?? 'No title',
      body: json['body'] ?? 'No body',
      user: UserModel.fromMap(json['user'] ?? {}),
      isRead: json['isRead'] ?? false,
      time:
          json['time'] != null ? DateTime.parse(json['time']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'user': user.toMap(),
      'isRead': isRead,
      'time': time.toIso8601String(),
    };
  }

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    UserModel? user,
    bool? isRead,
    DateTime? time,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      user: user ?? this.user,
      isRead: isRead ?? this.isRead,
      time: time ?? this.time,
    );
  }
}
