import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/screens/page_diet.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../widgets/change_info_user_widget.dart';

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

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
                      return const Text("Dati non ancora presenti");
                    } else {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text("Dettagli dieta di ${userDetails.name}"),
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
                                    columns: const [
                                      DataColumn(label: Text('')),
                                      DataColumn(label: Text('')),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        const DataCell(Text('Nome')),
                                        DataCell(Text(userDetails.name!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Cognome')),
                                        DataCell(Text(userDetails.surname!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Data di Nascita')),
                                        DataCell(Text(userDetails.birthday!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Peso')),
                                        DataCell(
                                          Text(userDetails.weight.toString()),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('massa magra')),
                                        DataCell(
                                          Text(userDetails.leanMass
                                              .toString()),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('massa grassa')),
                                        DataCell(
                                          Text(
                                              userDetails.bodyFat.toString()),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('idratazione')),
                                        DataCell(
                                          Text(userDetails.hydro.toString()),
                                        ),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('bmr')),
                                        DataCell(
                                          Text(userDetails.bmr.toString()),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => DietPage()
                                          )
                                        );

                                      },
                                      child: const Text("Modifica Dieta")),
                                  ElevatedButton(
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeInfoUser(
                                                      user: userDetails,
                                                    ))).then((userDetails) => _fetchNotes());
                                      },
                                      child: const Text("Modifica Dati")),
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
