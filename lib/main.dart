import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/di_container.dart';
import 'services/auth_service.dart';
import 'api/todo_api.dart';
import 'screens/login_screen.dart';
import 'screens/todo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIContainer.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DIContainer.instance.authService),
        Provider.value(value: DIContainer.instance.todoApi),
      ],
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Consumer<AuthService>(
          builder: (context, auth, _) {
            return auth.isAuthenticated ? TodoListScreen() : LoginScreen();
          },
        ),
      ),
    );
  }
}
