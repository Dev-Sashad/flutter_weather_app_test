import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrollable_panel/scrollable_panel.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/constant/sizeconfig.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widget/column_forecast_widget.dart';
import 'package:weather_app/widget/row_forecast_widget.dart';

class ForecastReport extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;
  ForecastReport({this.panelController, this.controller});
  @override
  _ForecastReportState createState() => _ForecastReportState();
}

class _ForecastReportState extends State<ForecastReport> {
  WeatherService _weatherService = locator<WeatherService>();
  @override
  Widget build(BuildContext context) {
    List<Daily> _daily = _weatherService.weatherData.daily;
    List<Hourly> _hourly = _weatherService.weatherData.hourly.where((e) {
      int hour = DateTime.fromMillisecondsSinceEpoch(e.dt * 1000).hour;
      return hour % 2 == 0;
    }).toList();
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          controller: widget.controller,
          child: Container(
            height: kheight(75, context),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                GestureDetector(
                  onTap: () => widget.panelController.close(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 45,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20)),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Forecast report',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                          customXMargin(10),
                          SvgPicture.asset('assets/images/arrow_down.svg')
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Today',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    customYMargin(10),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        height: 110,
                        width: kwidth(90, context),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0XFFD5C7FF))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _hourly
                              .take(5)
                              .map((e) => ColumnForecastWidget(
                                    data: e,
                                  ))
                              .toList(),
                        )),
                    customYMargin(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Next forecast',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w700)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 36,
                          width: 100,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text('Five Days',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                )),
                          ),
                        ),
                      ],
                    ),
                    customYMargin(10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      height: kheight(35, context),
                      width: kwidth(90, context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0XFFD5C7FF))),
                      child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return RowForecastWidget(data: _daily[i]);
                          }),
                    )
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
