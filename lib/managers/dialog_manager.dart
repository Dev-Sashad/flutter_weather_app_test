import 'package:flutter/material.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/model/dialog_models.dart';
import 'package:weather_app/services/dialog_service.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        dismissable: false,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));

    // pr.show();
    progressDialog.show(); // show dialog
    //progressDialog.dismiss();
    print('show');
  }
}
