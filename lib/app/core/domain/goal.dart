class Goal {
  int? id;
  int? userId;
  String title;
  String createdBy;
  DateTime? creationDate;
  bool isDone;
  bool isAllDay;
  DateTime scheduledTime;

  Goal({
    this.id,
    this.userId,
    required this.title,
    required this.createdBy,
    required this.isDone,
    required this.isAllDay,
    DateTime? creationDate,
    required this.scheduledTime,
  }) : creationDate = creationDate ?? DateTime.now();

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
        id: json['id'],
        userId: json['userId'],
        isDone: json['done'],
        title: json['title'],
        isAllDay: json['allDay'],
        createdBy: json['createdBy'],
        creationDate: DateTime.parse(json['creationDate']),
        scheduledTime: DateTime.parse(json['scheduledTime']));
  }

  Goal copyWith({
    int? id,
    String? title,
    bool? isDone,
    DateTime? scheduledTime,
    String? createdBy,
    int? userId,
    bool? isAllDay
  }) {
    return Goal(
      id: id ?? this.id,
      isAllDay: isAllDay ?? this.isAllDay,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      createdBy: createdBy ?? this.createdBy,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'isDone': isDone,
      'allDay': isAllDay,
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
