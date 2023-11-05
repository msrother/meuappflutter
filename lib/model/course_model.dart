class CourseEntity {
  String? id;
  String? name;
  String? description;
  String? start_at;

  CourseEntity({this.id, this.name, this.description, this.start_at});

  static CourseEntity fromJson(Map<String, dynamic> map) {
    return CourseEntity(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        start_at: map['start_at']);
  }
}
