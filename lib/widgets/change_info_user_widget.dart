import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healty/model/user.dart';
import 'package:healty/providers/admin_provider.dart';
import 'package:provider/src/provider.dart';

class ChangeInfoUser extends StatefulWidget {
  User user;

  ChangeInfoUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ChangeInfoUserState createState() => _ChangeInfoUserState();
}

class _ChangeInfoUserState extends State<ChangeInfoUser> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController controllerWeight,
      controllerLean,
      controllerFat,
      controllerHydro,
      controllerBMR;

  var response;

  @override
  void initState() {
    super.initState();

    controllerWeight =
        TextEditingController(text: widget.user.weight.toString());
    controllerLean =
        TextEditingController(text: widget.user.leanMass.toString());
    controllerFat = TextEditingController(text: widget.user.bodyFat.toString());
    controllerHydro = TextEditingController(text: widget.user.hydro.toString());
    controllerBMR = TextEditingController(text: widget.user.bmr.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dati della bioimpedenza"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: controllerWeight,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "Peso in KG",
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Questo campo è obbligatorio";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: controllerLean,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "KG di Massa Magra",
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Questo campo è obbligatorio";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: controllerFat,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "% Massa Grassa",
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.red, width: 5))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Questo campo è obbligatorio";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: controllerHydro,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "% Idratazione",
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Questo campo è obbligatorio";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: controllerBMR,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "kcal BMR",
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Questo campo è obbligatorio";
                      }
                    },
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  child: const Text('Conferma'),
                  onPressed: () async {
                    double? weight = double.tryParse(controllerWeight.text);
                    weight ??= widget.user.weight;
                    controllerWeight.addListener(() {
                      context.read<User>().weight = weight;
                    });

                    double? lean = double.tryParse(controllerLean.text);
                    lean ??= widget.user.leanMass;
                    controllerLean.addListener(() {
                      context.read<User>().leanMass = lean;
                    });

                    double? fat = double.tryParse(controllerFat.text);
                    fat ??= widget.user.bodyFat;
                    controllerFat.addListener(() {
                      context.read<User>().bodyFat = fat;
                    });

                    double? hydro = double.tryParse(controllerHydro.text);
                    hydro ??= widget.user.hydro;
                    controllerHydro.addListener(() {
                      context.read<User>().hydro = hydro;
                    });

                    int? bmr = int.tryParse(controllerBMR.text);
                    bmr ??= widget.user.bmr;
                    controllerBMR.addListener(() {
                      context.read<User>().bmr = bmr;
                    });

                    if (_formKey.currentState!.validate()) {
                      var modifyUser = User(
                          admin: widget.user.admin,
                          password: widget.user.password,
                          id: widget.user.id,
                          weight: weight,
                          bmr: bmr,
                          hydro: hydro,
                          bodyFat: fat,
                          leanMass: lean,
                          birthday: widget.user.birthday,
                          surname: widget.user.surname,
                          name: widget.user.name,
                          username: widget.user.username);
                      response = await AdminProvider.updateUser(modifyUser);
                      debugPrint(widget.user.weight.toString());
                      if (response) {
                        widget.user = modifyUser;
                        debugPrint(widget.user.weight.toString());
                        const snackBar =
                            SnackBar(content: Text("Modifica effettuata"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar = SnackBar(content: Text("Errore"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
