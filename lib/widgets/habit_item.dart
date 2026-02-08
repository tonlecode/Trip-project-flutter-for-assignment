import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitItem extends StatelessWidget {
  final Habit habit;
  final ValueChanged<bool?> onCheckedChange;

  const HabitItem({
    super.key,
    required this.habit,
    required this.onCheckedChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: habit.isCompleted ? 0 : 2,
      color: habit.isCompleted
          ? Theme.of(context).colorScheme.secondaryContainer
          : Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Checkbox(
              value: habit.isCompleted,
              onChanged: onCheckedChange,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          decoration: habit.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: habit.isCompleted
                              ? Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer
                                  .withOpacity(0.6)
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  if (habit.description.isNotEmpty)
                    Text(
                      habit.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: habit.isCompleted
                                ? Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer
                                    .withOpacity(0.5)
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                ],
              ),
            ),
            if (habit.streak > 0 && !habit.isCompleted)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "🔥 ${habit.streak}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
