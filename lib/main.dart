import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/secondScreen.dart';

void main() {
  runApp(
    Provider(
      create: ((context) => "8"),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SecondScreen()));
          },
          child: Text("2nd Screen"),
        ),
      ],
    );
  }
}
