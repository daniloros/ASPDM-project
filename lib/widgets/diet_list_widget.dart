import 'package:flutter/material.dart';
import 'package:healty/model/diet.dart';

class DietItemDisplayer extends StatelessWidget {
  final Diet item;

  const DietItemDisplayer(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 10),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image.asset(
                "assets/images/diet-dinner-photo.jpg",
                width: 150,
                //fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Clicca per vedere"),
                  Text("la tua vecchia dieta"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),

      ),
    );
  }
}
