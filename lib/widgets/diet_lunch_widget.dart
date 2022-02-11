import 'package:flutter/material.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/diet.dart';
import 'package:provider/provider.dart';

import 'diet_details.dart';
import 'diet_list_widget.dart';

class DietLunchWidget extends StatelessWidget {
  const DietLunchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Selector<DietPageController, Diet?>(
        selector: (context, model) => model.currentLunchDiet,
        builder: (context, value, _) {
          if (value == null) {
            return SizedBox(child: Image.asset("assets/images/attention_logo.png"),);
          }else if (isLandscape) {
            return DietDetails(
                context.read<DietPageController>().currentLunchDiet!);
          } else {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Builder(builder: (context) {
                      var item = context
                          .read<DietPageController>()
                          .currentLunchDiet;

                      if (item!.id == null) {
                          return const Text("Non ci sono diete caricate");
                        } else {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DietDetails(item)));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 5, bottom: 10),
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
                                          "assets/images/current_diet.png",
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          Text(
                                                    "Ciao, ${item.userId}",
                                                    style:
                                                        Theme.of(context).textTheme.headline5,
                                                  ),
                                                  Text(
                                                    "Clicca per visualizzare la tua dieta corrente",
                                                    style:
                                                        Theme.of(context).textTheme.bodyText2,
                                                  ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                            );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(bottom: 5, left: 8, right: 16),
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
                      if (value == 0) {
                        return SizedBox(child: Image.asset("assets/images/not_archived_logo.png"),);
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value,
                            itemBuilder: (context, index) {
                              final item = context
                                  .read<DietPageController>()
                                  .dietLunchList[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DietDetails(item)));
                                },
                                child: DietItemDisplayer(item),
                              );
                            });
                      }
                    },
                  ))
                ],
              ),
            );
          }
        });
  }
}
