import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/online_users_viewmodel.dart';
import 'repositories/user_repository.dart';
import 'screens/home_screen.dart';

// Widget principal que contém toda a nossa aplicação.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // O provider que irá fornecer a nossa ViewModel para a árvore de widgets.
      // Ele é colocado no topo da árvore.
      create: (context) => OnlineUsersViewModel(UserRepository()),
      child: MaterialApp(
        title: 'Status Online Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}