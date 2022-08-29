import 'dart:convert';
import 'package:apicall/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Future getUsersData() async {
    var response =
        await http.get(Uri.http("jsonplaceholder.typicode.com", "users"));
    var jsonData = jsonDecode(response.body);

    List<user> users = [];
    for (var u in jsonData) {
      user User = user(u["name"], u["username"], u["email"]);
      users.add(User);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("users"),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUsersData(),
            builder: (context, snapshot) {
              if(snapshot.data==null){
                return Container(
                  child: Center(child: Icon(Icons.rounded_corner),
                ));
              }else{
                var data = (snapshot.data as List<user>).toList();
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder:(context,i){
                    return Column(
                      children: [
                        ListTile(
                          onTap: (){},
                          title: Text(data[i].name),
                          subtitle: Text(data[i].username),
                          trailing:Text(data[i].email),
                        ),
                        Divider()
                      ],
                    );
                  } ,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
