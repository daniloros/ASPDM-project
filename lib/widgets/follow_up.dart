import 'package:flutter/material.dart';
import 'package:healty/model/user.dart';

class FollowUp extends StatelessWidget{

  User item;


  FollowUp(this.item);

  @override
  Widget build(BuildContext context) {

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

   return Stack(
     children: [
       Container(
         padding: const EdgeInsets.all(20),
         decoration: isLandscape ? null : BoxDecoration(
             shape: BoxShape.rectangle,
             color: Colors.white,
             borderRadius:
             BorderRadius.circular(5),
             boxShadow: const [
               BoxShadow(
                   color: Colors.black,
                   offset: Offset(0, 10),
                   blurRadius: 10),
             ]),
         child: Padding(
           padding: isLandscape ? EdgeInsets.only(top: 30.0, right: 30.0) : EdgeInsets.all(10),
           child: Column(
             mainAxisSize: isLandscape ? MainAxisSize.max : MainAxisSize.min,
             crossAxisAlignment: isLandscape ? CrossAxisAlignment.center :CrossAxisAlignment.start,
             children: [
               Text("Peso: ${item.weight} kg",
                   style: const TextStyle(
                       fontSize: 18,
                       fontWeight:
                       FontWeight.w600)),
               const SizedBox(
                 height: 15,
               ),
               Text("BMR: ${item.bmr} kcal",
                   style: const TextStyle(
                       fontSize: 18,
                       fontWeight:
                       FontWeight.w600)),
               const SizedBox(
                 height: 15,
               ),
               Text("Idratazione: ${item.hydro} %",
                   style: const TextStyle(
                       fontSize: 18,
                       fontWeight:
                       FontWeight.w600)),
               const SizedBox(
                 height: 15,
               ),
               Text("Massa Grassa: ${item.bodyFat} %",
                   style: const TextStyle(
                       fontSize: 18,
                       fontWeight:
                       FontWeight.w600)),
               const SizedBox(
                 height: 15,
               ),
               Text(
                   "Massa Magra: ${item.leanMass} kg",
                   style: const TextStyle(
                       fontSize: 18,
                       fontWeight:
                       FontWeight.w600)),
               const SizedBox(
                 height: 15,
               ),
               isLandscape ? SizedBox() : Align(
                 alignment: Alignment.center,
                 child: ElevatedButton(
                     onPressed: () {
                       Navigator.of(context).pop();
                     },
                     child: const Text(
                       "Chiudi",
                       style:
                       TextStyle(fontSize: 18),
                     )),
               ),
             ],
           ),
         ),
       ),
     ],
   );
  }

}