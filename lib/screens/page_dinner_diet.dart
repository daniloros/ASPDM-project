import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/widgets/diet_dinner_widget.dart';
import 'package:provider/provider.dart';

class DinnerDietPage extends StatefulWidget{
  const DinnerDietPage({Key? key}) : super(key: key);

  @override
  State<DinnerDietPage> createState() => _DinnerDietPageState();
}

class _DinnerDietPageState extends State<DinnerDietPage> {

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<DietPageController>().loadDietDinner(context.read<User>().username);
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $runtimeType');
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            DietDinnerWidget(),
          ],
        ));
  }
}