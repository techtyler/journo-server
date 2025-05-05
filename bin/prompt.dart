class Prompt {
  final String title;
  final PromptType type;
  final String? min;
  final String? max;

  Prompt({required this.title, required this.type, this.min, this.max});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> m = {
      'title': title,
      'type': type.toString().split('.').last,
    };

    if (type == PromptType.scale) {
      m['min'] = min;
      m['max'] = max;
    }
    return m;
  }

  factory Prompt.fromMap(Map<String, dynamic> map) {
    return Prompt(
      title: map['title'],
      type: PromptType.values
          .firstWhere((e) => e.toString().split('.').last == map['type']),
      min: map['min'],
      max: map['max'],
    );
  }
}

enum PromptType {
  short,
  long,
  scale,
}
