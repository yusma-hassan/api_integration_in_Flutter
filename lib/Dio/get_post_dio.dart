import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GetPostDio extends StatelessWidget{

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
      getPostData();
    }, child: Text("Get/Post Data",style: TextStyle(color: Colors.white),)),
  ),
),
        ],
      ),
    );
    
  }
}

final Dio dio = Dio();
 void getPostData() async {

final response = await Future.wait ([


dio.get("https://jsonplaceholder.typicode.com/posts/1"),
dio.post("https://jsonplaceholder.typicode.com/posts"),

]);


print(response[0].statusCode);
print(response[1].statusCode);
print(response[0].data);
print(response[1].data);
}
