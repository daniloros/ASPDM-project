import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/widgets/diet_lunch_widget.dart';
import 'package:provider/provider.dart';

class LunchDietPage extends StatefulWidget {
  const LunchDietPage({Key? key}) : super(key: key);

  @override
  State<LunchDietPage> createState() => _LunchDietPage();
}

class _LunchDietPage extends State<LunchDietPage> {



  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<DietPageController>().loadDietLunch(context.read<User>().username);
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
            DietLunchWidget(),
          ],
        ));
  }
}
