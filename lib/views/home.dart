import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:scrollable_panel/scrollable_panel.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/constant/sizeconfig.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widget/home_temperature_widget.dart';
import 'package:weather_app/widget/search_widget.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  final PanelController panelController;
  final PanelController notificationPanelController;
  Home({this.panelController, this.notificationPanelController});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherService _weatherService = locator<WeatherService>();
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng = _weatherService.latLng;
    print(currentLatLng.latitude);
    Placemark p = _weatherService.placemark;
    bool _isCelcius = _weatherService.isCelcius;
    bool _showmap = _weatherService.showmap;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              _showmap
                  ? Positioned.fill(
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: currentLatLng, zoom: 19.151926040649414),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    )
                  : customXMargin(0),
              Positioned(
                top: kheight(2, context),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text('Convert To',
                          style: TextStyle(
                              color: _showmap ? primaryColor : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      customXMargin(10),
                      GestureDetector(
                        onTap: () {
                          if (_isCelcius == true) {
                            _weatherService.setIsCelcius(false);
                            setState(() {});
                          } else {
                            _weatherService.setIsCelcius(true);
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: _showmap ? primaryColor : Colors.white24,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(_isCelcius ? '°F' : '°C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: kheight(2, context),
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (_showmap == true) {
                          _weatherService.setShowMap(false);
                          setState(() {});
                        } else {
                          _weatherService.setShowMap(true);
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                            color: _showmap ? primaryColor : Colors.white24,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text('Show Map',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: kheight(17, context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SearchTextField(),
                  )),
              Positioned(
                  top: kheight(8, context),
                  right: 20,
                  child: Container(
                    width: kwidth(90, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        GestureDetector(
                          onTap: () =>
                              widget.notificationPanelController.expand(),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: _showmap ? primaryColor : Colors.white38,
                                borderRadius: BorderRadius.circular(10)),
                            child:
                                Icon(Icons.notifications, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TemperatureWidget(
                    current: _weatherService.weatherData.current,
                    placemark: p,
                  ),
                ),
              ),
              Positioned(
                  bottom: kheight(10, context),
                  right: 20,
                  child: GestureDetector(
                    onTap: () => widget.panelController.expand(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: kwidth(90, context),
                      decoration: BoxDecoration(
                        color: _showmap ? primaryColor : Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Forecast report',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                          customXMargin(30),
                          SvgPicture.asset('assets/images/arrow_up.svg')
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
