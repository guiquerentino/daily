class CreateAccountRequest {
  BigInt? id;
  int accountType;
  String email;
  String password;
  String? fullName;
  String? age;
  String? phoneNumber;
  String? personalDocument;
  String? professionalDocument;
  bool? canAttend;

  CreateAccountRequest({
    this.id,
    required this.accountType,
    required this.email,
    required this.password,
    this.fullName,
    this.age,
    this.phoneNumber,
    this.personalDocument,
    this.professionalDocument,
    this.canAttend,
  });

  factory CreateAccountRequest.fromJson(Map<String, dynamic> json) {
    return CreateAccountRequest(
      id: json['id'] == null ? null : BigInt.parse(json['id']),
      accountType: json['accountType'],
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      age: json['age'],
      phoneNumber: json['phoneNumber'],
      personalDocument: json['personalDocument'],
      professionalDocument: json['professionalDocument'],
      canAttend: json['canAttend'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id?.toString(),
      'accountType': accountType.toString().split('.').last,
      'email': email,
      'password': password,
      'fullName': fullName,
      'age': age,
      'phoneNumber': phoneNumber,
      'personalDocument': personalDocument,
      'professionalDocument': professionalDocument,
      'canAttend': canAttend,
    };
  }
}