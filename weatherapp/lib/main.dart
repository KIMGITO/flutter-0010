import 'package:flutter/material.dart';
import 'package:weatherapp/body_page.dart';

void main() {
  runApp(const Weather());
}

class Weather extends StatelessWidget {
  const Weather({super.key});
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
          appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 56, 54, 54),
        centerTitle: true,
      )),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Weather App"),
        ),
        body: const WeatherPage(),
        bottomSheet: const BottomAppBar(
          height: 50,
          child: Center(
            child: Text(
              "Developed by kim",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 17),
            ),
          ),
        ),
      ),
    ));
  }
}
