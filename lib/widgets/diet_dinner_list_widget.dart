import 'package:flutter/material.dart';
import 'package:healty/model/diet_dinner.dart';

class DietDinnerItemDisplayer extends StatelessWidget {
  final DietDinner item;

  DietDinnerItemDisplayer(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(96, 110, 110, 120),
                blurRadius: 6,
                offset: Offset(4, 4),
              )
            ],
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/diet-dinner-photo.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    item.id.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    item.userId,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}
