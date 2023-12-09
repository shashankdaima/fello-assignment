import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/repository/news_article_caching_strategy.dart';
import 'package:flutter_template/services/api_services/dto/news_api_paginate_models/error_response.dart'
    as news_api_error_models;
import 'package:flutter_template/services/api_services/dto/news_api_paginate_models/success_response.dart'
    as news_api_success_models;
import 'package:flutter_template/services/api_services/news_api_client.dart';
import 'package:flutter_template/services/db_services/app_db.dart';
import 'package:flutter_template/services/db_services/entities/task_entity.dart';
import 'package:flutter_template/util/logger.dart';
import 'package:flutter_template/util/resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'first_screen_vm.freezed.dart';

final firstScreenVmProvider =
    StateNotifierProvider.autoDispose<FirstScreenVm, FirstScreenVmState>(
        ((ref) => FirstScreenVm(ref: ref, database: ref.read(appDbProvider))));

class FirstScreenVm extends StateNotifier<FirstScreenVmState> {
  final StateNotifierProviderRef ref;
  late Logger logger;
  final Future<AppDatabase> database;
  late StreamSubscription databaseSubscription;

  FirstScreenVm({required this.ref, required this.database})
      : super(const FirstScreenVmState()) {
    logger = ref.read(loggerProvider);
    loadValues();
  }
  // void onScreenChangeButtonClicked() async {
  //   state = state.copyWith(status: FirstScreenVmStatus.loading);
  //   try {
  //     // Code that may throw an exception
  //     // Usually whole async functionality should go here.
  //     await Future.delayed(const Duration(seconds: 2));
  //     state = state.copyWith(status: FirstScreenVmStatus.loaded);
  //   } on Error catch (e) {
  //     // Code to handle other exceptions
  //     state = state.copyWith(
  //         status: FirstScreenVmStatus.error, errorMessage: e.toString());
  //   } finally {
  //     state = state.copyWith(status: FirstScreenVmStatus.initial);
  //     // state = state.copyWith(status: FirstScreenVmStatus.loaded);
  //     // if you want to ignore some part of try catch error. Then make
  //     // this either loaded, or initial.
  //   }
  // }
  loadValues() async {
    // debugPrint((await(await database).reservationDao.getAllReservations()).length.toString());
    final listOfReservation = (await database).taskDao.getAllTask();

    databaseSubscription = listOfReservation.listen((reservations) {
      debugPrint(reservations.length.toString());
      state = state.copyWith(tasks: reservations);
    });
  }

  @override
  void dispose() {
    databaseSubscription.cancel();
    super.dispose();
  }

  void addTask() async {}
}

@freezed
class FirstScreenVmState with _$FirstScreenVmState {
  const factory FirstScreenVmState(
      {@Default(FirstScreenVmStatus.initial) FirstScreenVmStatus status,
      String? errorMessage,
      @Default([]) List<TaskEntity> tasks}) = _FirstScreenVmState;
}

enum FirstScreenVmStatus { initial, loading, error, loaded }
