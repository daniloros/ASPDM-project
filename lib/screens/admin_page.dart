import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/controller/diet_page_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/providers/admin_provider.dart';
import 'package:healty/screens/settings_page.dart';
import 'package:healty/widgets/user_list_displayer.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<AdminController>().loadUserList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        appBar: AppBar(
          title: Text("Admin"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<User>().logout();
                context.read<DietPageController>().logout();
              },
              icon: const Icon(Icons.logout),
              tooltip: "Logout",
            )
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
                        child: Selector<AdminController, int>(
                          selector: (context, model) => model.countUsers,
                          builder: (context, value, _) {
                            debugPrint("Building Selector con ListView");
                            return ListView.builder(
                                itemCount: value,
                                itemBuilder: (context, index) {
                                  final item = context
                                      .read<AdminController>()
                                      .userList[index];
                                  debugPrint("item: ${item.username}");
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              // UserDetailsWidget(
                                              //   user: item,
                                              // )
                                              SettingsPage(item),
                                        ));
                                      },
                                      child: Dismissible(
                                          key: Key(item.id!),
                                          direction:
                                              DismissDirection.startToEnd,
                                          onDismissed: (direction) {},
                                          background: Container(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: Align(
                                                child: Icon(Icons.delete,
                                                    color: Colors.white),
                                                alignment: Alignment.centerLeft,
                                              ),
                                              color: Colors.red),
                                          confirmDismiss: (direction) async {
                                            final result = await showDialog(
                                              context: context,
                                              builder: (_) => NoteDelete(),
                                            );
                                            if (result) {
                                              final deleteUser =
                                                  await AdminProvider
                                                      .deleteUser(item.id!);
                                              var message;
                                              if (deleteUser == true) {
                                                message =
                                                    "Utente cancellato correttamente";
                                              } else {
                                                message =
                                                    "Si è verificato un errore";
                                              }

                                              showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                        title:
                                                            Text("Confermato"),
                                                        content: Text(message),
                                                        actions: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text("OK"))
                                                        ],
                                                      ));
                                            }
                                            return result;
                                          },
                                          child: UserListWidget(item)));
                                });
                          },
                        ),
                      ),
                    ])),
            // Selector<GalleryState, bool>(
            //   builder: (context, isLoading, _) {
            //     if (isLoading) {
            //       return Container(
            //         color: Colors.black26,
            //         child: const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     } else {
            //       return const SizedBox.shrink();
            //     }
            //   },
            //   selector: (context, state) => state.isLoading,
            // )
          ],
        ));
  }
}

class NoteDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Attenzione'),
      content: Text("Sei sicuro di voler eliminare l'utente?"),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Si'),
          onPressed: () {
            Navigator.of(context).pop(true);
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
