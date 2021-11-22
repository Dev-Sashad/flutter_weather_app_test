import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/constant/sizeconfig.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widget/notification_tile.dart';

class NotificationView extends StatefulWidget {
  final ScrollController controller;

  NotificationView({this.controller});
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  WeatherService _weatherService = locator<WeatherService>();
  @override
  Widget build(BuildContext context) {
    Current today = _weatherService.weatherData.current;
    Current yesterday = _weatherService.yesday;
    Current twodays = _weatherService.twday;
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          controller: widget.controller,
          child: Container(
            height: kheight(50, context),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white),
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 100,
                  color: Color(0XFF9D9D9D),
                ),
                customYMargin(20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20), right: Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text('Your Notifications',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('New',
                            style: TextStyle(
                              color: Color(0XFF737272),
                              fontSize: 12,
                            )),
                      ),
                    ),
                    customYMargin(10),
                    NotificationTile(data: today),
                    customYMargin(20),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Earlier',
                            style: TextStyle(
                              color: Color(0XFF737272),
                              fontSize: 12,
                            )),
                      ),
                    ),
                    customYMargin(10),
                    NotificationTile(data: yesterday),
                    customYMargin(10),
                    NotificationTile(data: twodays),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
