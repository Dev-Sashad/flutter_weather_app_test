import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/constant/helpers.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/constant/sizeconfig.dart';
import 'package:weather_app/services/weather_services.dart';
import 'mainhome.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  WeatherService _weatherService = locator<WeatherService>();
  bool _isLoading = false;
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 3), () async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      var isConnected = connectivityResult != ConnectivityResult.none;
      try {
        if (!isConnected) {
          setState(() {
            _isLoading = false;
          });
          showToast('No internet Connection. pls check!');
        } else {
          final location = await _weatherService.getUserLocation();
          if (location.latitude != null && location.longitude != null) {
            double lat = _weatherService.lat;
            double lng = _weatherService.lng;
            final data = await _weatherService.getWeatherData(lat, lng);
            await _weatherService.getPastData(lat, lng);
            var annn = data['status'];
            if (annn == true) {
              setState(() {
                _isLoading = false;
              });
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainHome()));
            } else {
              setState(() {
                _isLoading = false;
              });
              showToast(
                  'Unable to get weather infomation. Check internet connection');
            }
          }
        }
      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
        showToast('An Error Occured. Check internet connection');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    systemChrome(color: Color(0XFF8862FC).withOpacity(0.7).withOpacity(0.7));
    return SafeArea(
        child: Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: kheight(40, context)),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/weather.png'),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Weather App',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: kheight(20, context),
              left: kwidth(40, context),
              right: kwidth(40, context),
              child: _isLoading
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: CircularProgressIndicator(
                          strokeWidth: 4.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    )
                  : customXMargin(0),
            )
          ],
        ),
      ),
    ));
  }
}
