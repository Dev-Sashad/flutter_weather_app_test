import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/dialog_service.dart';
import 'package:weather_app/views/splashscreen.dart';

import 'constant/locator.dart';
import 'managers/dialog_manager.dart';

void main() {
  runApp(MyApp());
  setupLocator();
  //Force Portrait View
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (cxt) {
          return WeatherProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        builder: (context, child) => Navigator(
          key: locator<DialogService>().dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
            return DialogManager(child: child);
          }),
        ),
        theme: ThemeData(
          fontFamily: 'DM Sans',
          scaffoldBackgroundColor: primaryColor,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
