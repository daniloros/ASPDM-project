import 'package:flutter/material.dart';
import 'package:healty/model/diet.dart';

class DietDetails extends StatelessWidget {
  final Diet dietDetails;

  const DietDetails(this.dietDetails);

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: isLandscape ? null : AppBar(
        title: const Text("Dieta"),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Table(
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Image.asset(
                                      "assets/images/carbohydrates.png"),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 50, left: 20),
                                  child: Text(dietDetails.carbo!,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${dietDetails.carboGr!.toString()} gr",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Image.asset(
                                      "assets/images/proteins_photo.png"),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 50, left: 20),
                                  child: Text(dietDetails.protein!,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${dietDetails.proteinGr.toString()} gr",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Image.asset("assets/images/vegetable.png"),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 50, left: 20),
                                  child: Text(dietDetails.vegetable!,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      "${dietDetails.vegetableGr.toString()} gr",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Image.asset("assets/images/lipids.png"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(dietDetails.lipids!,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${dietDetails.lipidsGr.toString()} gr",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans',
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
