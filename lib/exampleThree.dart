// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:api_course/Models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Examplethree extends StatefulWidget{
  
  @override
  State<Examplethree> createState() => _ExamplethreeState();
}

class _ExamplethreeState extends State<Examplethree> {
  List<UserModel> userList =[];

  Future <List<UserModel>> getUserList()async{
    final response = await http.get (Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      userList.clear();
      for(Map<String,dynamic> i in data){
       userList.add( UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nested Object",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 2, 36, 65),
        
      ),
      body:Column(
        children: [
Expanded(
  child: FutureBuilder(future: getUserList(),
   builder: (context,AsyncSnapshot<List<UserModel>> snapshot) {
    if(!snapshot.hasData){
     return Center(child: CircularProgressIndicator());
    }
     return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return Card(
child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    children: [
      ReusableRow(title: "Name", value: snapshot.data![index].name.toString()),
      ReusableRow(title: "username", value: snapshot.data![index].username.toString()),
      ReusableRow(title: "email", value: snapshot.data![index].email.toString()),
      ReusableRow(title: "Address",
       value: snapshot.data![index].address.suite.toString() 
       +","+ snapshot.data![index].address.street.toString()
       +","+snapshot.data![index].address.city.toString()),

    ],
  ),
),
        );
      },);
    
   },),
)
        ],
      ),
    );
    
  }
}
class ReusableRow extends StatelessWidget{
String title,value;
 ReusableRow({Key ? key, required this.title,required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            Text(title),
            Text(value),
          ],
        ),
  );
    
  }
}