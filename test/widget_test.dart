// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider_demo/main.dart';
import 'package:provider_demo/models/user.dart';
import 'package:provider_demo/viewmodels/online_users_viewmodel.dart';
import 'package:provider_demo/repositories/user_repository.dart';

void main() {
  group('User Model Tests', () {
    test('User model should create correctly', () {
      final user = User(id: '1', name: 'Test User', isOnline: true);
      
      expect(user.id, '1');
      expect(user.name, 'Test User');
      expect(user.isOnline, true);
    });

    test('User model should have default offline status', () {
      final user = User(id: '2', name: 'Test User 2');
      
      expect(user.isOnline, false);
    });
  });

  group('ViewModel Tests', () {
    late OnlineUsersViewModel viewModel;
    late UserRepository repository;

    setUp(() {
      repository = UserRepository();
      viewModel = OnlineUsersViewModel(repository);
    });

    test('ViewModel should load users correctly', () {
      expect(viewModel.allUsers.length, 8);
      expect(viewModel.filteredUsers.length, 8);
      expect(viewModel.searchTerm, '');
      
      // Verifica se Alice está online inicialmente
      final alice = viewModel.allUsers.firstWhere((user) => user.name == 'Alice');
      expect(alice.isOnline, true);
    });

    test('ViewModel should toggle user status', () {
      // Encontra Alice (que começa online)
      final alice = viewModel.allUsers.firstWhere((user) => user.name == 'Alice');
      expect(alice.isOnline, true);
      
      // Alterna o status de Alice
      viewModel.toggleStatus(alice.id);
      expect(alice.isOnline, false);
      
      // Alterna novamente
      viewModel.toggleStatus(alice.id);
      expect(alice.isOnline, true);
    });

    test('ViewModel should filter users correctly', () {
      // Teste com termo vazio - deve retornar todos
      expect(viewModel.filteredUsers.length, 8);
      
      // Teste com "Alice" - deve retornar apenas Alice
      viewModel.updateSearchTerm('Alice');
      expect(viewModel.filteredUsers.length, 1);
      expect(viewModel.filteredUsers.first.name, 'Alice');
      
      // Teste com "a" (case insensitive) - deve retornar usuários com "a"
      viewModel.updateSearchTerm('a');
      final usersWithA = viewModel.filteredUsers;
      expect(usersWithA.length, greaterThan(0));
      expect(usersWithA.every((user) => user.name.toLowerCase().contains('a')), true);
      
      // Teste com "Charlie" - deve retornar Charlie
      viewModel.updateSearchTerm('Charlie');
      expect(viewModel.filteredUsers.length, 1);
      expect(viewModel.filteredUsers.first.name, 'Charlie');
      
      // Teste com termo que não existe
      viewModel.updateSearchTerm('xyz');
      expect(viewModel.filteredUsers.length, 0);
    });

    test('ViewModel should clear search correctly', () {
      // Define um termo de busca
      viewModel.updateSearchTerm('Alice');
      expect(viewModel.searchTerm, 'Alice');
      expect(viewModel.filteredUsers.length, 1);
      
      // Limpa a busca
      viewModel.clearSearch();
      expect(viewModel.searchTerm, '');
      expect(viewModel.filteredUsers.length, 8);
    });

    test('ViewModel should update search term correctly', () {
      expect(viewModel.searchTerm, '');
      
      viewModel.updateSearchTerm('Test');
      expect(viewModel.searchTerm, 'Test');
      
      viewModel.updateSearchTerm('Another Test');
      expect(viewModel.searchTerm, 'Another Test');
    });
  });

  group('Widget Tests', () {
    testWidgets('MyApp should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Verifica se o título aparece
      expect(find.text('Simulador de Status Online'), findsOneWidget);
      expect(find.text('Simulador de Status Online com Provider'), findsOneWidget);
      
      // Verifica se a seção aparece
      expect(find.text('Lista de Usuários'), findsOneWidget);
    });

    testWidgets('User tiles should be tappable', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Encontra os tiles dos usuários
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
      
      // Verifica se os status aparecem
      expect(find.text('Online'), findsWidgets);
      expect(find.text('Offline'), findsWidgets);
    });
  });
}
