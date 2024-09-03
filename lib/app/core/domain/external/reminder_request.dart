class ReminderRequest{

  int? id;
  String text;
  DateTime scheduledTime;
  bool isActivated;

  ReminderRequest({
    this.id,
    required this.text,
    required this.scheduledTime,
    required this.isActivated,
  });

  factory ReminderRequest.fromJson(Map<String, dynamic> json){
    return ReminderRequest(
      id: json['id'],
      text: json['text'],
      scheduledTime: DateTime.parse(json['scheduledTime']),
      isActivated: json['activated']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'text':text,
      'scheduledTime': scheduledTime.toIso8601String(),
      'isActivated':isActivated
    };
  }

}