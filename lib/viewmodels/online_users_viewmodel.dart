import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

// Esta classe é a nossa ViewModel para o Provider.
// Ela estende ChangeNotifier, um "emissor" de notificação de mudanças.
class OnlineUsersViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  
  // Lista privada de todos os usuários.
  List<User> _allUsers = [];
  
  // Termo de busca atual
  String _searchTerm = '';

  OnlineUsersViewModel(this._userRepository) {
    _loadUsers();
  }

  // Getters para expor os dados de forma segura
  List<User> get allUsers => _allUsers;
  String get searchTerm => _searchTerm;
  
  // Lista filtrada baseada no termo de busca
  List<User> get filteredUsers {
    if (_searchTerm.isEmpty) {
      return _allUsers;
    }
    return _allUsers
        .where((user) => user.name.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();
  }

  // Carrega os usuários do repositório
  void _loadUsers() {
    _allUsers = _userRepository.getUsers();
    notifyListeners();
  }

  // Método para alternar o status online de um usuário.
  void toggleStatus(String userId) {
    // Procura o usuário na lista pelo ID.
    final user = _allUsers.firstWhere((user) => user.id == userId);

    // Inverte o status de online.
    user.isOnline = !user.isOnline;
    
    // Notifica todos os "ouvintes" (widgets) que o estado mudou.
    notifyListeners();
  }

  // Método para atualizar o termo de busca
  void updateSearchTerm(String newSearchTerm) {
    _searchTerm = newSearchTerm;
    notifyListeners();
  }

  // Método para limpar a busca
  void clearSearch() {
    _searchTerm = '';
    notifyListeners();
  }
}