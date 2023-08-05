import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

//Weather forecast cards
  Widget forecastCards(String time, IconData icon, String temp) {
    return (Card(
      elevation: 8,
      child: SizedBox(
        width: 100,
        child: Padding(
          padding:const EdgeInsets.all(7),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 18),
              ),
              Icon(
                icon,
                size: 30,
                color: Colors.grey[300],
              ),
              Text(
                temp,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ),
      ),
    ));
  }

// Weather status flame widget
  Widget statusFlame() {
    return SizedBox(
      width: double.infinity,
      child: (Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: [
                  Text(
                    "340.63° F",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.cloud,
                      size: 58,
                    ),
                  ),
                  Text(
                    "Clear",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

//focus flame widget
  Widget forecustFlame() {
    return (SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(children: [
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Weather Forecast",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  wordSpacing: 8,
                ),
              ),
            ),
          ]),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                forecastCards("9:20", Icons.cloud, "120° F"),
                forecastCards("9:20", Icons.cloud, "120° F"),
                forecastCards("9:20", Icons.cloud, "120° F"),
                forecastCards("9:20", Icons.cloud, "120° F"),
                forecastCards("9:20", Icons.cloud, "120° F"),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          statusFlame(),
          forecustFlame(),
        ],
      ),
    ));
  }
}
