import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/screens/page_dinner_diet.dart';
import 'package:healty/screens/page_lunch_diet.dart';
import 'package:healty/screens/user_details_widget.dart';
import 'package:provider/src/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  final User? user;

  SettingsPage([this.user]);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsPage> {

  bool isCompleted = false;

  void initState() {
    super.initState();
    isCompleted = true;
    _fetchNotes();
  }

  _fetchNotes() async {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<AdminController>().loadUserDetails(widget.user!.id).whenComplete(() => setState(() {isCompleted=false;}));
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dettagli ')),
      body: isCompleted
          ? Container(
               child: Image.asset("assets/images/clessidra.png", ),
            )
          : buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Check Cliente'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text('Dati Cliente'),
              onPressed: (_) {

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserDetailsWidget(
                          user: context.read<AdminController>().userDetails,
                        )));
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text('Dieta'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.lunch_dining),
              title: const Text('Dieta Pranzo'),
              onPressed: (_) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LunchDietPage(),
                ));
              },
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.dinner_dining),
              title: const Text('Dieta Cena'),
              onPressed: (_) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DinnerDietPage(),
                ));
              },
            )
          ],
        ),

      ],
    );
  }
}