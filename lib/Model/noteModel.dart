class Note {
  String? title;
  String? description;

  Note({required this.title, required this.description });

  Note.fromMap(Map<String, dynamic> map) {
    title = map[title];
    description = map[description];
  }
  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
  };
}