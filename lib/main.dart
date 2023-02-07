import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/secondScreen.dart';

import 'provider/counter.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counterr(),
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _incrementCounter() {
    //Provider.of<Counterr>(context, listen: false).incrementCounter();
    // shorter syntax
    context.read<Counterr>().incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    //final data = context.watch<Counterr>().counter;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<Counterr>(builder: ((context, counterr, child) {
            return Text("${counterr.counter}");
          })),
          ElevatedButton(
              onPressed: () {
                _incrementCounter();
              },
              child: const Text("Increment")),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SecondScreen()));
            },
            child: Text("2nd Screen"),
          ),
        ],
      ),
    );
  }
}
