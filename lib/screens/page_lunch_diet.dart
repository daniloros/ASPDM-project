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
      context
          .read<DietPageController>()
          .loadDietLunch(context
          .read<AdminController>()
          .userDetails!
          .username, true);
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
          ? AppBar(title: const Text('Pranzo'))
          : null,
      floatingActionButton: context
          .read<User>()
          .username == "Admin"
          ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context) => const AddNewLunchDiet()))
              .then((userDetails) => _fetchDiet());
        },
      )
          : Container(),
      body: Stack(
          fit: StackFit.expand,
          children: [
          const DietLunchWidget(),
      context
          .read<User>()
          .username == "Admin"
          ? Center(
        child: Selector<DietPageController, bool>(
          selector: (context, state) => state.isLoading,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: CircularProgressIndicator()),
              );
              //return const CircularProgressIndicator();
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
