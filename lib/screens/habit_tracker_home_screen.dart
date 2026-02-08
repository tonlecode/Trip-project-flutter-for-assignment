import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../widgets/habit_item.dart';
import '../widgets/add_habit_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample data
  final List<Habit> _habits = [
    Habit(
      id: 1,
      title: "Morning Jog",
      description: "Run for 30 minutes",
      isCompleted: false,
      streak: 3,
    ),
    Habit(
      id: 2,
      title: "Read Book",
      description: "Read 10 pages",
      isCompleted: true,
      streak: 12,
    ),
    Habit(
      id: 3,
      title: "Drink Water",
      description: "8 glasses a day",
      isCompleted: false,
      streak: 0,
    ),
  ];

  void _addHabit(String title, String description) {
    setState(() {
      final newId = (_habits.isEmpty ? 0 : _habits.map((e) => e.id).reduce((a, b) => a > b ? a : b)) + 1;
      _habits.add(Habit(
        id: newId,
        title: title,
        description: description,
      ));
    });
  }

  void _toggleHabit(Habit habit, bool? isChecked) {
    setState(() {
      habit.isCompleted = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          return HabitItem(
            habit: habit,
            onCheckedChange: (isChecked) => _toggleHabit(habit, isChecked),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddHabitDialog(onConfirm: _addHabit),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
