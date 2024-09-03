class Goal {
  int? id;
  int? userId;
  String title;
  String createdBy;
  DateTime? creationDate;
  DateTime scheduledTime;

  Goal({
    this.id,
    this.userId,
    required this.title,
    required this.createdBy,
    DateTime? creationDate,
    required this.scheduledTime,
  }) : creationDate = creationDate ?? DateTime.now();

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        createdBy: json['createdBy'],
        creationDate: DateTime.parse(json['creationDate']),
        scheduledTime: DateTime.parse(json['scheduledTime']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'createdBy': createdBy,
      'creationDate': creationDate?.toIso8601String(),
      'scheduledTime': scheduledTime?.toIso8601String(),
    };
  }

  static List<Goal> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Goal.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
