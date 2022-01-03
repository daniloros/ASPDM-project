import 'package:flutter/material.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/diet_lunch.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class DietPage extends StatefulWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  late List<DietLunch> dietLunchList;

  @override
  void initState() {
    super.initState();
    dietLunchList = DietPageController().dietLunchList;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $runtimeType');
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Fetch Data Example'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<DietPageController>().loadDietLunch();
                },
                icon: const Icon(Icons.arrow_downward),
                tooltip: "Load",
              ),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Selector<DietPageController, int>(
                      selector: (context, model) => model.count,
                      builder: (context, value, _) {
                        debugPrint("Building Selector con ListView");

                        return ListView.builder(
                            itemCount: value,
                            itemBuilder: (context, index) {
                              final item = context
                                  .read<DietPageController>()
                                  .dietLunchList[index];
                              return Text("Diet ${item.id}");
                            });
                      },
                    ))
                  ],
                ),
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
          )),
    );
  }
}
