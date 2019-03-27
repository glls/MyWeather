import 'package:flutter/material.dart';
import 'package:my_weather_app/api/MapApi.dart';
import 'package:my_weather_app/model/WeatherData.dart';
import 'package:my_weather_app/ui/Weather.dart';
import 'package:location/location.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherData _weatherData;
  LocationData _currentLocation;

  @override
  void initState() {
    super.initState();

    getCurrentLocation();
  }

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    return new Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: _weatherData != null
          ? Weather(weatherData: _weatherData)
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
    );
  }

  getCurrentLocation() async {

    // copy implementation from
    // https://github.com/Lyokone/flutterlocation/blob/master/example/lib/main.dart

    loadWeather(lat: 40.71, lon: -74.01);
  }

  loadWeather({double lat, double lon}) async {
    MapApi mapApi = MapApi.getInstance();
    final data = await mapApi.getWeather(lat: lat, lon: lon);
    setState(() {
      this._weatherData = data;
    });
  }
}
