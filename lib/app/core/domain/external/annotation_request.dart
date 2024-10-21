class AnnotationRequest {
  int? id;
  int? authorId;
  String text;
  DateTime creationDate;

  AnnotationRequest(
      {this.id,
      required this.authorId,
      required this.text,
      required this.creationDate});

  factory AnnotationRequest.fromJson(Map<String, dynamic> json){
    return AnnotationRequest(
        id: json['id'],
        authorId: json['userId'],
        text: json['text'],
        creationDate: DateTime.parse(json['createdAt']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'userId':authorId,
      'text':text,
      'createdAt': creationDate.toIso8601String(),
    };
  }

}
