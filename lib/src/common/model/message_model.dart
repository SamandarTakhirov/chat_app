class ChatModel {
  final String id;
  final int userOne;
  final int userTwo;
  final String message;
  // final List<String> messages;
  final DateTime createdAt;

  ChatModel({
    this.id = "",
    this.userOne = 1,
    this.userTwo = 2,
    // required this.messages,
    required this.message,
    final DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  ChatModel copyWith({
    String? id,
    int? userOne,
    int? userTwo,
    String? message,
    List<Map<int, String>>? messages,
  }) =>
      ChatModel(
        id: this.id,
        userOne: this.userOne,
        message: this.message,
        // messages: this.messages,
        userTwo: this.userTwo,
        createdAt: createdAt,
      );

  factory ChatModel.fromJson(Map<String, Object?> json) => ChatModel(
        id: json["id"] as String,
        // messages: json["messages"] as List<String>,
        message: json["message"] as String,
      );

  Map<String, Object?> toJson() => <String, Object?>{
        "id": id,
        "message": message,
        // "messages": messages,
      };

  @override
  int get hashCode => id.hashCode;

  bool operator ==(Object other) =>
      other is ChatModel &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      message == other.message ;
      // messages == other.messages;
}
