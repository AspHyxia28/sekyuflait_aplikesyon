class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;

  TaskModel({required this.id, required this.title, this.isCompleted = false});

  @override
  String toString() =>
      'TaskModel(id:$id, title:$title, isCompleted:$isCompleted)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  Map<String, Object?> toJson() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted ? 1 : 0};
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: (json['isCompleted'] as int) == 1,
    );
  }
}
