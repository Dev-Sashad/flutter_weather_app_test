import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/constant/sizeconfig.dart';
import 'package:weather_app/model/weather_model.dart';

class NotificationTile extends StatefulWidget {
  final Current data;
  NotificationTile({this.data});
  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  String condition = " ";
  @override
  Widget build(BuildContext context) {
    var iconUrl = "https://openweathermap.org/img/w/" +
        widget.data.weather[0].icon.toString() +
        ".png";
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.data.dt * 1000);
    bool dy = Jiffy(dateTime).date == Jiffy(DateTime.now()).date;
    String realtime = Jiffy(dateTime).fromNow();

    if (widget.data.weather[0].main.toLowerCase().contains('sun')) {
      condition = 'sunny';
    } else if (widget.data.weather[0].main.toLowerCase().contains('rain')) {
      condition = 'rainy';
    } else if (widget.data.weather[0].main.toLowerCase().contains('cloud')) {
      condition = 'cloudy';
    } else {
      condition = 'moderate';
    }
    print(dy);
    return Container(
      width: kwidth(100, context),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
            color: dy ? Color(0XFFB9BCF2) : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CachedNetworkImage(
                  imageUrl: iconUrl,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  color: iconColor,
                  height: 30,
                  width: 30,
                ),
                customXMargin(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(realtime,
                        style: TextStyle(
                          color: Color(0XFF737272),
                          fontSize: 11,
                        )),
                    customYMargin(10),
                    Text('Its a $condition day in your location',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ],
                )
              ],
            ),
          ),
          !dy
              ? Divider(
                  thickness: 0.7,
                  color: Color(0XFFE3E3E3),
                )
              : customXMargin(0)
        ],
      ),
    );
  }
}
