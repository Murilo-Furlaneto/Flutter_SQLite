class TarefasModels {
  final int id;
  final String description;

  TarefasModels({required this.id, required this.description});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
    };
  }

  factory TarefasModels.fromMap(Map<String, dynamic> map) {
    return TarefasModels(
      id: map['id'] as int,
      description: map['description'] as String,
    );
  }
}
