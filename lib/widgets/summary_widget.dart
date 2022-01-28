import 'package:flutter/material.dart';
import 'package:healty/controller/login_controller.dart';
import 'package:healty/model/user.dart';
import 'package:provider/provider.dart';

import 'package:vector_math/vector_math_64.dart' as math;

import 'follow_up.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    if(isLandscape) {
      height = MediaQuery.of(context).size.height * 0.4 ;
      width = MediaQuery.of(context).size.width * 0.6;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Selector<LoginController, User?>(
              selector: (context, model) => model.currentUser,
              builder: (context, value, _) {
                debugPrint("Building Selector con ListView");
                if (value == null) {
                  return Center(
                    child: Selector<LoginController, bool>(
                      selector: (context, state) => state.isLoading,
                      builder: (context, isLoading, _) {
                        if (isLoading) {
                          return const CircularProgressIndicator();
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  );
                } else {
                  return Builder(builder: (context) {
                    final item = context.read<LoginController>().currentUser;
                    return item == null
                        ? const SizedBox()
                        : Row(
                          children: [
                            Expanded(
                              child: Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      top: 50, left: 32, right: 16, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: isLandscape ? null : Text(
                                          "Ciao, ${item.username}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, fontSize: 18),
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
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  _DietProgress(
                                                    ingredient: "Massa Magra",
                                                    progress: item.leanMass! / 100,
                                                    progressColor: Colors.green,
                                                    leftAmount: item.leanMass!.toInt(),
                                                    width: width * 0.28,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(top: 15),
                                                    child: Text("${item.leanMass!} kg"),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  _DietProgress(
                                                    ingredient: "Massa Grassa",
                                                    progress: item.bodyFat! / 100,
                                                    progressColor: Colors.red,
                                                    leftAmount: item.bodyFat!.toInt(),
                                                    width: width * 0.28,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(top: 15),
                                                    child: Text(
                                                        "${((item.bodyFat! * item.weight!) / 100).toStringAsPrecision(2)} kg"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      isLandscape ? SizedBox() : ListTile(
                                        subtitle: Text(
                                          "clicca qui per vedere i dettagli del tuo ultimo check",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onTap: () {
                                          Dialog alert = Dialog(
                                            // title: const Text("La tua condizione fisica"),
                                            child: FollowUp(item)
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
                                  ),
                                ),
                            ),
                            !isLandscape ? SizedBox() :
                            Container(
                              color: Colors.white,
                               child: Row(
                                children: [
                                  FollowUp(item),
                                ],
                              ),
                            )
                          ],

                        );
                  });
                }
              }),
        ),
      ],
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
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    text: user!.weight.toString(),
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF200087))),
                const TextSpan(text: "\n"),
                const TextSpan(
                    text: "KG",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF200087))),
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

    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(65), math.radians(360 - (user!.leanMass!)), false, paint3);

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
          style: const TextStyle(
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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: width! * progress!,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            // Text("${leftAmount} g left")
          ],
        )
      ],
    );
  }
}
