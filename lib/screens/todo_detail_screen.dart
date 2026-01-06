import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../themes/app_theme.dart';

class TodoDetailScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.appColors;

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        title: const Text('Деталі завдання'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.todoCardBg,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: colors.todoCardShadow,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: todo.isCompleted
                            ? colors.completedTodoColor
                            : colors.inProgressTodoColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        todo.isCompleted ? Icons.check_circle : Icons.schedule,
                        color: colors.surface,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        todo.isCompleted ? 'Завершено' : 'В процесі',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: todo.isCompleted
                              ? colors.completedTodoColor
                              : colors.inProgressTodoColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Назва',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  todo.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Опис',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.inputFillColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colors.divider,
                    ),
                  ),
                  child: Text(
                    todo.description?.isNotEmpty == true
                        ? todo.description!
                        : 'Опис відсутній',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: todo.description?.isNotEmpty == true
                          ? colors.onSurface
                          : colors.emptyStateSecondaryText,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
