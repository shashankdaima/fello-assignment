import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app_router.gr.dart';
import 'package:flutter_template/core/global_db.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondScreen extends ConsumerWidget {
  SecondScreen({super.key});
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController installmentsController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbInteractor = ref.read(globalDbProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Goal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: installmentsController,
              decoration: const InputDecoration(
                labelText: 'Number of Installments',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: purposeController,
              decoration: const InputDecoration(
                labelText: 'Purpose',
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          try {
            String installments = installmentsController.text.trim();
            String purpose = purposeController.text.trim();
            // print("$installments, ${int.tryParse(purpose.trim())}");
            dbInteractor.addTask(purpose, int.tryParse(purpose.trim()) ?? 10);
            context.navigateBack();
          } catch (e) {
            print('Error: Invalid input. Please enter valid values.');
          }
        },
        icon: const Icon(Icons.add),
        label: Text(
          'Add',
          style: GoogleFonts.robotoCondensed(
              fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
