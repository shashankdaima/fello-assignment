import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app_router.gr.dart';
import 'package:flutter_template/presentation/first_screen/first_screen_vm.dart';
import 'package:flutter_template/util/logger.dart';
import 'package:flutter_template/util/toast_and_snackbar.dart';

class FirstScreen extends ConsumerWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(firstScreenVmProvider.notifier);
    final logger = ref.read(loggerProvider);
    final toastAndSnackbar = ref.read(toastAndSnackbarProvider);
    ref.listen(firstScreenVmProvider.select((_) => _.status),
        (previousStatus, currentStatus) {
      switch (currentStatus) {
        case FirstScreenVmStatus.initial:
          logger.d('Status is initial');
          break;
        case FirstScreenVmStatus.loading:
          logger.d('Status is loading');
          toastAndSnackbar.showShortToast("Loading");
          break;
        case FirstScreenVmStatus.error:
          final errorMessage = ref.read(firstScreenVmProvider).errorMessage;
          logger.d('Status is error : ${errorMessage!}');
          toastAndSnackbar.showSnackBar(context, "Error: ${errorMessage}");
          break;
        case FirstScreenVmStatus.loaded:
          logger.d('Status is loaded');
          AutoRouter.of(context).push(const SecondRoute());
          break;
        default:
          logger.d('Unknown status');
      }
    });
    return Scaffold(
      appBar: AppBar(title: const Text("First Screen")),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              viewModel.onScreenChangeButtonClicked();
            },
            child: const Text(
                'Click Me To Move to second screen.'), // The text displayed on the button
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).push(const ApiPagingRoute());
            },
            child: const Text(
                'Click Me To Move to Paging Screen.'), // The text displayed on the button
          ),
        ],
      )),
    );
  }
}
