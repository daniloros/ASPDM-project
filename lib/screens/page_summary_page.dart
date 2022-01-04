import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $runtimeType');
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        body: SafeArea(
            child: Center(
          child: Column(
            children: const [
              Text("Summary"),
            ],
          ),
        )));
  }
}
