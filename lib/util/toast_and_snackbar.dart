import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/util/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

final toastAndSnackbarProvider =
    Provider((ref) => ToastAndSnackbar(logger: ref.read(loggerProvider)));

class ToastAndSnackbar {
  final Logger logger;
  const ToastAndSnackbar({required this.logger});
  void showSnackBar(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2),
      SnackBarAction? action}) async {
    final snackBar = SnackBar(
        content: Text(message),
        duration: duration, // How long the Snackbar will be displayed
        action: action);
    logger.i("Snackbar Displayed: $message");
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showShortToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  void showLongToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        fontSize: 16.0);
  }
}
