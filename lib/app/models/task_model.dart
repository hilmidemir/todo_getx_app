class TaskModel {
  final String id;
  final String title;
  final bool isDone;
  final DateTime createdAt;
  final String tagLabel;
  final int tagColorValue;

  TaskModel({
    required this.id,
    required this.title,
    required this.isDone,
    required this.createdAt,
    required this.tagLabel,
    required this.tagColorValue,
  });

  // Json a çevirme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
      'tagLabel': tagLabel,
      'tagColorValue': tagColorValue,
    };
  }

  // Json dan nesneye çevirme
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
      createdAt: DateTime.parse(json['createdAt']),
      tagLabel: json['tagLabel'],
      tagColorValue: json['tagColorValue'],
    );
  }

  // Kopyalama UI güncellemesi için
  TaskModel copyWith(
      {String? id, String? title, bool? isDone, DateTime? createdAt, String? tagLabel, int? tagColorValue}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      tagLabel: tagLabel ?? this.tagLabel,
      tagColorValue: tagColorValue ?? this.tagColorValue,
    );
  }
}
