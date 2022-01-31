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
  void initState() {
    super.initState();

    // SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
    //   context.read<AdminController>().loadUserDetails(widget.user!.id);
    // });

    _fetchNotes();
  }

  _fetchNotes() async {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<AdminController>().loadUserDetails(widget.user!.id);
    });
    ;
  }

  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings UI')),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Check Cliente'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('Dati Cliente'),
              onPressed: (_) {
                debugPrint(
                    "UserDetailsWidget ${context.read<AdminController>().userDetails!.username}");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserDetailsWidget(
                          user: context.read<AdminController>().userDetails,
                        )));
              },
            ),
          ],
        ),
        SettingsSection(
          title: Text('Dieta'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.lunch_dining),
              title: Text('Dieta Pranzo'),
              onPressed: (_) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LunchDietPage(),
                ));
              },
            ),
            SettingsTile.navigation(
              leading: Icon(Icons.dinner_dining),
              title: Text('Dieta Cena'),
              onPressed: (_) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DinnerDietPage(),
                ));
              },
            )
          ],
        ),
      ],
    );
  }
}
