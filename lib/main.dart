import 'package:flutter/material.dart';
import 'package:ilzo_hackaton/choicePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
                offset: const Offset(0, 5),
                blurRadius: 6,
                color: Colors.black.withAlpha(50)),
          ],
        ),
        titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        labelLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        labelMedium: const TextStyle(fontSize: 15),
        headlineLarge: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      )),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

TextTheme tt(BuildContext context) => Theme.of(context).textTheme;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: const Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "당신이 모르는 인생 여행지",
                  style: tt(context).titleMedium,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChoicePage()));
                },
                child: Text(
                  "찾으러가기",
                  style: tt(context).titleLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
