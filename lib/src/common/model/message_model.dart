class MessageModel {
  final String? id;
  final String? userId;
  final String? usersId;
  final String? message;
  final DateTime createAt;
  final bool? edited;

  MessageModel({
    this.id = "",
    this.edited = false,
    required this.userId,
    required this.usersId,
    required this.message,
    final DateTime? createAt,
  }) : createAt = createAt ?? DateTime.now();

  MessageModel copyWith({
    String? id,
    String? userId,
    String? usersId,
    String? edited,
    String? message,
  }) =>
      MessageModel(
        id: this.id,
        edited: this.edited,
        userId: this.userId,
        usersId: this.usersId,
        message: this.message,
      );

  factory MessageModel.fromJson(Map<String, Object?> json) => MessageModel(
        id: json["id"] as String?,
        userId: json["user_id"] as String?,
        usersId: json["users_id"] as String?,
        message: json["message"] as String?,
        edited: json["edited"] as bool?,
        createAt: json["create_at"] != null
            ? DateTime.parse(json["create_at"] as String)
            : null,
      );

  Map<String, Object?> toJson() => <String, Object?>{
        "id": id,
        "user_id": userId,
        "users_id": usersId,
        "edited": edited,
        "message": message,
        "create_at": createAt.toIso8601String(),
      };

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      other is MessageModel &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      userId == other.userId &&
      message == other.message &&
      createAt == other.createAt;
}
