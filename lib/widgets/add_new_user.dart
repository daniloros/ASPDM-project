import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healty/model/user.dart';
import 'package:healty/providers/admin_provider.dart';

class AddNewUser extends StatefulWidget {
  @override
  State<AddNewUser> createState() => _AddNewDinnerDietState();
}

class _AddNewDinnerDietState extends State<AddNewUser> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;
  bool isCompleted = false;
  bool isObscure = true;

  late TextEditingController controllerName,
      controllerSurname,
      controllerBirthday,
      controllerPassword,
      controllerUsername,
      controllerWeight;
  late TextEditingController controllerLeanMass,
      controllerBodyFat,
      controllerHydro,
      controllerBmr;

  var response;

  @override
  void initState() {
    super.initState();
    controllerName = TextEditingController(text: "");
    controllerSurname = TextEditingController(text: "");
    controllerBirthday = TextEditingController(text: "");
    controllerWeight = TextEditingController(text: "");
    controllerLeanMass = TextEditingController(text: "");
    controllerBodyFat = TextEditingController(text: "");
    controllerHydro = TextEditingController(text: "");
    controllerBmr = TextEditingController(text: "");
    controllerPassword = TextEditingController(text: "");
    controllerUsername = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    controllerName.dispose();
    controllerSurname.dispose();
    controllerBirthday.dispose();
    controllerWeight.dispose();
    controllerLeanMass.dispose();
    controllerBodyFat.dispose();
    controllerHydro.dispose();
    controllerBmr.dispose();
    controllerPassword.dispose();
    controllerUsername.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nuovo cliente"),
        ),
        body: isCompleted
            ? Container(child: Image.asset("assets/images/clessidra.png"),)
            : Stepper(
                type: StepperType.horizontal,
                steps: getSteps(),
                currentStep: currentStep,
                onStepContinue: () async {
                  final isLastStep = currentStep == getSteps().length - 1;

                  if (isLastStep) {
                    debugPrint("Si");
                    setState(() => isCompleted = true);

                    double? weight = double.tryParse(controllerWeight.text);
                    double? leanMass = double.tryParse(controllerLeanMass.text);
                    double? bodyFat = double.tryParse(controllerBodyFat.text);
                    double? hydro = double.tryParse(controllerHydro.text);
                    int? bmr = int.tryParse(controllerBmr.text);

                    debugPrint(weight.toString());
                    debugPrint(leanMass.toString());
                    debugPrint(bodyFat.toString());
                    debugPrint(hydro.toString());
                    debugPrint(bmr.toString());

                    var checkUser = await AdminProvider.checkUserExist(
                        controllerUsername.text);
                    debugPrint("checkUser: $checkUser");
                    if (checkUser) {
                      var newUser = User(
                          password: controllerPassword.text,
                          admin: false,
                          username: controllerSurname.text,
                          weight: weight,
                          hydro: hydro,
                          leanMass: leanMass,
                          bodyFat: bodyFat,
                          name: controllerName.text,
                          bmr: bmr,
                          surname: controllerSurname.text,
                          birthday: controllerBirthday.text);

                      debugPrint("New user: ${newUser.toString()}");
                      response = await AdminProvider.addNewUser(newUser);
                      debugPrint(response.toString());
                      if (response) {
                        const snackBar = SnackBar(
                            content: Text("Utente aggiunto correttamente"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar = SnackBar(content: Text("Errore"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      Navigator.of(context).pop();
                    } else {
                      const snackBar = SnackBar(
                          content: Text("Username già in uso"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    }

                    //send Data to Server
                  }

                  if (!isLastStep && _formKey.currentState!.validate()) {
                    setState(() => currentStep += 1);
                  }
                },
                onStepCancel: currentStep == 0
                    ? null
                    : () => setState(() => currentStep -= 1),
                controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                  final isLastStep = currentStep == getSteps().length - 1;
                  return Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        if (currentStep != 0)
                          Expanded(
                            child: ElevatedButton(
                              child: Text(isLastStep ? "Modifica" : "Indietro"),
                              onPressed: onStepCancel,
                            ),
                          ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text(isLastStep ? "Conferma" : "Continua"),
                            onPressed: onStepContinue,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text("Dati"),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerName,
                      decoration: const InputDecoration(
                          labelText: "Nome",
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerSurname,
                      decoration: const InputDecoration(
                          labelText: "Cognome",
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerBirthday,
                      decoration: const InputDecoration(
                          labelText: "Data di Nascita (gg/aa/yyyy)",
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
                ],
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text("Signup"),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerUsername,
                      decoration: const InputDecoration(
                          labelText: "Username",
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerPassword,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          color: Colors.grey,
                          splashRadius: 1,
                          icon: Icon(isObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Questo campo è obbligatorio";
                        } if (value.length < 3) {
                          return "Inserire almeno 3 caratteri";
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text("Check"),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerLeanMass,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                          labelText: "Kg Massa Magra",
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerBodyFat,
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
                  Padding(
                    padding: const EdgeInsets.all(10),
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: controllerBmr,
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
                ],
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text("Confema"),
          content: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Table(
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("Nome:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controllerName.text,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("Cognome:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controllerSurname.text,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("Data di Nascita:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controllerBirthday.text,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("Username:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controllerUsername.text,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("Password:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Builder(builder: (context) {
                                  var password = controllerPassword.text;
                                  var passwordSize =
                                      controllerPassword.text.length - 1;
                                  String passwordToShow = password.replaceRange(
                                      1,
                                      passwordSize,
                                      '*' * (passwordSize - 1));
                                  return Text(
                                    passwordToShow,
                                    style: TextStyle(fontSize: 20),
                                  );
                                }),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("Peso:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${controllerWeight.text} kg",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("Kg Massa Magra:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${controllerLeanMass.text} kg",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("% Massa Grassa:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${controllerBodyFat.text} %",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("% Idratazione:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${controllerHydro.text} %",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text("BMR:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${controllerBmr.text} kcal",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ]),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ];
}
