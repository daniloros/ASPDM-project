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
    var typeUser = context
        .read<User>()
        .username;

    if (typeUser != "Admin") {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        context
            .read<DietPageController>()
            .loadDietDinner(context
            .read<User>()
            .username);
      });
    } else {
      _fetchDiet();
    }
  }


  _fetchDiet() async {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<DietPageController>().loadDietDinner(
          context
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
          .username == "Admin" ? AppBar(title: const Text('Cena')) : null,
      floatingActionButton: context
          .read<User>()
          .username == "Admin" ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          debugPrint("Hai Cliccato il floating button");
          Navigator.of(context)
              .push(
              MaterialPageRoute(builder: (context) => AddNewDinnerDiet()))
              .then((userDetails) => _fetchDiet());
        },
      ) : Container(),
      body: Stack(
          fit: StackFit.expand,
          children: [
          const DietDinnerWidget(),
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
          : const SizedBox(),
      ],
    ));
  }
}
