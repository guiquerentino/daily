class Account {
  int? id;
  int accountType;
  String email;
  String? password;
  String fullName;

  Account({
    this.id,
    required this.accountType,
    required this.email,
    required this.password,
    required this.fullName,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      accountType: _getAccountTypeFromString(json['accountType']),
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id?.toString(),
      'accountType': accountType.toString().split('.').last,
      'email': email,
      'password': password,
      'fullName': fullName,
    };
  }

  static int _getAccountTypeFromString(String? type) {
    if (type == "PATIENT") return 0;
    if (type == "PSYCHOLOGIST") return 1;
    throw const FormatException("Invalid account type");
  }
}
