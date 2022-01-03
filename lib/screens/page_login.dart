import 'package:flutter/material.dart';
import 'package:healty/model/user.dart';
import 'package:healty/providers/login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();

  bool passwordVisible = false;
  bool isChecked = false;

  final _formUserKey = GlobalKey<FormState>();

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    //carichiamo i dati nel caso li avessimo
  }

  @override
  void dispose() {
    _ctrlUsername.dispose();
    _ctrlPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $runtimeType');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login to your\naccount',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/accent.png',
                    width: 99,
                    height: 4,
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              Form(
                key: _formUserKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _ctrlUsername,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "Username",
                      ),
                      validator: (val){
                        if(val!.isEmpty ){
                          return "This field is required";
                        }
                    },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      // decoration: BoxDecoration(
                      //   color: Colors.yellow,
                      //   borderRadius: BorderRadius.circular(14.0),
                      // ),
                      child: TextFormField(
                        controller: _ctrlPassword,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            hintText: "Password",
                            suffixIcon: IconButton(
                              color: Colors.grey,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final username = _ctrlUsername.text;
                    final password = _ctrlPassword.text;

                    if (_formUserKey.currentState!.validate()){
                      validateLogin(username, password);
                    }

                  },
                  child: const Text("Login"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> validateLogin(String username, String password) async {

    if(username.isEmpty){
      const snackBar = SnackBar(content: Text("insert a valid username"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    int response = await Login.login(username, password);

    debugPrint(response.toString());

    switch(response) {
      case 0:
        {
          await context.read<User>().login(username, password);
        }
        break;

      case 1:
        {
          const snackBar = SnackBar(content: Text("user not found"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        break;

      case 2:
        {
          const snackBar = SnackBar(content: Text("password is not correct"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        break;

      default:
        {
          final snackBar = SnackBar(content: Text("Error $response"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        break;

    }

  }
}
