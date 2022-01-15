import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/widgets/add_new_dinner_diet.dart';
import 'package:healty/widgets/diet_dinner_widget.dart';
import 'package:provider/provider.dart';

class DinnerDietPage extends StatefulWidget {
  const DinnerDietPage({Key? key}) : super(key: key);

  @override
  State<DinnerDietPage> createState() => _DinnerDietPageState();
}

class _DinnerDietPageState extends State<DinnerDietPage> {
  @override
  void initState() {
    super.initState();
    var typeUser = context.read<User>().username;

    if (typeUser != "Admin") {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        context
            .read<DietPageController>()
            .loadDietDinner(context.read<User>().username);
      });
    } else {
      _fetchDiet();
    }
  }


  _fetchDiet() async {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      debugPrint(
          "Call loadDietLunch for Admin ${context.read<User>().username}");
      context.read<DietPageController>().loadDietDinner(
          context.read<AdminController>().userDetails!.username);
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
                    MaterialPageRoute(builder: (context) => AddNewDinnerDiet())).then((userDetails) => _fetchDiet());
              },
            );
          } else
            return Container();
        }),
        body: Stack(
          fit: StackFit.expand,
          children: [
            DietDinnerWidget(),
          ],
        ));
  }
}
