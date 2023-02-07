import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/provider/counter.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  void _decrementCounter() {
    //Provider.of<Counterr>(context, listen: false).decrementCounter();
    // Shorter syntex
    context.read<Counterr>().decrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    //final data = Provider.of<String>(context);
    //final data = context.watch<Counterr>().counter;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<Counterr>(builder: (context, counterr, child) {
            return Text("${counterr.counter}");
          }),
          ElevatedButton(
              onPressed: () {
                _decrementCounter();
              },
              child: Text("Decrement"))
        ],
      ),
    );
  }
}
