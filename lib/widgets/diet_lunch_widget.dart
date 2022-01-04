import 'package:flutter/material.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/screens/page_diet_lunch_details.dart';
import 'package:provider/provider.dart';

import 'diet_lunch_list_widget.dart';

class DietLunchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Selector<DietPageController, int>(
            selector: (context, model) => model.countLunch,
            builder: (context, value, _) {
              debugPrint("Building Selector con ListView");

              return ListView.builder(
                  itemCount: value,
                  itemBuilder: (context, index) {
                    final item =
                        context.read<DietPageController>().dietLunchList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DietLunchDetails(item)));
                      },
                      child: DietLunchItemDisplayer(item),
                    );
                  });
            },
          ))
        ],
      ),
    );
  }
}
