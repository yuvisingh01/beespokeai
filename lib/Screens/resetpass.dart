import 'package:flutter/material.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
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
              padding: const EdgeInsets.only(left: 25, top: 100),
              child: const Text(
                'Forgot your\npassword? :(',
                style: TextStyle(
                    color: Color.fromARGB(255, 75, 9, 78), fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Column(children: [
                  const Text(
                    'Reset it here!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 9, 78),
                        fontSize: 27,
                        fontWeight: FontWeight.w700),
                  ),
                   const SizedBox(
                    height: 20,
                  ),
                  // text field of email to reset password
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color.fromARGB(255, 75, 9, 78),
                        child: IconButton(
                          color: Colors.white,
                          // onclick  of the submit button user will be navigated back to the login
                          onPressed: () {
                            void navigateHome() {
                              Navigator.pushNamed(context, 'login');
                              // ignore: empty_statements
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
                 
                ]),
              ),
            )
          ]),
        ));
  }
}
