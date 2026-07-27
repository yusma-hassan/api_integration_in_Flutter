import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GetDio extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Get Dio",style: TextStyle(color: Colors.white),),
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
      fetchData();
    }, child: Text("Fetch Data",style: TextStyle(color: Colors.white),)),
  ),
),
        ],
      ),
    );
    
  }
}

Future fetchData() async {

final dio = Dio();

final response = await dio.get("https://jsonplaceholder.typicode.com/todos/1");

print(response.statusCode);
print(response.data.toString());
}