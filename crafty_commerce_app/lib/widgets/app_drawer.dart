import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Ali Akter"),
            accountEmail: Text("aliakter176162@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/Idea.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            iconColor: Colors.red,
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            iconColor: Colors.green,
            title: Text("My Orders"),
            onTap: () {
              Navigator.pushNamed(context, '/orders');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            iconColor: Colors.pink,
            title: Text("Manage Product"),
            onTap: () {
              Navigator.pushNamed(context, '/manage-product');
            },
          ),
        ],
      ),
    );
  }
}
