import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/diet.dart';
import 'package:healty/providers/admin_provider.dart';
import 'package:provider/src/provider.dart';

class AddNewDinnerDiet extends StatefulWidget {
  @override
  State<AddNewDinnerDiet> createState() => _AddNewDinnerDietState();
}

class _AddNewDinnerDietState extends State<AddNewDinnerDiet> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController controllerProteinType,
      controllerCarboType,
      controllerVegetableType,
      controllerFatType;
  late TextEditingController controllerProteinGr,
      controllerCarboGr,
      controllerVegetablGr,
      controllerFatGr;

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
  void dispose() {
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: controllerCarboType,
                          decoration: const InputDecoration(
                              labelText: "Carbo type",
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this field is required";
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: controllerCarboGr,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              labelText: "Carbo gr",
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this field is required";
                            }
                          },
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
                        child: TextFormField(
                          controller: controllerProteinType,
                          decoration: const InputDecoration(
                              labelText: "Protein type",
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this field is required";
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: controllerProteinGr,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              labelText: "Protein gr",
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this field is required";
                            }
                          },
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
                        child: TextFormField(
                          controller: controllerVegetableType,
                          decoration: const InputDecoration(
                              labelText: "Vegetable type",
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this field is required";
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: controllerVegetablGr,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              labelText: "Vegetable Gr",
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this field is required";
                            }
                          },
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
                        child: TextFormField(
                          controller: controllerFatType,
                          decoration: const InputDecoration(
                              labelText: "Lipids type",
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this field is required";
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: controllerFatGr,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              labelText: "Lipds Gr",
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this field is required";
                            }
                          },
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

                    currentDiet =
                        context.read<DietPageController>().currentDinnerDiet;
                    debugPrint(currentDiet.toString());

                    if (_formKey.currentState!.validate()) {
                      if (currentDiet != null) {
                        debugPrint("Archiviamo la dieta");
                        var userId = currentDiet!.userId;
                        response = await AdminProvider.archiveDinnerDiet(
                            currentDiet!.id!);

                        if (response) {
                          var newDiet = Diet(
                              vegetableGr: vegetableGr,
                              vegetable: controllerVegetableType.text,
                              userId: userId,
                              proteinGr: proteinGr,
                              protein: controllerProteinType.text,
                              lipidsGr: lipidsGr,
                              lipids: controllerFatType.text,
                              isCurrent: true,
                              carboGr: carboGr,
                              carbo: controllerCarboType.text);
                          response =
                              await AdminProvider.addNewDinnerDiet(newDiet);
                          debugPrint(response.toString());
                        }
                      } else {
                        debugPrint("Else situation");
                        var userId = context
                            .read<AdminController>()
                            .userDetails!
                            .username;
                        var newDiet = Diet(
                            vegetableGr: vegetableGr,
                            vegetable: controllerVegetableType.text,
                            userId: userId,
                            proteinGr: proteinGr,
                            protein: controllerProteinType.text,
                            lipidsGr: lipidsGr,
                            lipids: controllerFatType.text,
                            isCurrent: true,
                            carboGr: carboGr,
                            carbo: controllerCarboType.text);

                        response =
                            await AdminProvider.addNewDinnerDiet(newDiet);
                        debugPrint(response.toString());
                      }

                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
