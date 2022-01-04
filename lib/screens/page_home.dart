import 'package:flutter/material.dart';
import 'package:healty/model/user.dart';
import 'package:healty/screens/page_diet.dart';
import 'package:healty/screens/page_summary_page.dart';
import 'package:provider/provider.dart';

import 'page_add_new_diet.dart';

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
    Summary(),
    DietPage(),
    AddNewDiet(),
  ];


  @override
  void initState() {
    super.initState();
    _title = "${widget.username} Benvenuto";
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
      appBar: (currentIndex == 1 || currentIndex == 2) ? null : AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            onPressed: () {
              context.read<User>().logout();
            },
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          )
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(
          color: Colors.blueAccent
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.black12,
        ),
        currentIndex: currentIndex,
        onTap: (index) {
          debugPrint("tab $index selected");
          setState(() {
            currentIndex = index;
            switch(index){
              case 0 : { _title = "${widget.username} Benvenuto"; }
                break;
              case 1 : { _title = "Dieta"; }
                break;
              case 2 : { _title = "Aggiungi nuova dieta"; }
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
            label: "Diete",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            label: "Crea nuova Dieta",
          ),
        ],
      ),
    );

  }
}
