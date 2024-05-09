class TarefasModels {
  final int id;
  final String description;
   bool isConcluided;

  TarefasModels(
      {required this.id,
      required this.description,
      required this.isConcluided});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'isConcluided': isConcluided,
    };
  }

  factory TarefasModels.fromMap(Map<String, dynamic> map) {
    return TarefasModels(
      id: map['id'] as int,
      description: map['description'] as String,
      isConcluided: map['isConcluided'] == 1 ? true : false,
    );
  }
}
