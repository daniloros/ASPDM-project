import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/login_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/widgets/summary_widget.dart';
import 'package:provider/src/provider.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<LoginController>().loadCurrentUser(context.read<User>().username);
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
        backgroundColor: const Color(0xFFE9E9E9),
        body: SafeArea(
            child: Center(
          child: Column(
            children: const [
              SummaryWidget(),
            ],
          ),
        )));
  }
}
