import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/widgets/add_new_lunch_diet.dart';
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

    var typeUser = context.read<User>().username;

    if (typeUser != "Admin") {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        debugPrint("Call loadDietLunch ${context.read<User>().username}");
        context
            .read<DietPageController>()
            .loadDietLunch(context.read<User>().username);
      });
    } else {
      _fetchDiet();
    }
  }

  _fetchDiet() async {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      debugPrint(
          "Call loadDietLunch for Admin ${context.read<AdminController>().userDetails!.username}");
      context
          .read<DietPageController>()
          .loadDietLunch(context.read<AdminController>().userDetails!.username);
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
        floatingActionButton: Builder(builder: (context) {
          debugPrint(context.read<User>().username);
          if (context.read<User>().username == "Admin") {
            return FloatingActionButton(
              child: const Icon(Icons.plus_one),
              onPressed: () async {
                debugPrint("Hai Cliccato il floating button");
                //await context.read<ToDoList>().add("Nuova cosa da fare");

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddNewLunchDiet())).then((userDetails) => _fetchDiet());
              },
            );
          } else
            return Container();
        }),
        body: Stack(
          fit: StackFit.expand,
          children: [
            DietLunchWidget(),
          ],
        ));
  }
}
