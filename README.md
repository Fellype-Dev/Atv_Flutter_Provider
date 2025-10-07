# Provider Demo

Um projeto Flutter que demonstra o uso de Provider para gerenciamento de estado com funcionalidade de busca/filtro em tempo real.

## Funcionalidades

- **Provider**: Demonstra o uso do pacote `provider` para gerenciamento de estado
- **Arquitetura MVVM**: Separação clara entre View, ViewModel e Model
- **Busca em tempo real**: Campo de busca que filtra a lista de usuários instantaneamente
- **Interface intuitiva**: Lista de usuários com status online/offline
- **Estado reativo**: Simula o status online/offline de usuários com interação
- **Repositório**: Camada de abstração para fonte de dados

## Estrutura do Projeto (MVVM)

```
lib/
├── main.dart                         # Ponto de entrada da aplicação
├── models/
│   └── user.dart                    # Modelo de dados do usuário
├── repositories/
│   └── user_repository.dart         # Camada de abstração de dados
├── viewmodels/
│   └── online_users_viewmodel.dart  # ViewModel com lógica de negócio
├── screens/
│   └── home_screen.dart             # Tela principal
├── views/
│   └── provider_view.dart           # Widget que usa Provider (View)
└── widgets/
    └── user_tile.dart               # Widget reutilizável para usuários
```

### Padrão MVVM Implementado

- **Model** (`models/`): Classes de dados simples (User)
- **View** (`views/`, `screens/`, `widgets/`): Interface do usuário, sem lógica de negócio
- **ViewModel** (`viewmodels/`): Gerencia estado e lógica de negócio
- **Repository** (`repositories/`): Abstrai a origem dos dados

## Como executar

1. Instale as dependências:
   ```bash
   flutter pub get
   ```

2. Execute o projeto:
   ```bash
   flutter run
   ```

## Conceitos demonstrados

### Provider + MVVM
- `ChangeNotifier` (ViewModel)
- `ChangeNotifierProvider` (Injeção de dependência)
- `Consumer` (Observador da View)
- `notifyListeners()` (Notificação de mudanças)

### Funcionalidades
- **Busca em tempo real**: Filtro instantâneo na lista de usuários
- **Case insensitive**: Busca que ignora maiúsculas/minúsculas
- **Contador de resultados**: Mostra quantos usuários foram encontrados
- **Estado vazio**: Tela especial quando nenhum usuário é encontrado
- **Toggle de status**: Alternar entre online/offline

### Arquitetura
- **Separação de responsabilidades**: View só cuida da UI, ViewModel gerencia estado
- **Testabilidade**: Lógica isolada no ViewModel facilita testes unitários
- **Reutilização**: Repository abstrai fonte de dados para facilitar mudanças

## Dependências

- `provider: ^6.1.1` - Para gerenciamento de estado