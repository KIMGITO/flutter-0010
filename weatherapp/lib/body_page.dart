import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weatherapp/secret.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
// Weather status flame widget
  String city = "NAIROBI";
  String messageNote = "Getting your data...";
  var date = DateFormat('dd/MM/yyyyy').format(DateTime.now());

  Widget statusFlame(temp, String sky, String description) {
    IconData icon = Icons.cloud;

    if (sky == "Rain") {
      icon = Icons.cloudy_snowing;
    } else if (sky == "Sun") {
      icon = Icons.sunny;
    } else {
      icon = Icons.cloud;
    }

    return SizedBox(
      width: double.infinity,
      height: 210,
      child: (Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          child: Text(
                            date,
                            style: const TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 10),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 4),
                          child: Center(
                            child: SizedBox(
                              width: 130,
                              child: Text(
                                "${(temp - 275.15).toStringAsFixed(2)}°C",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            onSubmitted: (value) {
                              String search = value == "" ? city : value;

                              setState(() {
                                city = search.toUpperCase();
                              });
                            },
                            cursorHeight: 10,
                            decoration: InputDecoration(
                              helperText: "Kenyan Towns",
                              helperStyle: const TextStyle(fontSize: 9),
                              isDense: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5),
                              hintText: " $city",
                              // prefixIcon: Icon(Icons.manage_search_rounded),
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 187, 187, 187),
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 0),
                      child: Icon(
                        icon,
                        size: 68,
                      ),
                    ),
                    Text(
                      sky,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 5, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              description,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w200),
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.only(bottom: 2),
                            onPressed: () {
                              setState(() {});
                            },
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

//Weather forecast cards
  Widget forecastCards(time, icon, temp) {
    if (icon == "Rain") {
      icon = Icons.cloudy_snowing;
    } else if (icon == "Sun") {
      icon = Icons.sunny;
    } else {
      icon = Icons.cloud;
    }

    return (Card(
      elevation: 8,
      child: SizedBox(
        width: 120,
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            children: [
              Text(
                "$time",
                style: const TextStyle(fontSize: 18),
              ),
              Icon(
                icon,
                size: 30,
                color: Colors.grey[300],
              ),
              Text(
                "${(temp - 275.15).toStringAsFixed(2)}°C",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget forecustFlame(Map forecastInfo) {
    return (Container(
      margin: const EdgeInsets.only(top: 22, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(top: 7, bottom: 10),
                child: Text(
                  "Weather Forecast",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    wordSpacing: 8,
                  ),
                ),
              ),
            ]),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  for (var i = 0; i < 5; i++)
                    forecastCards(forecastInfo[i]["time"],
                        forecastInfo[i]["sky"], forecastInfo[i]["temp"]),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

//additional Information flame widget
  Widget infoCards(IconData icon, atrribute, value, String? unit) {
    unit ?? " ";

    return (Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              atrribute,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            "$value $unit",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ));
  }

  Widget info(humidity, windSpeed, pressure) {
    return (Container(
      margin: const EdgeInsets.only(top: 26, bottom: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "More weather information",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          Container(
            margin: const EdgeInsets.only(top: 17),
            child: Row(
              children: [
                infoCards(Icons.water_drop, "Humidity", humidity, "%"),
                infoCards(Icons.cyclone, "Wind Speed", windSpeed, "Km/h"),
                infoCards(Icons.air, "Pressure", pressure, "hPa"),
              ],
            ),
          ),
        ],
      ),
    ));
  }

//fetch API data
  Future<Map<String, dynamic>> getData() async {
    city;
    messageNote;
    String apiKey = api;

    final forecast = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city,KE&APPID=$apiKey"),
    );

    final forecastData = jsonDecode(forecast.body);

    if (forecastData['cod'] != '200') {
      if (forecastData['cod'] == '404') {
        throw "Town not found";
      } else {
        throw "Connection error";
      }
    }
    Map<String, Map> data = {'forecastData': forecastData};
    messageNote = "Getting your data...";
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    messageNote,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 17),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          city = "NAIROBI";
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Error ${(snapshot.error.toString() == "Town not found" || snapshot.error.toString() == "Connection error") ? snapshot.error.toString() : " Occured"} !",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        city = "NAIROBI";
                        messageNote = "";
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Back"),
                  ),
                ),
              ],
            ),
          );
        } else {
          final data = snapshot.data;
          final currentWeather = data['forecastData']['list'][0];
          final currentTemp = currentWeather['main']['temp'];
          final String currentSky = currentWeather['weather'][0]['main'];
          final String currentDescription =
              currentWeather['weather'][0]['description'];

          final currentHumid = currentWeather['main']['humidity'];
          final currentPressure = currentWeather['main']['pressure'];
          final currentWindSpeed = currentWeather['wind']['speed'];

          //an array of the first 5 forecast
          Map<int, Map> forecastInfo = {};
          final dynamicWeather = data['forecastData']['list'];

          for (var i = 1; i < 6; i++) {
            var dateTime = DateTime.parse(dynamicWeather[i]['dt_txt']);
            var time = DateFormat.Hm().format(dateTime);

            Map<String, dynamic> forecastedData = {
              "temp": dynamicWeather[i]['main']['temp'],
              "sky": dynamicWeather[i]['weather'][0]['main'],
              "time": time
            };
            forecastInfo[i - 1] = forecastedData;
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  statusFlame(currentTemp, currentSky, currentDescription),
                  forecustFlame(forecastInfo),
                  info(currentHumid, currentWindSpeed, currentPressure)
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
