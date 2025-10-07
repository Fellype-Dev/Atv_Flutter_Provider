import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/online_users_viewmodel.dart';
import '../widgets/user_tile.dart';

// Widget que consome o estado usando o pacote `provider`.
class ProviderView extends StatelessWidget {
  const ProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos o `Consumer` para "escutar" o Provider.
    // Apenas este widget e seus filhos serão reconstruídos em caso de mudança.
    return Consumer<OnlineUsersViewModel>(
      builder: (context, viewModel, child) {
        // Exibe uma lista de usuários com campo de busca.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lista de Usuários',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Campo de busca
            TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar usuário...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onChanged: (value) => viewModel.updateSearchTerm(value),
            ),
            const SizedBox(height: 10),
            // Contador de resultados
            Text(
              '${viewModel.filteredUsers.length} usuário(s) encontrado(s)',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            // Lista de usuários filtrada
            Expanded(
              child: viewModel.filteredUsers.isEmpty && viewModel.searchTerm.isNotEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_off, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Nenhum usuário encontrado',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: viewModel.filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = viewModel.filteredUsers[index];
                        return UserTile(
                          user: user,
                          // Ao tocar no tile, chamamos o método do nosso ViewModel.
                          onTap: () => viewModel.toggleStatus(user.id),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}