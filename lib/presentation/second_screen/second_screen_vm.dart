import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'second_screen_vm.freezed.dart';

final secondScreenVmProvider =
    StateNotifierProvider.autoDispose<SecondScreenVm, SecondScreenVmState>(
        ((ref) => SecondScreenVm(ref: ref)));

class SecondScreenVm extends StateNotifier<SecondScreenVmState> {
  final StateNotifierProviderRef ref;
  SecondScreenVm({required this.ref}) : super(const SecondScreenVmState());
}

@freezed
class SecondScreenVmState with _$SecondScreenVmState {
  const factory SecondScreenVmState({
    @Default(SecondScreenVmStatus.initial) SecondScreenVmStatus status,
    @Default(0) double signupButtonOpacity,
    @Default("") String email,
    String? errorMessage,
  }) = _SecondScreenVmState;
}

enum SecondScreenVmStatus { initial, loading, error, loaded }
