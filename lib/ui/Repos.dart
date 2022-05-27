import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class Repos extends StatefulWidget {
  String login;
  String AvatarUrl;
  Repos({required this.login, required this.AvatarUrl});

  @override
  State<Repos> createState() => _ReposState();
}

class _ReposState extends State<Repos> {
  dynamic data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRepos();
  }

  void loadRepos() async {
    Uri url=Uri.parse("https://api.github.com/users/${widget.login}/repos");
    http.Response response= await http.get(url);
    if(response.statusCode==200){
      setState(() {
        data=jsonDecode(response.body);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Repos ${widget.login}"),
      actions: [
        CircleAvatar(backgroundImage: NetworkImage(widget.AvatarUrl))
      ],
      ),
      body: Center(
          child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                title: Text(data[index]['name']),

              ),
              separatorBuilder: (context,index)=> Divider(height: 2, color: Colors.blue,),
              itemCount: data==null?0:data.length)),
    );
  }

}