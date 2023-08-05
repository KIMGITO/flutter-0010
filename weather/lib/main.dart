import 'package:flutter/material.dart';
import 'package:weather/body_page.dart';

void main() {
  runApp(Weather());
}

class Weather extends StatelessWidget {
  const Weather({super.key});
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
          appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 56, 54, 54),
        centerTitle: true,
      )),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
          title:const Text("Weather App"),
        ),
        body: WeatherPage(),
      ),
    ));
  }
}
