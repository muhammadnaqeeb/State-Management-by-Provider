import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final data = Provider.of<String>(context);
    final data = context.watch<String>();
    return Center(
      child: Container(
        child: Text("$data"),
      ),
    );
  }
}
