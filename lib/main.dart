import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'services/di_container.dart';
import 'services/auth_service.dart';
import 'api/todo_api.dart';
import 'screens/login_screen.dart';
import 'screens/todo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIContainer.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider(
                  DIContainer.instance.todoApi,
                  DIContainer.instance.storage,
                )),
        ChangeNotifierProvider.value(value: DIContainer.instance.authService),
        Provider.value(value: DIContainer.instance.todoApi),
        ChangeNotifierProvider(
            create: (context) => TodoProvider(context.read<TodoApi>())),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo App',
            theme: themeProvider.getThemeData(),
            home: Consumer<AuthService>(
              builder: (context, auth, _) {
                return auth.isAuthenticated
                    ? const TodoListScreen()
                    : const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
