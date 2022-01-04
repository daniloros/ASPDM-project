import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/widgets/diet_dinner_widget.dart';
import 'package:provider/provider.dart';

class DinnerDietPage extends StatefulWidget{
  @override
  State<DinnerDietPage> createState() => _DinnerDietPageState();
}

class _DinnerDietPageState extends State<DinnerDietPage> {

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<DietPageController>().loadDietDinner();
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            DietDinnerWidget(),
            Center(
              child: Selector<DietPageController, bool>(
                selector: (context, state) => state.isLoading,
                builder: (context, isLoading, _) {
                  if (isLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            )
          ],
        ));
  }
}