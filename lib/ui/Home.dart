import "package:flutter/material.dart";
import 'package:my_app_1/ui/Repos.dart';

import 'User.dart';


class Home extends StatelessWidget {
  //const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text("Hassan"), accountEmail: Text("hassan.elmallouky@gmail.com")),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('GitHub Users'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>User()));
              },
            ),
          ],
        ),
      ),
      //
      body: Center(child: Text("Home Page", style: Theme.of(context).textTheme.headline4,)),
    );
  }
}