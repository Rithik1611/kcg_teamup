class Student {
  final String name;
  final String year;
  final List<String> skills;

  Student({
    required this.name,
    required this.year,
    required this.skills,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] as String,
      year: json['year'] as String,
      skills: List<String>.from(json['skills']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'year': year,
      'skills': skills,
    };
  }
}