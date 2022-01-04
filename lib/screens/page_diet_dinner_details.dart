import 'package:flutter/material.dart';
import 'package:healty/model/diet_dinner.dart';


class DietDinnerDetails extends StatelessWidget {
  final DietDinner dietDinner;

  DietDinnerDetails(this.dietDinner);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Diet ${dietDinner.id} Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(dietDinner.carbo, style: Theme.of(context).textTheme.bodyText2),
            Text(dietDinner.protein, style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }
}
