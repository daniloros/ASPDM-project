import 'package:flutter/material.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/controller/login_controller.dart';
import 'package:healty/screens/admin_page.dart';
import 'package:healty/screens/page_login.dart';
import 'package:provider/provider.dart';


import 'controller/diet_page_controller.dart';
import 'model/user.dart';
import 'screens/page_home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Building MyApp!");

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => User()..load()),
        ChangeNotifierProvider(create: (context) => DietPageController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => AdminController()),
      ],
      child: MaterialApp(
        title: "My first Flutter app",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginSwitcher(),
        // routes: {
        //   '/summary' : (context) => const Summary(),
        //   '/myDiet': (context) =>  DietPage(),
        //   '/addNewDiet': (context) => const AddNewDiet(),
        // },
      ),
    );
  }
}

class LoginSwitcher extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    debugPrint("Building $runtimeType");
    final username= context.watch<User>().username;

    if(username == null){
      return const LoginPage();
    } else if(username == "Admin") {
      return AdminPage();
    } else {
      return MyHomePage(username);
    }
  }

}