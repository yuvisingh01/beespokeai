import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController enteredUsername = TextEditingController();
  final TextEditingController enteredPass = TextEditingController();

  @override
  void dispose() {
    enteredUsername.dispose();
    enteredPass.dispose();
    super.dispose();
  }

  Future<bool> validateUser(String username, String password) async {
    final apiUrl = Uri.parse('https://fakestoreapi.com/auth/login');
    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    print('Request: $apiUrl');
    print(
        'Request Body: ${json.encode({'username': username, 'password': password})}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['token'] as String;
      return token.isNotEmpty;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
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
                child: Column(
                  children: [
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
                    _UsernameTextField(controller: enteredUsername),
                    const SizedBox(
                      height: 20,
                    ),
                    // entry field for password
                    _PasswordTextField(controller: enteredPass),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:
                          const Color.fromARGB(255, 75, 9, 78),
                          child: IconButton(
                            color: Colors.white,
                            // on press of the button function will be invoked
                            onPressed: () async {
                              String username = enteredUsername.text;
                              String password = enteredPass.text;

                              void navigateHome() {
                                // redirecting to the home page
                                Navigator.pushNamed(context, 'home');
                              }

                              print('Username: $username');
                              print('Password: $password');
                              final isValid =
                              await validateUser(username, password);

                              if (isValid) {
                                print('User is valid.');
                                navigateHome();
                              } else {
                                print('User validation failed.');
                              }
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
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
                            // navigate user to the register page
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color.fromARGB(255, 75, 9, 78)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // navigate user to the reset password
                            Navigator.pushNamed(context, 'resetpass');
                          },
                          child: const Text(
                            'Forgot password',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color.fromARGB(255, 75, 9, 78)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  final TextEditingController controller;

  _UsernameTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: 'Username',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  _PasswordTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}




















// import 'package:flutter/material.dart';
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
//
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     final TextEditingController enteredUsername = TextEditingController();
//     final TextEditingController enteredPass = TextEditingController();
//
//
// Future<bool> validateUser(String username, String password) async {
//   final apiUrl = Uri.parse('https://fakestoreapi.com/auth/login');
//   final response = await http.post(
//     apiUrl,
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({
//       'username': username,
//       'password': password,
//     }),
//   );
//
//   print('Request: $apiUrl');
//   print('Request Body: ${json.encode({'username': username, 'password': password})}');
//   print('Response Status Code: ${response.statusCode}');
//   print('Response Body: ${response.body}');
//
//   if (response.statusCode == 200) {
//     final jsonResponse = json.decode(response.body);
//     final token = jsonResponse['token'] as String;
//     return token.isNotEmpty;
//   } else {
//     return false;
//   }
// }
//
//     return Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Stack(children: [
//             Container(),
//             Container(
//               padding: const EdgeInsets.only(left: 35, top: 100),
//               child: const Text(
//                 'Welcome\nBack!',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 75, 9, 78), fontSize: 33),
//               ),
//             ),
//             // to allow scrolling into the app
//             SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.4,
//                     right: 35,
//                     left: 35),
//                 child: Column(children: [
//                   const Text(
//                     'Sign In',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 75, 9, 78),
//                         fontSize: 27,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   // entry field for email
//                   TextField(
//                     controller: enteredUsername,
//
//                     decoration: InputDecoration(
//                         fillColor: Colors.grey.shade100,
//                         filled: true,
//                         hintText: 'Username',
//
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   //entry field for password
//                   TextField(
//                     controller: enteredPass,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                         fillColor: Colors.grey.shade100,
//                         filled: true,
//                         hintText: 'Password',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundColor: const Color.fromARGB(255, 75, 9, 78),
//                         child: IconButton(
//                           color: Colors.white,
//                           // on press of the button function will be invoked
//                           onPressed: () async {
//                             String username= enteredUsername.text;
//                             String password=enteredPass.text;
//
//                             void navigateHome() {
//
//                               // redirecting to the home page
//                               Navigator.pushNamed(context, 'home');
//                             };
//                             print('Username: $username');
//                             print('Password: $password');
//                             final isValid = await validateUser(username, password);
//
//                             if (isValid) {
//                               print('User is valid.');
//                               navigateHome();
//                             } else {
//                               print('User validation failed.');
//                             }
//
//                           },
//                           icon: const Icon(Icons.arrow_forward),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // text links appearing at the bottom of the page
//                       TextButton(
//                           onPressed: () {
//                             //navigate user to the register page
//                             Navigator.pushNamed(context, 'register');
//                           },
//                           child: const Text(
//                             'Sign Up',
//                             style: TextStyle(
//                                 decoration: TextDecoration.underline,
//                                 fontSize: 18,
//                                 color: Color.fromARGB(255, 75, 9, 78)),
//                           )),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextButton(
//                           onPressed: () {
//                             //navigate user to the reset password
//                             Navigator.pushNamed(context, 'resetpass');
//                           },
//                           child: const Text(
//                             'Forgot password',
//                             style: TextStyle(
//                                 decoration: TextDecoration.underline,
//                                 fontSize: 18,
//                                 color: const Color.fromARGB(255, 75, 9, 78)),
//                           ))
//                     ],
//                   )
//                 ]),
//               ),
//             )
//           ]),
//         ));
//   }
// }
