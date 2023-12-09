import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app_router.gr.dart';
import 'package:flutter_template/presentation/common_ui/tree_list_element.dart';
import 'package:flutter_template/presentation/first_screen/first_screen_vm.dart';
import 'package:flutter_template/presentation/first_screen/widgets/dashboard.dart';
import 'package:flutter_template/util/logger.dart';
import 'package:flutter_template/util/toast_and_snackbar.dart';
import 'package:rive/rive.dart';

class FirstScreen extends ConsumerWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(firstScreenVmProvider.notifier);
    final logger = ref.read(loggerProvider);
    final toastAndSnackbar = ref.read(toastAndSnackbarProvider);
    final Size screenDimens = MediaQuery.of(context).size;

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
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D4C61),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF850B52),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset("assets/avatar.png"),
            ),
          ),
        ),
      ),
      body: ListView.builder(itemBuilder: (BuildContext ctx, int idx) {
        if (idx == 0) {
          return Container(
              decoration: BoxDecoration(
                color: const Color(0xFF4D4C61),
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(20.0), // Adjust the radius as needed
                  bottomRight:
                      Radius.circular(20.0), // Adjust the radius as needed
                ),
              ),
              child: const Dashboard());
        }
        return TreeListElement(title: "Element", progress: 12, stage: 6);
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          // Add your FAB onPressed logic here
        },
        child: const Icon(
          Icons.priority_high,
          color: Colors.grey,
        ),
      ),
    );
  }
}