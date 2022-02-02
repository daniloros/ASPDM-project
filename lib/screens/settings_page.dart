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
        // SettingsSection(
        //   tiles: <SettingsTile>[
        //     SettingsTile.navigation(
        //       leading: Padding(padding: EdgeInsets.all(50),),
        //       title: ElevatedButton(onPressed: () async {
        //         final result = await showDialog(
        //           context: context,
        //           builder: (_) => NoteDelete(),
        //         );
        //         if (result) {
        //           final deleteUser =
        //               await AdminProvider
        //               .deleteUser(context.read<AdminController>().userDetails!.id!);
        //           var message;
        //           if (deleteUser == true) {
        //             message =
        //             "Utente cancellato correttamente";
        //           } else {
        //             message =
        //             "Si è verificato un errore";
        //           }
        //
        //           showDialog(
        //               context: context,
        //               builder: (_) => AlertDialog(
        //                 title:
        //                 Text("Confermato"),
        //                 content: Text(message),
        //                 actions: [
        //                   ElevatedButton(
        //                       onPressed: () {
        //                         Navigator.of(
        //                             context)
        //                             .pop();
        //                       },
        //                       child: Text("OK"))
        //                 ],
        //               ));
        //         }
        //         return result;
        //       },
        //       child: Text("Elimina Utente"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

// class NoteDelete extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Attenzione'),
//       content: Text("Sei sicuro di voler eliminare l'utente?"),
//       actions: <Widget>[
//         ElevatedButton(
//           child: Text('Si'),
//           onPressed: () {
//             Navigator.of(context).pop(true);
//           },
//         ),
//         ElevatedButton(
//           child: Text('No'),
//           onPressed: () {
//             Navigator.of(context).pop(false);
//           },
//         ),
//       ],
//     );
//   }
// }
