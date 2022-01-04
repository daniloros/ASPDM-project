import 'package:flutter/material.dart';

class AddNewDiet extends StatelessWidget {
  const AddNewDiet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $runtimeType');
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        appBar: AppBar(
          title: const Text('Aggiungi una nuova Dieta'),
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            children: const [
              Text("Aggiungi "),
            ],
          ),
        )));
  }
}
