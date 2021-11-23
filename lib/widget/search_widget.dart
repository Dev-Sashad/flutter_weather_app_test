import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/constant/helpers.dart';
import 'package:weather_app/constant/locator.dart';
import 'package:weather_app/constant/sizeconfig.dart';
import 'package:weather_app/constant/urls.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/views/search_view.dart';

class SearchTextField extends StatefulWidget {
  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  WeatherService _weatherService = locator<WeatherService>();
  final textController = TextEditingController();
  GeoFirePoint geoLocation;
  Geoflutterfire geo = Geoflutterfire();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Paths.place_apikey);
  double lat;
  double lng;

  search(BuildContext context) async {
    if (textController.text.trim().isEmpty || lat == null || lng == null) {
      Flushbar(
        title: "Oops!",
        flushbarPosition: FlushbarPosition.BOTTOM,
        message: "location not found",
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white38,
      ).show(context);
      return null;
    } else {
      _weatherService.setBusy(true);
      setState(() {});
      var connectivityResult = await Connectivity().checkConnectivity();
      var isConnected = connectivityResult != ConnectivityResult.none;
      try {
        if (!isConnected) {
          _weatherService.setBusy(false);
          setState(() {});
          showToast('No internet Connection. pls check!');
        } else {
          var addresses = await placemarkFromCoordinates(lat, lng);
          var first = addresses.first;
          _weatherService.setSPlaceMark(first);
          final data = await _weatherService.getSearchData(lat, lng);
          var annn = data['status'];
          if (annn == true) {
            Current current = _weatherService.searchData.current;
            LatLng _latLng = LatLng(lat, lng);
            _weatherService.setBusy(false);
            setState(() {
              FocusScope.of(context).unfocus();
              textController.clear();
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationView(
                          current: current,
                          currentLatLng: _latLng,
                        )));
          } else {
            _weatherService.setBusy(false);
            setState(() {});
            showToast('unable to fetch infomation. try again');
          }
        }
      } catch (e) {
        print(e);
        _weatherService.setBusy(false);
        setState(() {});
        showToast('an Error Occured. Check internet connection');
      }
    }
  }

  displayPredict(Prediction p, BuildContext context) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      setState(() {
        lat = detail.result.geometry.location.lat;
        lng = detail.result.geometry.location.lng;
        textController.text = detail.result.formattedAddress;
      });
      geoLocation = geo.point(latitude: lat, longitude: lng);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _showmap = _weatherService.showmap;
    return Container(
        height: 45,
        width: kwidth(90, context),
        decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
            border: Border.all(color: _showmap ? primaryColor : Colors.white10),
            boxShadow: [BoxShadow(blurRadius: 4, color: Colors.white10)]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: kwidth(70, context),
                child: TextFormField(
                  //textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.streetAddress,
                  controller: textController,
                  onTap: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      currentFocus.focusedChild.unfocus();
                    }
                    Prediction p = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: Paths.place_apikey,
                      mode: Mode.overlay,
                      logo: Row(
                        children: [],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      language: "en",
                      components: [
                        new Component(
                          Component.country,
                          "Ng",
                        ),
                      ],
                    );
                    displayPredict(p, context);
                  },
                  style: TextStyle(
                      color: _showmap ? primaryColor : Colors.white,
                      fontSize: 14),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 20),
                    hintText: 'search location',
                    hintStyle: TextStyle(
                        color: _showmap ? primaryColor : Colors.white,
                        fontSize: 14),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.search,
                      size: 20, color: _showmap ? primaryColor : Colors.white),
                  onPressed: () => search(context))
            ]));
  }
}
