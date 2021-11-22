import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      webPosition: "center",
      webBgColor: "#e74c3c",
      timeInSecForIosWeb: 5,
      // backgroundColor: AppColors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

formatDayMonth(value) {
  final df = new DateFormat('EEEE, d MMM');
  return df.format(value);
}

formatMonth(value) {
  final df = new DateFormat('MMM d');
  return df.format(value);
}

formatHour(value) {
  final df = new DateFormat('hh:mm a');
  return df.format(value);
}

formatHr(value) {
  final df = new DateFormat('hh a');
  return df.format(value);
}
