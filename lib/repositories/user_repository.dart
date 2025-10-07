import '../models/user.dart';

// Repositório que abstrai a origem dos dados dos usuários
// Em um projeto real, isso poderia ser uma API, banco de dados, etc.
class UserRepository {
  // Simula a fonte de dados dos usuários
  List<User> getUsers() {
    return [
      User(id: '1', name: 'Alice', isOnline: true),
      User(id: '2', name: 'Bob'),
      User(id: '3', name: 'Charlie', isOnline: true),
      User(id: '4', name: 'Diana'),
      User(id: '5', name: 'Eduardo'),
      User(id: '6', name: 'Fernanda', isOnline: true),
      User(id: '7', name: 'Gabriel'),
      User(id: '8', name: 'Helena', isOnline: true),
    ];
  }
}