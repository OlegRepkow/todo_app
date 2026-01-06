import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import '../services/auth_service.dart';
import '../providers/todo_provider.dart';
import '../providers/theme_provider.dart';
import '../themes/app_theme.dart';
import 'todo_detail_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoProvider>().loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.appColors;

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        title: const Text('Мої завдання'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: colors.onPrimary,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: colors.onPrimary),
            onPressed: () => context.read<AuthService>().logout(),
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return Center(
              child: CircularProgressIndicator(color: colors.onPrimary),
            );
          }

          if (provider.todos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 80,
                    color: colors.emptyStateIcon,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Немає завдань',
                    style: TextStyle(
                      fontSize: 18,
                      color: colors.emptyStateText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Додайте перше завдання!',
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.emptyStateSecondaryText,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.todos.length,
            itemBuilder: (context, index) {
              final todo = provider.todos[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: colors.todoCardBg,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colors.todoCardShadow,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodoDetailScreen(todo: todo),
                    ),
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                      color: todo.isCompleted
                          ? colors.completedText
                          : colors.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: todo.description?.isNotEmpty == true
                      ? Text(
                          todo.description!,
                          style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: todo.isCompleted
                                ? colors.completedText
                                : colors.onSurface.withValues(alpha: 0.7),
                          ),
                        )
                      : null,
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: todo.isCompleted
                          ? colors.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: colors.primary,
                        width: 2,
                      ),
                    ),
                    child: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) => provider.toggleTodo(todo),
                      activeColor: Colors.transparent,
                      checkColor: colors.onPrimary,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: colors.errorColor,
                    ),
                    onPressed: () => provider.deleteTodo(todo),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        icon: const Icon(Icons.add),
        label: const Text('Додати'),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.appColors;
    final controller = TextEditingController();
    final descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.add_task,
                color: colors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Нове завдання',
              style: TextStyle(color: colors.onSurface),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              style: TextStyle(color: colors.onSurface),
              decoration: InputDecoration(
                hintText: 'Введіть назву завдання',
                hintStyle:
                    TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
                prefixIcon: Icon(Icons.edit, color: colors.primary),
                filled: true,
                fillColor: colors.inputFillColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              style: TextStyle(color: colors.onSurface),
              decoration: InputDecoration(
                hintText: 'Введіть опис завдання',
                hintStyle:
                    TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
                prefixIcon: Icon(Icons.edit, color: colors.primary),
                filled: true,
                fillColor: colors.inputFillColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Скасувати',
              style: TextStyle(color: colors.onSurface),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<TodoProvider>().addTodo(
                      Todo(
                        title: controller.text,
                        description: descriptionController.text,
                      ),
                    );
                Navigator.pop(context);
              }
            },
            child: const Text('Додати'),
          ),
        ],
      ),
    );
  }
}
