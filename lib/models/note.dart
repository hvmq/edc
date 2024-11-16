class Note {
  final int userId;
  final String title;
  final String? description;

  Note({required this.userId, required this.title, this.description});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
    };
  }
}
