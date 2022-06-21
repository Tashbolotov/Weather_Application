import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_application/utils/weather_utils.dart';
import 'city_page.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({
    Key key,
  }) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _celcius = '';
  String _icons;
  String _description = '';
  String _cityName;
  @override
  void initState() {
    _showWeatherByLocation();

    super.initState();
  }

  Future<void> _showWeatherByLocation() async {
    final position = await _getCurrentLocation();
    await getWeatherByLocation(position: position);

    // log('Position.latitude ===> ${position.latitude}');
    // log('Position.logitude ===> ${position.longitude}');
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeatherByLocation({@required Position position}) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=8d7bc3fa4cb99363814ae57c0a04953d');
      //response ---> joop -->bul peremennyi -sakto uchun
      final response = await client.get(uri);
      // log('response ===> ${response}');
      // final body = response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;
        // log('API ===> $body');
        // data -- bul maymat saktap alyp jatat -->peremenyi
        final _data = jsonDecode(body) as Map<String, dynamic>;
        // log('Data ===>$_data');
        final _kelvin = _data['main']['temp'] as num;
        _cityName = _data['name'];
        // 0K − 273.15
        log('temp ==> $_celcius');
        log('_data ==> $_cityName');
        _celcius = WeatherUtils.kelvinToCelcius(_kelvin).toString();
        _description = WeatherUtils.getDescription(int.parse(_celcius));
        _icons = WeatherUtils.getWeatherIcon(_kelvin.toInt());
      }

      // if{response.body}
      // log('API ===> ${response}');

    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Icon(
          Icons.navigation,
          size: 60,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => CityPage()),
                  ),
                );
              },
              icon: const Icon(
                Icons.location_city,
                size: 60,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/weather.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _celcius.isEmpty
                  ? "$_celcius\u00B0 🌦"
                  : '$_celcius\u00B0 $_icons',
              style: TextStyle(
                fontSize: 100,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                _description,
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 150),
              child: Text(
                _cityName ?? 'Shardyn Aty kelish kerek',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
