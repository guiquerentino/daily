class Account {
  int? id;
  int accountType;
  String email;
  String? password;
  String? fullName;
  List<int>? profilePhoto;
  int? gender;
  int? age;
  List<int>? targets;
  bool? hasOnboarding;
  int? meditationExperience;
  String? codeToConnect;

  Account({
    this.id,
    required this.accountType,
    required this.email,
    this.password,
    this.fullName,
    this.profilePhoto,
    this.gender,
    this.age,
    this.targets,
    this.hasOnboarding,
    this.meditationExperience,
    this.codeToConnect,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      accountType: _getAccountTypeFromString(json['accountType']),
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      profilePhoto: json['profilePhoto'] != null ? List<int>.from(json['profilePhoto']) : null,
      gender: _getGenderFromString(json['gender']),
      age: json['age'],
      targets: json['targets'] != null ? List<int>.from(json['targets']) : null,
      hasOnboarding: json['hasOnboarding'],
      meditationExperience: _getMeditationExperienceFromString(json['meditationExperience']),
      codeToConnect: json['codeToConnect'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id?.toString(),
      'accountType': accountType.toString().split('.').last,
      'email': email,
      'password': password,
      'fullName': fullName,
      'profilePhoto': profilePhoto,
      'gender': gender.toString().split('.').last,
      'age': age,
      'targets': targets?.map((e) => e.toString().split('.').last).toList(), // Modificado para List<int>?
      'hasOnboarding': hasOnboarding,
      'meditationExperience': meditationExperience.toString().split('.').last,
      'codeToConnect': codeToConnect,
    };
  }

  static int _getAccountTypeFromString(String? type) {
    switch (type) {
      case "PATIENT":
        return 0;
      case "PSYCHOLOGIST":
        return 1;
      default:
        throw const FormatException("Invalid account type");
    }
  }

  static int? _getGenderFromString(String? gender) {
    switch (gender) {
      case "MALE":
        return 0;
      case "FEMALE":
        return 1;
      case "NONE":
        return 2;
      default:
        return null;
    }
  }

  static List<int>? _getTargetsFromStringList(List<String>? targetList) {
    return targetList?.map((target) {
      switch (target) {
        case "ANXIETY_CONTROL":
          return 0;
        case "REDUCE_STRESS":
          return 1;
        case "IMPROVE_HUMOR":
          return 2;
        case "IMPROVE_CONFIDENCE":
          return 3;
        case "IMPROVE_FOCUS":
          return 4;
        default:
          throw const FormatException("Invalid target");
      }
    }).toList();
  }

  static int? _getMeditationExperienceFromString(String? experience) {
    switch (experience) {
      case "REGULARLY":
        return 0;
      case "OCCASIONALLY":
        return 1;
      case "LONG_TIME":
        return 2;
      case "NEVER":
        return 3;
      default:
        return null;
    }
  }
}
