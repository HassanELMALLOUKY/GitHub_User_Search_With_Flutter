import 'dart:convert';

import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:my_app_1/ui/Repos.dart';

class User extends StatefulWidget {
  @override
  State<User> createState() => _UserState();
}


class _UserState extends State<User> {
  //const User({Key? key}) : super(key: key);
  TextEditingController textEditingController=TextEditingController();
  bool Visible=false;
  String query="";
  dynamic data=null;
  int currentPage=0;
  int totalPages=0;
  int sizePage=20;
  List<dynamic> items=[];
  ScrollController scrollController=new ScrollController();


  void _search(String t) {
    var url=Uri.parse("https://api.github.com/search/users?q=${t}&per_page=$sizePage&page=$currentPage");
    print(url);
    http.get(url)
        .then((resp){
          setState(() {
            this.data=jsonDecode(resp.body);
            this.items.addAll(data['items']);
            if(totalPages % sizePage ==0){
              totalPages=data['total_count']~/sizePage;
            } else (totalPages=data['total_count']/sizePage).floor() +1;
          });
    })
        .catchError((err){
          print(err);
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {

      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        setState(() {
          if(currentPage<totalPages-1){
            ++currentPage;
            _search(query);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Result users search : $query => Page : $currentPage/$totalPages")),
      body: Center(child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      obscureText: Visible,
                      controller: textEditingController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Visible==false?Icon(Icons.visibility):Icon(Icons.visibility_off),
                            onPressed: () { setState(() {
                              Visible=!Visible;
                            }); },
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.deepOrange
                              ),
                              borderRadius: BorderRadius.circular(50)
                          )
                      ),
                    )),
              ),
              IconButton(onPressed: (){
                this.query =textEditingController.text;
                items=[];
                currentPage=0;
                _search(query);
              }, icon: Icon(Icons.search, color: Colors.blue,))
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(height: 3, color: Colors.blue,),
              controller: scrollController,
                itemCount: items.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Repos(login: items[index]['login'], AvatarUrl: items[index]['avatar_url']),));
                    },
                    title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage : NetworkImage(items[index]['avatar_url']),
                          radius: 50,
                        ),
                        SizedBox(width: 25),
                        Expanded(child: Text("${items[index]['login']}")),
                        CircleAvatar(
                          child: Text("${items[index]['score']}"),
                        )
                      ],
                    )
                  );
                }),
          )
        ],
      )),
    );
  }


}