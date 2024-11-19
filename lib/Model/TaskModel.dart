class TaskModel {
  int? id;
  String title;
  String description;
  String? imagemu;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.imagemu,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagemu': imagemu,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imagemu: map['imagemu'],
    );
  }
}