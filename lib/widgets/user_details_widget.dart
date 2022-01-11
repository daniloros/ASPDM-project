import 'package:flutter/material.dart';
import 'package:healty/model/user.dart';

import 'text_dialog_widget.dart';

class UserDetailsWidget extends StatelessWidget {
  final User? user;

  const UserDetailsWidget({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var newWeigth, newLeanMass, newBodyFat, newHydro, newBMR;
    return Scaffold(
      appBar: AppBar(
        title: Text("Diet ${user!.name} Details"),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
                DataCell(Text(user!.name!)),
              ]),
              DataRow(cells: [
                DataCell(Text('Cognome')),
                DataCell(Text(user!.surname!)),
              ]),
              DataRow(cells: [
                DataCell(Text('Data di Nascita')),
                DataCell(Text(user!.birthday!)),
              ]),
              DataRow(cells: [
                DataCell(Text('Peso')),
                DataCell(Text(user!.weight.toString()), showEditIcon: true,
                    onTap: () async {
                      final newWeigthCurrent = await showTextDialog(
                        context,
                        title: "Cambia",
                        value: user!.weight.toString(),
                      );
                      newWeigth = newWeigthCurrent;
                      debugPrint(newWeigth);
                    }),
              ]),
              DataRow(cells: [
                DataCell(Text('massa magra')),
                DataCell(Text(user!.leanMass!.toString()), showEditIcon: true,
                    onTap: () async {
                      final newLeanMassCurrent = await showTextDialog(
                        context,
                        title: "Cambia",
                        value: user!.leanMass!.toString(),
                      );
                      newLeanMass = newLeanMassCurrent;
                      debugPrint(newLeanMass);
                    }),
              ]),
              DataRow(cells: [
                DataCell(Text('massa grassa')),
                DataCell(Text(user!.bodyFat!.toString()), showEditIcon: true,
                    onTap: () async {
                      final newBodyFatCurrent = await showTextDialog(
                        context,
                        title: "Cambia",
                        value: user!.bodyFat!.toString(),
                      );
                      newBodyFat = newBodyFatCurrent;
                    }),
              ]),
              DataRow(cells: [
                DataCell(Text('idratazione')),
                DataCell(Text(user!.hydro!.toString()), showEditIcon: true,
                    onTap: () async {
                      final newHydroCurrent = await showTextDialog(
                        context,
                        title: "Cambia",
                        value: user!.hydro!.toString(),
                      );
                      newHydro = newHydroCurrent;
                    }),
              ]),
              DataRow(cells: [
                DataCell(Text('bmr')),
                DataCell(Text(user!.bmr!.toString()), showEditIcon: true,
                    onTap: () async {
                      final newBMRCurrent = await showTextDialog(
                        context,
                        title: "Cambia",
                        value: user!.bmr!.toString(),
                      );
                      newBMR = newBMRCurrent;
                    }),
              ]),
            ],
          ),
        ),
      ),
      Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO: delete Account
                        // User(password: user!.password, admin: user!.admin, username: user!.username, id: user!.id, leanMass: newLeanMass, weight: newWeigth, bodyFat: newBodyFat, hydro: newHydro, bmr: newBMR , name: user!.name, surname: user!.username, birthday: user!.birthday );
                      },
                      child: Text("ELIMINA ACCOUNT")),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO: Rendere editabili i dati in tabella e fare l'update in tabella
                      },
                      child: Text("MODIFICA DATI")),
                ),
              ],
            )
          ],
      ),
    ),);
  }
}
