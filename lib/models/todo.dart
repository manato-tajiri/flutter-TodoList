class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;

  Todo({
    String? id,
    required this.title,
    this.isCompleted = false,
    DateTime? createdAt,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt = createdAt ?? DateTime.now();

  Todo copyWith({
    String? title,
    bool? isCompleted,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
    );
  }

  // データベース用のMapに変換
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  // Mapからオブジェクトを作成
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, isCompleted: $isCompleted)';
  }
}
