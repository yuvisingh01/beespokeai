import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key, required ListView child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 186, 143, 239), 
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 186, 143, 239), // Set the background color here
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.jpg'), // Replace with your avatar image
                  radius: 40,
                ),
                SizedBox(height: 8),
                Text(
                  "Yuvraj Singh",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'dev.yuvi@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Yuvraj Singh"),
            subtitle: const Text('Developer'),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),
          const ListTile(
            leading: Icon(Icons.email),
            title: Text("Email"),
            subtitle: Text('dev.yuvi@gmail.com'),
            trailing: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
