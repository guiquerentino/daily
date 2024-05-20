class AccountRequest {
  int? id;
  int accountType;
  String email;
  String? password;
  String? fullName;
  String? age;
  String? phoneNumber;
  String? personalDocument;
  String? professionalDocument;
  bool? canAttend;

  AccountRequest({
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

  factory AccountRequest.fromJson(Map<String, dynamic> json) {
    return AccountRequest(
      id: json['id'],
      accountType: _getAccountTypeFromString(json['accountType']),
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

  static int _getAccountTypeFromString(String? type) {
    if (type == "PATIENT") return 0;
    if (type == "PSYCHOLOGIST") return 1;
    throw const FormatException("Invalid account type");
  }
}
