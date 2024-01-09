import 'dart:convert';

NotificationInfoModel notificationInfoModelFromJson(String str) =>
    NotificationInfoModel.fromJson(json.decode(str));

String notificationInfoModelToJson(NotificationInfoModel data) =>
    json.encode(data.toJson());

class NotificationInfoModel {
  Message message;
  Data data;
  String type;

  NotificationInfoModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory NotificationInfoModel.fromJson(Map<String, dynamic> json) =>
      NotificationInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class Data {
  List<Notification> notification;

  Data({
    required this.notification,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notification: List<Notification>.from(
            json["notification"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notification": List<dynamic>.from(notification.map((x) => x.toJson())),
      };
}

class Notification {
  int id;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  Notification({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Message {
  List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
