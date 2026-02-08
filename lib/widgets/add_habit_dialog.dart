import 'package:flutter/material.dart';

class AddHabitDialog extends StatefulWidget {
  final Function(String, String) onConfirm;

  const AddHabitDialog({super.key, required this.onConfirm});

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Habit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              errorText: _isError ? 'Title cannot be empty' : null,
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) {
              if (_isError) {
                setState(() {
                  _isError = false;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(
              labelText: 'Description (Optional)',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty) {
              setState(() {
                _isError = true;
              });
            } else {
              widget.onConfirm(
                _titleController.text.trim(),
                _descController.text.trim(),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
