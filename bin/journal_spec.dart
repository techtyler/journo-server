import 'goal.dart';
import 'habit.dart';
import 'prompt.dart';

class JournalSpec {
  final List<Prompt> prompts;
  final List<Habit> habits;
  final List<Goal> goals;

  JournalSpec(
      {required this.prompts, required this.habits, required this.goals});

  Map<String, dynamic> toMap() {
    return {
      'prompts': prompts.map((x) => x.toMap()).toList(),
      'habits': habits.map((x) => x.toMap()).toList(),
      'goals': goals.map((x) => x.toMap()).toList(),
    };
  }

  factory JournalSpec.fromMap(Map<String, dynamic> map) {
    return JournalSpec(
      prompts: List<Prompt>.from(map['prompts']?.map((x) => Prompt.fromMap(x))),
      habits: List<Habit>.from(map['habits']?.map((x) => Habit.fromMap(x))),
      goals: List<Goal>.from(map['goals']?.map((x) => Goal.fromMap(x))),
    );
  }
}

final JournalSpec defaultSpec = JournalSpec(prompts: [
  Prompt(
    title: "What would you like to say about today?",
    type: PromptType.long,
  )
], habits: [], goals: []);
