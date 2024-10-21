class OnboardingDTO {
  final int accountId;
  final String fullName;
  final int gender;
  final int age;
  final List<int> target;
  final int meditationExperience;

  OnboardingDTO({
    required this.accountId,
    required this.fullName,
    required this.gender,
    required this.age,
    required this.target,
    required this.meditationExperience,
  });

  factory OnboardingDTO.fromJson(Map<String, dynamic> json) {
    return OnboardingDTO(
      accountId: json['accountId'],
      fullName: json['name'],
      gender: json['gender'] ?? 0,
      age: json['age'] ?? 0,
      target: json['targets'] != null
          ? List<int>.from(json['targets'])
          : [],
      meditationExperience: json['meditationExperience'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'name': fullName,
      'gender': gender,
      'age': age,
      'target': target,
      'meditationExperience': meditationExperience,
    };
  }
}
