import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 100),
              child: const Text(
                'Welcome\nBack!',
                style: TextStyle(
                    color: Color.fromARGB(255, 75, 9, 78), fontSize: 33),
              ),
            ),
            // to allow scrolling into the app
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Column(children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 9, 78),
                        fontSize: 27,
                        fontWeight: FontWeight.w700),
                  ),
                   const SizedBox(
                    height: 20,
                  ),
                  // entry field for email 
                  TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //entry field for password
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color.fromARGB(255, 75, 9, 78),
                        child: IconButton(
                          color: Colors.white,
                          // on press of the button function will be invoked 
                          onPressed: () {
                            void navigateHome() {
                              // redirecting to the home page
                              Navigator.pushNamed(context, 'home');
                            };
                            navigateHome();
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // text links appearing at the bottom of the page 
                      TextButton(
                          onPressed: () {
                            //navigate user to the register page
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color.fromARGB(255, 75, 9, 78)),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            //navigate user to the reset password
                            Navigator.pushNamed(context, 'resetpass');
                          },
                          child: const Text(
                            'Forgot password',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: const Color.fromARGB(255, 75, 9, 78)),
                          ))],

                  )
                ]),
              ),
            )
          ]),
        ));
  }
}
