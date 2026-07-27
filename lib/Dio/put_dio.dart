import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PutDio extends StatelessWidget{

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
      updateData();
    }, child: Text("Update Data",style: TextStyle(color: Colors.white),)),
  ),
),
        ],
      ),
    );
    
  }
}

final Dio dio = Dio();
Future updateData() async {


final response = await dio.put("https://jsonplaceholder.typicode.com/posts/1",
data: {

  "name" : "Yusma",
  "email" :"y@email.com"
});

print(response.statusCode);
print(response.data);
}
