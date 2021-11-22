import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_panel/scrollable_panel.dart';
import 'package:weather_app/views/notification.dart';
import 'forecast_report.dart';
import 'home.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final PanelController panelController = PanelController();
  final PanelController notificationPanelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            Positioned(
              child: Home(
                panelController: panelController,
                notificationPanelController: notificationPanelController,
              ),
            ),
            ScrollablePanel(
                defaultPanelState: PanelState.close,
                controller: panelController,
                onOpen: () => print('onOpen'),
                onClose: () => panelController.close(),
                onExpand: () => print('onExpand'),
                builder: (context, controller) {
                  return GestureDetector(
                    onVerticalDragStart: (dragStrartDetails) =>
                        panelController.close(),
                    child: ForecastReport(
                      controller: controller,
                      panelController: panelController,
                    ),
                  );
                }),
            ScrollablePanel(
                defaultPanelState: PanelState.close,
                controller: notificationPanelController,
                onOpen: () => print('onOpen'),
                onClose: () => print('onClose'),
                onExpand: () => print('onExpand'),
                builder: (context, controller) {
                  return GestureDetector(
                      onVerticalDragStart: (dragStartDetails) =>
                          notificationPanelController.close(),
                      child: NotificationView(
                        controller: controller,
                      ));
                })
          ])),
    );
  }
}
