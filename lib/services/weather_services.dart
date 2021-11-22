import 'dart:convert';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/constant/urls.dart';
import 'package:weather_app/model/IpAddress_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/model/dialog_models.dart';
import 'package:weather_app/services/dialog_service.dart';

class WeatherService {
  final DialogService _dialogService = locator<DialogService>();
  DialogResponse hh;
  double _lat;
  double get lat => _lat;
  double _lng;
  double get lng => _lng;
  setLatLng(double lat, double lng) {
    _lat = lat;
    _lng = lng;
    print(lat);
    print(lng);
  }

  //latitued and longitude for map
  LatLng _latLng;
  LatLng get latLng => _latLng;
  setMapLatLng(LatLng value) {
    _latLng = value;
    print(value);
  }

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    if (value == true) {
      _dialogService.showDialog();
    } else {
      _dialogService.dialogComplete(hh);
    }
  }

//boolean to determin if the app should display celcius or farenhit
  bool _isCelcius = true;
  bool get isCelcius => _isCelcius;
  setIsCelcius(bool value) {
    _isCelcius = value;
    print(value);
  }

//boolean to determin if the map should display c
  bool _showmap = false;
  bool get showmap => _showmap;
  setShowMap(bool value) {
    _showmap = value;
    print(value);
  }

// Main data of the current day hours and five days after
  WeatherData _weatherData;
  WeatherData get weatherData => _weatherData;
  setWeatherData(WeatherData value) {
    _weatherData = value;
    print(value.toJson());
  }

  //data fetched after search
  WeatherData _searchData;
  WeatherData get searchData => _searchData;
  setSearchData(WeatherData value) {
    _searchData = value;
    print(value.toJson());
  }

// data of one day ago
  Current _ysday;
  Current get yesday => _ysday;
  setYsDay(Current value) {
    _ysday = value;
    print(value.toJson());
  }

  // data of two days ago
  Current _twday;
  Current get twday => _twday;
  setTwDay(Current value) {
    _twday = value;
    print(value.toJson());
  }

  // Model for getting location base on Ip address.
  // this is fr case of user denying acess to location
  // IpAddressModel _ipAddressModel;
  // IpAddressModel get ipAddressModel => _ipAddressModel;
  // setIpAddressModel(IpAddressModel value) {
  //   _ipAddressModel = value;
  //   print(value.toJson());
  // }

  // users place location
  Placemark _placemark;
  Placemark get placemark => _placemark;
  setPlaceMark(Placemark value) {
    _placemark = value;
    print(value.country);
  }

  // serch value place location
  Placemark _splacemark;
  Placemark get splacemark => _splacemark;
  setSPlaceMark(Placemark value) {
    _splacemark = value;
    print(value.country);
  }

  //Fuction to fetch waether data for current day and five days after
  Future<Map<String, dynamic>> getWeatherData(double lat, double lng) async {
    try {
      String url = Paths.baseUrl +
          Paths.pathUrl +
          Paths.lat +
          lat.toString() +
          Paths.lon +
          lng.toString() +
          Paths.units +
          Paths.exclude +
          Paths.completeApi +
          Paths.apikey;
      print(url);
      Response response = await get(
        Uri.parse(url),
        // headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        //log('response: $responseData');
        WeatherData weatherData = WeatherData.fromJson(responseData);
        setWeatherData(weatherData);
        print(weatherData.toJson());
        var result = {
          'status': true,
          'message': 'Weather data fetched',
        };
        print(result);
        return result;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        log('response: $responseData');
        var result = {
          'status': false,
          'message': 'No Data fetched',
        };
        print(result);
        return result;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //function to fetch 2 days past weather data
  Future getPastData(double lat, double lng) async {
    int yesterday =
        (DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch ~/
                1000)
            .toInt();
    int twodays =
        (DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch ~/
                1000)
            .toInt();
    try {
      String url1 = Paths.baseUrl +
          Paths.bytimeUrl +
          Paths.lat +
          lat.toString() +
          Paths.lon +
          lng.toString() +
          Paths.timeMach +
          yesterday.toString() +
          Paths.units +
          Paths.exclude +
          Paths.completeApi +
          Paths.apikey;

      String url2 = Paths.baseUrl +
          Paths.bytimeUrl +
          Paths.lat +
          lat.toString() +
          Paths.lon +
          lng.toString() +
          Paths.timeMach +
          twodays.toString() +
          Paths.units +
          Paths.exclude +
          Paths.completeApi +
          Paths.apikey;
      print(url1);
      print(url2);
      Response response1 = await get(
        Uri.parse(url1),
        //headers: {'Content-Type': 'application/json'},
      );

      Response response2 = await get(
        Uri.parse(url2),
        // headers: {'Content-Type': 'application/json'},
      );

      if (response1.statusCode == 201 || response1.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response1.body);
        //log('response: $responseData');
        WeatherByTime _weatherByTime = WeatherByTime.fromJson(responseData);
        setYsDay(_weatherByTime.current);
        print(_weatherByTime.current.toJson());
      }

      if (response2.statusCode == 201 || response2.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response2.body);
        //log('response: $responseData');
        WeatherByTime _weatherByTime = WeatherByTime.fromJson(responseData);
        setTwDay(_weatherByTime.current);
        print(_weatherByTime.current.toJson());
      }
    } catch (e) {
      print(e.toString());
    }
  }

//function to fetch the coordinates from user Location
  Future<LatLng> getUserLocation() async {
    //LocationData currentLocation;
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print('location: ${position.latitude}');
        // final coordinates = new Coordinates(position.latitude, position.longitude);
        var addresses = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        var first = addresses.first;
        setPlaceMark(first);
        // currentLocation = await location.getLocation();
        var lat = position.latitude;
        var lng = position.longitude;
        print(lat);
        print(lng);
        LatLng latLng = LatLng(lat, lng);
        setLatLng(lat, lng);
        setMapLatLng(latLng);
        return latLng;
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      try {
        Response response = await get(
          Uri.parse(Paths.ipAddressUrl),
          // headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 201 || response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          IpAddressModel addressModel = IpAddressModel.fromJson(responseData);
          var addresses = await placemarkFromCoordinates(
              addressModel.lat, addressModel.lon);
          var first = addresses.first;
          setPlaceMark(first);

          var lat = addressModel.lat;
          var lng = addressModel.lon;
          print(lat);
          print(lng);
          LatLng latLng = LatLng(lat, lng);
          setLatLng(lat, lng);
          setMapLatLng(latLng);
          return latLng;
        }
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }

  // function to search loction
  Future getSearchData(double lat, double lng) async {
    try {
      String url = Paths.baseUrl +
          Paths.pathUrl +
          Paths.lat +
          lat.toString() +
          Paths.lon +
          lng.toString() +
          Paths.units +
          Paths.exclude +
          Paths.completeApi +
          Paths.apikey;
      print(url);
      Response response = await get(
        Uri.parse(url),
        // headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        //log('response: $responseData');
        WeatherData data = WeatherData.fromJson(responseData);
        setSearchData(data);
        print(data.toJson());
        var result = {
          'status': true,
          'message': 'Weather data fetched',
        };
        print(result);
        return result;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        log('response: $responseData');
        var result = {
          'status': false,
          'message': 'No Data fetched',
        };
        print(result);
        return result;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
