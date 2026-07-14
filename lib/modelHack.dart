import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Modelhack extends StatefulWidget{
  @override
  State<Modelhack> createState() => _ModelhackState();
}

class _ModelhackState extends State<Modelhack> {

var data;
Future<void> getUserList()async{
    final response = await http.get (Uri.parse("https://jsonplaceholder.typicode.com/users"));
     

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
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
   builder: (context,snapshot) {
    if(snapshot.connectionState == ConnectionState.waiting){
     return const Column(
       children: [
        Text("Loading"),
         Center(child: CircularProgressIndicator()),
        
       ],
     );
    }
     return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    children: [
      ReusableRow(title: "Name", value: data[index]["name"].toString()),
      ReusableRow(title: "username", value: data[index]["username"].toString()),
      ReusableRow(title: "email", value: data[index]["email"].toString()),
      ReusableRow(title: "Address",
       value: data[index]["address"]["suite"].toString() 
       +","+ data[index]["address"]["street"].toString()
       +","+data[index]["address"]["city"].toString()),

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
    



// ignore: must_be_immutable
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
    
  