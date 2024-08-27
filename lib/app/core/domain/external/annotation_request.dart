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
        authorId: json['authorId'],
        text: json['text'],
        creationDate: DateTime.parse(json['creationDate']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'authorId':authorId,
      'text':text,
      'creationDate': creationDate.toIso8601String(),
    };
  }

}
