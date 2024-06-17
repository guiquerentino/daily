class CreateAccountRequest {
  String email;
  String password;
  String fullName;
  int accountType;

  CreateAccountRequest(
      {required this.email,
      required this.password,
      required this.fullName,
      required this.accountType
      });

  Map<String,dynamic> toJson(){
    return {
      'email':email,
      'password':password,
      'fullName':fullName,
      'accountType':accountType
    };
  }
}
