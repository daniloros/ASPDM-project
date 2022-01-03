import 'package:flutter/material.dart';

class Summary extends StatelessWidget{
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $runtimeType');
    return Scaffold(
      body: SafeArea(
        child: Center (
          child: Column(
            children: const [
              Text("Summary"),
            ],
          ),
        )
      )
    );
  }

}