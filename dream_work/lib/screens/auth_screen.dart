import 'package:dream_work/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final repasswordController = TextEditingController();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          FloatingActionButton(
            child: const Text('Log In'),
            onPressed: () {
              Alert(
                  context: context,
                  title: "Log In",
                  content: Column(
                    children:  <Widget>[
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.account_circle),
                          labelText: 'Username',
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'password',
                        ),
                      )
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () {}, //ToDo: log in to database and see if it is there, then send them to welcome
                      child: const Text(
                        "Log In",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ]).show();
            },
          ),
          FloatingActionButton(
            child: const Text('Sign Up'),
            onPressed: () {
              Alert(
                  context: context,
                  title: "Sign Up",
                  content: Column(
                    children:  <Widget>[
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.account_circle),
                          labelText: 'Username',
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                      ),
                      TextField(
                        controller: repasswordController,
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Confirm Password',
                        ),
                      )
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        if(passwordController.text.compareTo(repasswordController.text)==0){
                          if (passwordController.text.length < 6) {
                            Alert(
                                context: context,
                                title: "Password Too Short",
                                desc: "the password must be at least 6 characters"
                            );
                          }
                          else if (usernameController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              repasswordController.text.isEmpty) {
                            Alert(
                                context: context,
                                title: "Incorrect Requirements",
                                desc: "One ore More fields empty"
                            );
                          }
                          else{
                            //ToDo: sign the person up
                            //then send them to welcome screen
                          }
                        }
                        else{
                          Alert(
                              context: context,
                              title: "Passwords not matching",
                              desc: "the passwords don't match"
                          );
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ]).show();
            },
          ),
        ],
      ),
    );
  }
}

class WelcomeScreenBody extends StatelessWidget {
  const WelcomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // size of the screen
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          const WelcomeScreenBackground(),
          Positioned(
            top: size.height * 0.5,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    child: const Text("START"),
                    onPressed: ()=>Navigator.pushNamed(context, RouteGenerator.individual_screen),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class WelcomeScreenBackground extends StatelessWidget {
  const WelcomeScreenBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // size of the screen
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueGrey,
                    Color.fromARGB(255, 225, 190, 145),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'Dream Work',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'A place to work together',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
