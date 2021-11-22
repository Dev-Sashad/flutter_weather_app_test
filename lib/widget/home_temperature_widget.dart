import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/constant/helpers.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/constant/sizeconfig.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class TemperatureWidget extends StatefulWidget {
  final Current current;
  final Placemark placemark;
  TemperatureWidget({this.current, this.placemark});
  @override
  _TemperatureWidgetState createState() => _TemperatureWidgetState();
}

class _TemperatureWidgetState extends State<TemperatureWidget> {
  WeatherService _weatherService = locator<WeatherService>();
  int temp = 0;

  @override
  Widget build(BuildContext context) {
    Current _current = widget.current;
    bool _showmap = _weatherService.showmap;

    if (_current.temp != null) {
      setState(() {
        temp = _current.temp.toInt();
      });
    } else {
      setState(() {
        temp = 0;
      });
    }

    var iconUrl = "https://openweathermap.org/img/w/" +
        _current.weather[0].icon.toString() +
        ".png";
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(_current.dt * 1000);

    bool _isCelcius = _weatherService.isCelcius;
    var farenhit = ((temp.toInt() * 9) ~/ 5).toInt() + 32;

    return Container(
      height: kheight(40, context),
      width: kwidth(90, context),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: _showmap ? primaryColor : Colors.white10,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white38),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.white10)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: iconUrl,
                fit: BoxFit.fill,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                color: Colors.white54,
              ),
              customXMargin(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Today',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600)),
                  customYMargin(10),
                  Text(formatDayMonth(dateTime).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isCelcius ? temp.toInt().toString() : farenhit.toString(),
                style: TextStyle(
                    fontSize: kheight(12, context),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: kheight(2, context)),
                child: Text(
                  _isCelcius ? '°C' : '°F',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          Text(
              '${widget.placemark.locality}, ${widget.placemark.country}. ${formatHour(dateTime).toString().toLowerCase()}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
        ],
      ),
    );
  }
}
