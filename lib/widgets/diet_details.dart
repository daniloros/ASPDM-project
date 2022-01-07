import 'package:flutter/material.dart';
import 'package:healty/model/diet.dart';

class DietDetails extends StatelessWidget {
  final Diet dietDetails;

  DietDetails(this.dietDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diet ${dietDetails.id} Details"),
      ),
      body: Container(
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
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                            child: Table(
                              //border: TableBorder.all(color: Colors.black),
                              children: [
                                TableRow(
                                    children: [
                                  Column(
                                    children: [
                                      Image.asset("assets/images/carboidrati_image.png"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(dietDetails.carbo,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w900,
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Open Sans',
                                              fontSize: 20) ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("${dietDetails.carboGr.toString()} gr" ,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w900,
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Open Sans',
                                              fontSize: 20) ),
                                    ],
                                  ),
                                ]),
                                TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset("assets/images/carboidrati_image.png"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(dietDetails.protein,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 20) ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("${dietDetails.proteinGr.toString()} gr" ,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 20) ),
                                        ],
                                      ),
                                    ]),
                                TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset("assets/images/carboidrati_image.png"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(dietDetails.vegetable,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 20) ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("${dietDetails.vegetableGr.toString()} gr" ,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 20) ),
                                        ],
                                      ),
                                    ]),
                                TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset("assets/images/carboidrati_image.png"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(dietDetails.lipids,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 20) ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("${dietDetails.lipidsGr.toString()} gr" ,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 20) ),
                                        ],
                                      ),
                                    ]),
                              ],
                            ),
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.all(Radius.circular(5)),
                            //   border: Border.all(color: Colors.green, width: 2.0),
                            //   image: const DecorationImage(
                            //     alignment: Alignment.topLeft,
                            //     image: ExactAssetImage("assets/images/carboidrati_image.png"),
                            //   ),
                            // )
                        ),
                      ],
                    ),
                  ),),

            ],
          )),
    );
  }
}
