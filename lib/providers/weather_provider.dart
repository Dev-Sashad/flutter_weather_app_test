import 'package:flutter/material.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/model/dialog_models.dart';
import 'package:weather_app/services/dialog_service.dart';

class WeatherProvider extends ChangeNotifier {
  final DialogService _dialogService = locator<DialogService>();
  DialogResponse hh;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
    if (value == true) {
      _dialogService.showDialog();
    } else {
      _dialogService.dialogComplete(hh);
    }
  }
}
