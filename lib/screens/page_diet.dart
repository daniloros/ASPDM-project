import 'package:flutter/material.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/screens/page_dinner_diet.dart';
import 'package:healty/screens/page_lunch_diet.dart';
import 'package:provider/provider.dart';


class DietPage extends StatefulWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage>
    with SingleTickerProviderStateMixin {

  late TabController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $runtimeType');
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBar(
            bottom: TabBar(
              tabs: const [
                Tab(
                  text: "Pranzo",
                ),
                Tab(
                  text: "Cena",
                ),
              ],
              controller: _ctrl,
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            TabBarView(
                controller: _ctrl,
                children: [
                  LunchDietPage(),
                  DinnerDietPage(),
                ],
            ),
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
