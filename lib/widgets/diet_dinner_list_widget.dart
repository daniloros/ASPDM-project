import 'package:flutter/material.dart';
import 'package:healty/model/diet_dinner.dart';

class DietDinnerItemDisplayer extends StatelessWidget {
  final DietDinner item;

  DietDinnerItemDisplayer(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 10),
      child: Material(
        borderRadius: BorderRadius.all(const Radius.circular(20)),
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
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(item.userId),
                    Text(item.protein),
                  ]

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
