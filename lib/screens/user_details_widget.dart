import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:healty/controller/admin_controller.dart';
import 'package:healty/model/user.dart';
import 'package:healty/widgets/change_info_user_widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

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

    //_fetchNotes();
  }

  _fetchNotes() async {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<AdminController>().loadUserDetails(widget.user!.id);
    });
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
                          title: Text("Dati di ${userDetails.name}"),
                        ),
                        body: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30),
                          child: isLandscape
                              ? Row(
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                      ),
                                      child: Expanded(
                                        child: InteractiveViewer(
                                          constrained: false,
                                          child: DataTable(
                                            columns: const [
                                              DataColumn(label: Text('')),
                                              DataColumn(label: Text('')),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                const DataCell(Text(
                                                  'Nome',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                )),
                                                DataCell(Text(userDetails.name!,
                                                    style: TextStyle(
                                                  fontSize: 18,
                                                )
                                                    )),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Cognome',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ))),
                                                DataCell(
                                                    Text(userDetails.surname!,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ))),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Data di Nascita',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ))),
                                                DataCell(
                                                    Text(userDetails.birthday!,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ))),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Peso',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.weight
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Massa Magra',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.leanMass
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Massa Grassa',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.bodyFat
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Idratazione',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.hydro
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('BMR',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.bmr
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChangeInfoUser(
                                                        user: userDetails,
                                                      )))
                                              .then((userDetails) =>
                                                  _fetchNotes());
                                        },
                                        child: const Text(
                                            "Modifica")),
                                  ],
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                      ),
                                      child: Expanded(
                                        child: InteractiveViewer(
                                          constrained: false,
                                          child: DataTable(
                                            columns: const [
                                              DataColumn(label: Text('')),
                                              DataColumn(label: Text('')),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                const DataCell(Text(
                                                  'Nome',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                )),
                                                DataCell(Text(userDetails.name!,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ))),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Cognome',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ))),
                                                DataCell(
                                                    Text(userDetails.surname!,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ))),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Data di Nascita',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ))),
                                                DataCell(
                                                    Text(userDetails.birthday!,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ))),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Peso',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.weight
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Massa Magra',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.leanMass
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Massa Grassa',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.bodyFat
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(
                                                    Text('Idratazione',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.hydro
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('BMR',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ))),
                                                DataCell(
                                                  Text(
                                                      userDetails.bmr
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChangeInfoUser(
                                                        user: userDetails,
                                                      )))
                                              .then((userDetails) =>
                                                  _fetchNotes());
                                        },
                                        child: const Text(
                                            "Modifica")),
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
