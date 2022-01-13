import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/model/user.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'text_dialog_widget.dart';

class UserDetailsWidget extends StatefulWidget {
  final User? user;

  const UserDetailsWidget({Key? key, this.user}) : super(key: key);

  @override
  State<UserDetailsWidget> createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {

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

  @override
  Widget build(BuildContext context) {
    // var newWeigth, newLeanMass, newBodyFat, newHydro, newBMR;
    // var resultUpdateUser;

    return Selector<AdminController, User?>(
        selector: (context, model) => model.userDetails,
        builder: (context, value, _) {
          if (value == null) {
            return const SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Builder(builder: (context) {
                    var userDetails =
                        context.read<AdminController>().userDetails;
                    if (userDetails == null) {
                      return Text("Ciao");
                    } else {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text("Diet ${userDetails.name} Details"),
                        ),
                        body: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Column(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.transparent,
                                ),
                                child: Expanded(
                                  child: DataTable(
                                    columns: [
                                      DataColumn(label: Text('')),
                                      DataColumn(label: Text('')),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text('Nome')),
                                        DataCell(Text(userDetails.name!)),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('Cognome')),
                                        DataCell(Text(userDetails.surname!)),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('Data di Nascita')),
                                        DataCell(Text(userDetails.birthday!)),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('Peso')),
                                        DataCell(
                                          Text(userDetails.weight.toString()),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('massa magra')),
                                        DataCell(
                                          Text(userDetails.leanMass
                                              .toString()),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('massa grassa')),
                                        DataCell(
                                          Text(
                                              userDetails.bodyFat.toString()),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('idratazione')),
                                        DataCell(
                                          Text(userDetails.hydro.toString()),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('bmr')),
                                        DataCell(
                                          Text(userDetails.bmr.toString()),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 10),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          //TODO: delete Account

                                        },
                                        child: Text("ELIMINA ACCOUNT")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 10),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TextDialogWidget(
                                                        user: userDetails,
                                                      ))).then((userDetails) => _fetchNotes());
                                        },
                                        child: Text("MODIFICA DATI")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ],
            );
          }
        });
  }
}
