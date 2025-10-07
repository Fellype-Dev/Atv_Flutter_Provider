import 'package:flutter/material.dart';
import '../models/user.dart';

// Widget reutilizável para exibir cada usuário na lista.
class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserTile({
    required this.user,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.isOnline ? 'Online' : 'Offline'),
        leading: CircleAvatar(
          backgroundColor: user.isOnline ? Colors.green : Colors.grey,
          child: Icon(
            user.isOnline ? Icons.person : Icons.person_outline,
            color: Colors.white,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}