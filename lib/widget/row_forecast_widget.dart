import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/constant/helpers.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/constant/sizeconfig.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class RowForecastWidget extends StatefulWidget {
  final Daily data;
  RowForecastWidget({this.data});

  @override
  _RowForecastWidgetState createState() => _RowForecastWidgetState();
}

class _RowForecastWidgetState extends State<RowForecastWidget> {
  WeatherService _weatherService = locator<WeatherService>();
  int temp = 0;

  @override
  void initState() {
    super.initState();
    int hour = DateTime.now().hour;

    if (hour > 4 && hour < 14) {
      if (widget.data.temp.morn != null) {
        setState(() {
          temp = widget.data.temp.morn.toInt();
        });
      } else {
        setState(() {
          temp = 0;
        });
      }
    } else if (hour >= 14 && hour < 20) {
      if (widget.data.temp.eve != null) {
        setState(() {
          temp = widget.data.temp.eve.toInt();
        });
      } else {
        setState(() {
          temp = 0;
        });
      }
    } else {
      if (widget.data.temp.night != null) {
        setState(() {
          temp = widget.data.temp.night.toInt();
        });
      } else {
        setState(() {
          temp = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var iconUrl = "https://openweathermap.org/img/w/" +
        widget.data.weather[0].icon.toString() +
        ".png";

    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.data.dt * 1000);

    bool _isCelcius = _weatherService.isCelcius;
    var farenhit = ((temp.toInt() * 9) ~/ 5).toInt() + 32;

    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${formatMonth(dateTime)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    )),
                CachedNetworkImage(
                  imageUrl: iconUrl,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  color: iconColor,
                  height: 30,
                  width: 30,
                ),
                Text(_isCelcius ? '$temp °C' : '$farenhit °F',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    )),
              ],
            ),
          ),
          customYMargin(3),
          Divider(
            thickness: 0.7,
            color: Color(0XFFE3E3E3),
          )
        ],
      ),
    );
  }
}
