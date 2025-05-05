enum GoalGranularity { daily, weekly, monthly, quarterly }

enum GoalType { atMost, atLeast }

class Goal {
  String habit;
  GoalGranularity granularity;
  GoalType type;
  int amount;

  Goal(
      {required this.habit,
      required this.granularity,
      required this.type,
      required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'habit': habit,
      'granularity': granularity.toString().split('.').last,
      'type': type.toString().split('.').last,
      'amount': amount,
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      habit: map['habit'],
      granularity: GoalGranularity.values.firstWhere(
        (e) => e.toString().split('.').last == map['granularity'],
      ),
      type: GoalType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
      ),
      amount: map['amount'],
    );
  }
}
