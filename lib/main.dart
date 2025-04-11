import 'package:flutter/material.dart';
import 'my_home_page.dart';
import 'counter_view.dart';
import 'heavy_task_view.dart';
import 'student_list_view.dart';
import 'login_view.dart';         
import 'auth_service.dart';      

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navegación',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      home: FutureBuilder<bool>(
        future: AuthService.isLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data! ? const MyHomePage() : const LoginView();
        },
      ),
      routes: {
        '/students': (_) => const StudentListView(),
        '/counter': (_) => const CounterView(),
        '/heavy': (_) => const HeavyTaskView(),
      },
    );
  }
}
