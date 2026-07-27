import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PostDio extends StatelessWidget{

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
      PostData();
    }, child: Text("Post Data",style: TextStyle(color: Colors.white),)),
  ),
),
        ],
      ),
    );
    
  }
}

final Dio dio = Dio();
Future PostData() async {


final response = await dio.post("https://jsonplaceholder.typicode.com/posts",
data: {

  "name" : "Yusma",
  "email" :"y@email.com"
});

print(response.statusCode);
print(response.data.toString());
}
