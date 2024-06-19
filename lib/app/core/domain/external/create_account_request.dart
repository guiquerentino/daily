class CreateAccountRequest {
  String email;
  String password;
  int accountType;

  CreateAccountRequest(
      {required this.email,
      required this.password,
      required this.accountType
      });

  Map<String,dynamic> toJson(){
    return {
      'email':email,
      'password':password,
      'accountType':accountType
    };
  }
}
