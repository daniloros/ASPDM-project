import 'package:flutter/material.dart';
import 'package:healty/controller/login_controller.dart';
import 'package:healty/model/user.dart';
import 'package:provider/provider.dart';

import 'package:vector_math/vector_math_64.dart' as math;


class SummaryWidget extends StatelessWidget {
  const SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 50, left: 32, right: 16, bottom: 10),
      child: Builder(builder: (context) {
        final item = context.read<LoginController>().currentUser;
        if (item == null) {
          return const SizedBox();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "Hello, ${item.username}",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                ),
                //trailing: ClipOval(child: Image.asset("inserisci url di photo")),
              ),
              Row(
                children: [
                  _RadialProgress(
                    width: width * 0.4,
                    height: height * 0.5,
                    progress: 0.7,
                    user: item,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _DietProgress(
                            ingredient: "Lean Mass",
                            progress: item.leanMass! / 100,
                            progressColor: Colors.green,
                            leftAmount: item.leanMass!.toInt(),
                            width: width * 0.28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text("${item.leanMass!} kg"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          _DietProgress(
                            ingredient: "Body Fat",
                            progress: item.bodyFat! / 100,
                            progressColor: Colors.red,
                            leftAmount: item.bodyFat!.toInt(),
                            width: width * 0.28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                                "${((item.bodyFat! * item.weight!) / 100).toStringAsPrecision(2)} kg"),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              ListTile(
                subtitle: Text(
                  "clicca qui per vedere i dettagli del tuo ultimo check",
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Dialog alert= Dialog(
                   // title: const Text("La tua condizione fisica"),
                    child: Stack(
                      children: [
                        Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(color: Colors.black,offset: Offset(0,10),
                                  blurRadius: 10
                              ),
                            ]
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Weight: ${item.weight} kg", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                            SizedBox(height: 15,),
                            Text("BMR: ${item.bmr} %", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                            SizedBox(height: 15,),
                            Text("Hydration: ${item.hydro} %", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                            SizedBox(height: 15,),
                            Text("Body Fat: ${item.bodyFat} %", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                            SizedBox(height: 15,),
                            Text("Lean Mass: ${item.leanMass} kg", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                            SizedBox(height: 15,),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Chiudi",style: TextStyle(fontSize: 18),)),
                            ),
                          ],
                        ),
                      ),
                      ],
                    ),

                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
              ),
            ],
          );
        }
      }),
    );
  }
}

class _RadialProgress extends StatelessWidget {
  final User? user;
  final double? height, width, progress;

  const _RadialProgress(
      {Key? key, this.user, this.height, this.width, this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(user: user),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "${user!.weight.toString()}",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF200087))),
                TextSpan(text: "\n"),
                TextSpan(
                    text: "KG",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF200087))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double? progress;
  final User? user;

  _RadialPainter({this.user, this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = const Color(0xFF200087)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint paint2 = Paint()
      ..strokeWidth = 11
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint paint3 = Paint()
      ..strokeWidth = 11
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360;
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(100), math.radians(relativeProgress), false, paint);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(50),
        math.radians(((user!.bodyFat! * user!.weight!) / 100)),
        false,
        paint2);

    debugPrint(((user!.bodyFat! * user!.weight!) / 100).toString());

    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(65), math.radians(360 - (user!.leanMass!)), false, paint3);

    debugPrint((user!.leanMass!).toString());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _DietProgress extends StatelessWidget {
  final String? ingredient;
  final int? leftAmount;
  final double? progress, width;
  final Color? progressColor;

  const _DietProgress(
      {Key? key,
      this.ingredient,
      this.leftAmount,
      this.progress,
      this.progressColor,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ingredient!.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: width! * progress!,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            // Text("${leftAmount} g left")
          ],
        )
      ],
    );
  }
}
