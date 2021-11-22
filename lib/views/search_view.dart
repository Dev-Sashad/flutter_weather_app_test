import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/constant/sizeconfig.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widget/home_temperature_widget.dart';

class LocationView extends StatefulWidget {
  final LatLng currentLatLng;
  final Current current;
  LocationView({this.current, this.currentLatLng});
  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  WeatherService _weatherService = locator<WeatherService>();
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    Placemark p = _weatherService.splacemark;
    bool _showmap = _weatherService.showmap;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _showmap
                ? Positioned.fill(
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: widget.currentLatLng,
                          zoom: 19.151926040649414),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  )
                : customXMargin(0),
            Positioned(
                top: kheight(8, context),
                left: 20,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _showmap ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    customXMargin(20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      width: 160,
                      decoration: BoxDecoration(
                        color: _showmap ? primaryColor : Colors.white38,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20)),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            customXMargin(10),
                            Text('${p.locality}, ${p.country}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TemperatureWidget(
                  placemark: p,
                  current: widget.current,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
