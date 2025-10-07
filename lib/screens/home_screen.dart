import 'package:flutter/material.dart';
import '../views/provider_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Status Online'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Simulador de Status Online com Provider',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Widget que usa o Provider.
            Expanded(child: ProviderView()),
          ],
        ),
      ),
    );
  }
}