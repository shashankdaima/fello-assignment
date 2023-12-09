from utils import *
import re


def write_to_screen_file(FILENAME, S_PATH, S_FN, VM_PATH, VM_FN, CC, PC):
    try:
        screen_content = f"""
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app_router.gr.dart';
import 'package:flutter_template/presentation/{FILENAME}/{VM_FN}';
import 'package:flutter_template/util/logger.dart';
import 'package:flutter_template/util/toast_and_snackbar.dart';

class {PC} extends ConsumerWidget {{
  const {PC}({{super.key}});

  @override
  Widget build(BuildContext context, WidgetRef ref) {{
    final viewModel = ref.read({CC}VmProvider.notifier);
    final logger = ref.read(loggerProvider);
    final toastAndSnackbar = ref.read(toastAndSnackbarProvider);
    ref.listen({CC}VmProvider.select((_) => _.status),
        (previousStatus, currentStatus) {{
      switch (currentStatus) {{
        case {PC}VmStatus.initial:
          logger.d('Status is initial');
          break;
        case {PC}VmStatus.loading:
          logger.d('Status is loading');
          toastAndSnackbar.showShortToast("Loading");
          break;
        case {PC}VmStatus.error:
          final errorMessage = ref.read({CC}VmProvider).errorMessage;
          logger.d('Status is error : ${{errorMessage!}}');
          toastAndSnackbar.showSnackBar(context, "Error: ${{errorMessage}}");
          break;
        case {PC}VmStatus.loaded:
          logger.d('Status is loaded');
          AutoRouter.of(context).push(const SecondRoute());
          break;
        default:
          logger.d('Unknown status');
      }}
    }});
    return Scaffold(
      appBar: AppBar(title: const Text("{PC}")),
      body: Center(
          child: Text("You are now in {PC}")),
    );
  }}
}}
"""

        with open(S_PATH, "w") as screen_file:
            screen_file.write(screen_content)
        print(f"Content written to {S_FN}")
    except Exception as e:
        print(f"Error writing to {S_FN}: {str(e)}")


def write_to_view_model_file(FILENAME, S_PATH, S_FN, VM_PATH, VM_FN, CC, PC):
    try:
        vm_content = f"""
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '{FILENAME}_vm.freezed.dart';
final {CC}VmProvider =
    StateNotifierProvider.autoDispose<{PC}Vm, {PC}VmState>(
        ((ref) => {PC}Vm(ref: ref)));

class {PC}Vm extends StateNotifier<{PC}VmState> {{
  final StateNotifierProviderRef ref;
  {PC}Vm({{required this.ref}}) : super(const {PC}VmState());
}}

@freezed
class {PC}VmState with _${PC}VmState {{
  const factory {PC}VmState({{
    @Default({PC}VmStatus.initial) {PC}VmStatus status,
    @Default(0) double signupButtonOpacity,
    @Default("") String email,
    String? errorMessage,
  }}) = _{PC}VmState;
}}

enum {PC}VmStatus {{ initial, loading, error, loaded }}
"""
        with open(VM_PATH, "w") as vm_file:
            vm_file.write(vm_content)
        print(f"Content written to {VM_FN}")
    except Exception as e:
        print(f"Error writing to {VM_FN}: {str(e)}")


def add_to_router(FILENAME, PC):
    new_route_entry = f"AutoRoute(path: '/{FILENAME}', page: {PC}),"
    router_file_path = "lib/core/app_router.dart"
    with open(router_file_path, "r") as file:
        dart_code = file.read()

    # Find the list of routes using regular expression
    routes_match = re.search(r"routes:\s*\[([\s\S]*?)\]", dart_code)
    if routes_match:
        routes_list = routes_match.group(1)

        # Add the new route entry at the bottom of the list
        new_routes_list = routes_list.strip() + "\n  " + new_route_entry

        # Replace the old routes list with the new one
        updated_dart_code = dart_code.replace(routes_list, new_routes_list)

        # Write the updated Dart code back to the file
        with open(router_file_path, "w") as file:
            file.write(updated_dart_code)
        print("Route added successfully.")
    else:
        print("Routes list not found in the Dart file.")


def add_export_statement_in_presentation(FILENAME):
    # Define the line to add to the end of the file
    new_line = f"export '{FILENAME}/{FILENAME}.dart';"

    # Define the path to the file you want to edit
    file_path = "lib/presentation/presentation.dart"

    # Open the file in append mode and add the new line
    with open(file_path, "a") as file:
        file.write(new_line + "\n")

    print("Line added to the end of the file.")


def screen_and_vm_gen(filename):
    FILENAME = filename
    S_FN = f"{FILENAME}.dart"
    S_PATH = f"lib/presentation/{FILENAME}/{S_FN}"
    VM_FN = f"{FILENAME}_vm.dart"
    VM_PATH = f"lib/presentation/{FILENAME}/{VM_FN}"
    CC, PC = snake_case_to_camel_and_pascal(FILENAME)
    write_to_screen_file(
        FILENAME=FILENAME,
        S_PATH=S_PATH,
        S_FN=S_FN,
        VM_FN=VM_FN,
        VM_PATH=VM_PATH,
        CC=CC,
        PC=PC,
    )
    write_to_view_model_file(
        FILENAME=FILENAME,
        S_PATH=S_PATH,
        S_FN=S_FN,
        VM_FN=VM_FN,
        VM_PATH=VM_PATH,
        CC=CC,
        PC=PC,
    )
    add_export_statement_in_presentation(FILENAME=FILENAME)
    add_to_router(FILENAME=FILENAME, PC=PC)  # Will move it to flutter_codegen.py
