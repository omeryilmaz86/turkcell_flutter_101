import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'loadData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Turkcell Flutter 101 Demo"),
          leading: Icon(
            Icons.get_app,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(25.0),
          child: FutureBuilder(
            future: getRequest(),
            builder: (BuildContext ctx, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) => ListTile(
                    title: Text('Todo : ' + snapshot.data[index].id.toString() + ' ' + snapshot.data[index].title),
                    contentPadding: EdgeInsets.only(bottom: 10.0),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<TodoDto>> getRequest() async {
    String url = "https://jsonplaceholder.typicode.com/todos";
    final response = await http.get(url);

    var responseData = json.decode(response.body);

    List<TodoDto> users = [];
    for (var item in responseData) {
      TodoDto user = TodoDto(
          id: item["id"],
          userId: item["userId"],
          title: item["title"]);

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

}
