import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app_router.gr.dart';

class SecondScreen extends ConsumerWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          AutoRouter.of(context).pop();
        },
        child: const Text(
            'Click Me To Move back to first screen.'), // The text displayed on the button
      )),
    );
  }
}
