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

    var typeUser = context
        .read<User>()
        .username;

    if (typeUser != "Admin") {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        debugPrint("Call loadDietLunch ${context
            .read<User>()
            .username}");
        context
            .read<DietPageController>()
            .loadDietLunch(context
            .read<User>()
            .username);
      });
    } else {
      _fetchDiet();
    }
  }

  _fetchDiet() async {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      debugPrint(
          "Call loadDietLunch for Admin ${context
              .read<AdminController>()
              .userDetails!
              .username}");
      context
          .read<DietPageController>()
          .loadDietLunch(context
          .read<AdminController>()
          .userDetails!
          .username);
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
      appBar: context
          .read<User>()
          .username == "Admin"
          ? AppBar(title: Text('Pranzo'))
          : null,
      floatingActionButton: context
          .read<User>()
          .username == "Admin"
          ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          debugPrint("Hai Cliccato il floating button");
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context) => AddNewLunchDiet()))
              .then((userDetails) => _fetchDiet());
        },
      )
          : Container(),
      body: Stack(
          fit: StackFit.expand,
          children: [
          DietLunchWidget(),
      context
          .read<User>()
          .username == "Admin"
          ? Center(
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
          : SizedBox(),
      ],
    ));
  }
}
