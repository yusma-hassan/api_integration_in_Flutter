import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DeleteDio extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Delete Dio",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
Center(
  
  child: Container(
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(12),
   color: Colors.deepPurple,
),
 
    child: TextButton(onPressed: () {
      deleteData();
    }, child: Text("Delete Data",style: TextStyle(color: Colors.white),)),
  ),
),
        ],
      ),
    );
    
  }
}

Future deleteData() async {

final dio = Dio();

final response = await dio.get("https://jsonplaceholder.typicode.com/todos/1");
final response2 = await dio.delete("https://jsonplaceholder.typicode.com/todos/1");

print(response.statusCode);
print(response.data.toString());

print(response2.statusCode);
print(response2.data.toString());
}