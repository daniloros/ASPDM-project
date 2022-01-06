import 'package:flutter/material.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/diet_lunch.dart';
import 'package:healty/screens/page_diet_lunch_details.dart';
import 'package:provider/provider.dart';

import 'diet_lunch_list_widget.dart';

class DietLunchWidget extends StatelessWidget {
  const DietLunchWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Selector<DietPageController, DietLunch?>(
              selector: (context, model) => model.currentLunchDiet,
              builder: (context, value, _) {
                debugPrint("Building Selector con ListView");
                if (value == null) {
                  return const Text("Non ci sono diete caricate");
                } else {
                  return Builder(
                      builder: (context) {
                        final item = context
                            .read<DietPageController>()
                            .currentLunchDiet;
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DietLunchDetails(item!)));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Image.asset(
                                  "assets/images/diet-dinner-photo.jpg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                item!.id.toString(),
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                item.userId,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
          padding: const EdgeInsets.only(
              bottom: 5, left: 8, right: 16),
          child: const Text(
            "Archivio Diete",
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ),
          Expanded(
              child: Selector<DietPageController, int>(
                selector: (context, model) => model.countLunch,
                builder: (context, value, _) {
                  debugPrint("Building Selector con ListView");
                  if(value == 0){
                  return Text("Non ci sono diete Archiviate");
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value,
                        itemBuilder: (context, index) {
                          final item =
                          context
                              .read<DietPageController>()
                              .dietLunchList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DietLunchDetails(item)));
                            },
                            child: DietLunchItemDisplayer(item),
                          );
                        });
                  }
                },
              ))
        ],
      ),
    );
  }
}
