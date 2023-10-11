class MessageModel {
  final String id;
  final String userId;
  final String message;
  final DateTime createAt;

  MessageModel(
      { this.id="",
      required this.userId,
      required this.message,
      final DateTime? createAt})
      : createAt = createAt ?? DateTime.now();

  MessageModel copyWith({
    String? id,
    String? userId,
    String? message,
  }) =>
      MessageModel(
        id: this.id,
        userId: this.userId,
        message: this.message,
      );




  factory MessageModel.fromJson(Map<String, Object?> json) => MessageModel(
        id: json["id"] as String,
        userId: json["userId"] as String,
        message: json["message"] as String,
      );

  Map<String, Object?> toJson() => <String, Object?>{
        "id": id,
        "userId": userId,
        "message": message,
      };


  @override
  int get hashCode => id.hashCode;

  bool operator ==(Object other) =>
      other is MessageModel &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      userId == other.userId &&
      message == other.message &&
      createAt == other.createAt;
}
