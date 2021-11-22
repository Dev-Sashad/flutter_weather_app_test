import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/constant/helpers.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class ColumnForecastWidget extends StatefulWidget {
  final Hourly data;
  ColumnForecastWidget({this.data});

  @override
  _ColumnForecastWidgetState createState() => _ColumnForecastWidgetState();
}

class _ColumnForecastWidgetState extends State<ColumnForecastWidget> {
  WeatherService _weatherService = locator<WeatherService>();
  int temp = 0;
  @override
  void initState() {
    super.initState();
    if (widget.data.temp != null) {
      setState(() {
        temp = widget.data.temp.toInt();
      });
    } else {
      setState(() {
        temp = 0;
      });
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
      padding: EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_isCelcius ? '$temp °C' : '$farenhit °F',
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
            height: 20,
            width: 20,
          ),
          Text(
              formatHr(dateTime)
                  .toString()
                  .replaceFirst(RegExp(r'^0+'), "")
                  .toLowerCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
        ],
      ),
    );
  }
}
