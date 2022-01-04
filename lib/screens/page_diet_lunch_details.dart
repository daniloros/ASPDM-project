import 'package:flutter/material.dart';
import 'package:healty/model/diet_lunch.dart';

class DietLunchDetails extends StatelessWidget {
  final DietLunch dietLunch;

  DietLunchDetails(this.dietLunch);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Diet ${dietLunch.id} Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(dietLunch.carbo, style: Theme.of(context).textTheme.bodyText2),
            Text(dietLunch.protein, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
      );
  }
}
