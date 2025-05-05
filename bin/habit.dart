class Habit {
  String name;
  String unit;

  Habit({required this.name, required this.unit});

  Map<String, dynamic> toMap() => {
        'name': name,
        'unit': unit,
      };

  factory Habit.fromMap(Map<String, dynamic> map) => Habit(
        name: map['name'],
        unit: map['unit'],
      );
}