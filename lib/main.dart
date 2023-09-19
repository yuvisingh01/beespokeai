import 'package:beespokeai/Screens/home.dart';
import 'package:beespokeai/Screens/login.dart';
import 'package:beespokeai/Screens/register.dart';
import 'package:beespokeai/Screens/resetpass.dart';
import 'package:flutter/material.dart';


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // to remove the debug banner on the app bar
      debugShowCheckedModeBanner: false,
      title: 'Beespoke.Ai',
      // theme base of the app 
      theme: ThemeData(
      primaryColor: const Color.fromARGB(255, 75, 9, 78),
      hintColor: const Color(0xFFDB8CF8),
    ),

    // routes for navigating throughout the app
    initialRoute: 'login', // when the user lands on the app it will initially routed to the login page
    routes: {
      'login':(context)=>const Login(),
      'register':(context)=>const Register(),
      'home':(context)=>const Home(),
      'resetpass':(context)=>const ResetPass(),
    },
    );
  }
}

