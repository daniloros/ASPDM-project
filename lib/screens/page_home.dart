import 'package:flutter/material.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/screens/page_diet.dart';
import 'package:healty/screens/page_summary_page.dart';
import 'package:provider/provider.dart';


class MyHomePage extends StatefulWidget {
  final String username;

  const MyHomePage(this.username, {Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  late String _title;

  final screens = [
    const Summary(),
    const DietPage(),
    // SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _title = "Benvenuto";
    //carichiamo i dati nel caso li avessimo
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
      appBar: (currentIndex == 1 || currentIndex == 2)
          ? null
          : AppBar(
              title: Text(_title),
            ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(color: Colors.blueAccent),
        unselectedIconTheme: const IconThemeData(
          color: Colors.black12,
        ),
        currentIndex: currentIndex,
        onTap: (index) {
          debugPrint("tab $index selected");
          setState(() {
            currentIndex = index;
            switch (index) {
              case 0:
                {
                  _title = "${widget.username} Benvenuto";
                }
                break;
              case 1:
                {
                  _title = "Dieta";
                }
                break;
              case 2:
                {
                  context.read<User>().logout();
                  context.read<DietPageController>().logout();
                }
                break;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Dieta",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Esci",
          ),
        ],
      ),
    );
  }
}

class DoingLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Attenzione'),
      content: Text("Sei sicuro di voler effettuare il Logout?"),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Si'),
          onPressed: () {
            context.read<User>().logout();
            context.read<DietPageController>().logout();
          },
        ),
        ElevatedButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
