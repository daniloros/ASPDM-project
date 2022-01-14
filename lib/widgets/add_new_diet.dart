import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/diet.dart';
import 'package:healty/providers/admin_provider.dart';
import 'package:provider/src/provider.dart';

class AddNewDiet extends StatefulWidget{

  @override
  State<AddNewDiet> createState() => _AddNewDietState();
}

class _AddNewDietState extends State<AddNewDiet> {

  late TextEditingController controllerProteinType, controllerCarboType ,controllerVegetableType, controllerFatType;
  late TextEditingController controllerProteinGr, controllerCarboGr ,controllerVegetablGr, controllerFatGr;

  var response;

  Diet? currentDiet;

  @override
  void initState() {
    super.initState();
    controllerProteinType = TextEditingController(text: "");
    controllerCarboType = TextEditingController(text: "");
    controllerVegetableType = TextEditingController(text: "");
    controllerFatType = TextEditingController(text: "");
    controllerProteinGr = TextEditingController(text: "");
    controllerCarboGr = TextEditingController(text: "");
    controllerVegetablGr = TextEditingController(text: "");
    controllerFatGr = TextEditingController(text: "");
  }

  @override
  void dispose(){
    super.dispose();
    controllerProteinType.dispose();
    controllerCarboType.dispose();
    controllerVegetableType.dispose();
    controllerFatType.dispose();
    controllerProteinGr.dispose();
    controllerCarboGr.dispose();
    controllerVegetablGr.dispose();
    controllerFatGr.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diet Details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controllerCarboType,
                        decoration: InputDecoration(
                            hintText: "Carbo type",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controllerCarboGr,
                        decoration: InputDecoration(
                          hintText: "Carbo gr",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controllerProteinType,
                        decoration: InputDecoration(
                          hintText: "Protein type",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controllerProteinGr,
                        decoration: InputDecoration(
                          hintText: "Protein gr",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controllerVegetableType,
                        decoration: InputDecoration(
                          hintText: "Vegetable type",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controllerVegetablGr,
                        decoration: InputDecoration(
                          hintText: "Vegetable Gr",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controllerFatType,
                        decoration: InputDecoration(
                          hintText: "Lipids type",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controllerFatGr,
                        decoration: InputDecoration(
                          hintText: "Lipds Gr",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ElevatedButton(
                child: Text('Done'),
                onPressed: () async {

                  debugPrint("Press");

                  int? carboGr = int.tryParse(controllerCarboGr.text);
                  int? proteinGr = int.tryParse(controllerProteinGr.text);
                  int? lipidsGr = int.tryParse(controllerFatGr.text);
                  int? vegetableGr = int.tryParse(controllerVegetablGr.text);

                  currentDiet = context.read<DietPageController>().currentLunchDiet;
                  debugPrint(currentDiet.toString());
                  // debugPrint(context.read<DietPageController>().currentLunchDiet!.id.toString());

                  if(currentDiet != null){
                    debugPrint("Archiviamo la dieta");
                    var userId = currentDiet!.userId;
                    response = await AdminProvider.archiveLunchDiet(currentDiet!.id!);

                    if(response){
                      var newDiet = Diet(vegetableGr: vegetableGr, vegetable: controllerVegetableType.text, userId: userId, proteinGr: proteinGr, protein: controllerProteinType.text, lipidsGr: lipidsGr, lipids: controllerFatType.text, isCurrent: true, carboGr: carboGr, carbo: controllerCarboType.text);
                      response = await AdminProvider.addNewLunchDiet(newDiet);
                      debugPrint(response.toString());
                    }
                  } else {
                    debugPrint("Else situation");
                    var userId = context.read<AdminController>().userDetails!.username;
                    var newDiet = Diet(vegetableGr: vegetableGr, vegetable: controllerVegetableType.text, userId: userId, proteinGr: proteinGr, protein: controllerProteinType.text, lipidsGr: lipidsGr, lipids: controllerFatType.text, isCurrent: true, carboGr: carboGr, carbo: controllerCarboType.text);

                   response = await AdminProvider.addNewLunchDiet(newDiet);
                    debugPrint(response.toString());
                  }

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}