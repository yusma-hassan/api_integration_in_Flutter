import 'dart:convert';
import 'package:api_course/Models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Homescreen extends StatefulWidget {
  const Homescreen({super.key, required this.title});

 final String title;

  @override
  State<Homescreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<Homescreen> {


  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi()async{
final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
var data = jsonDecode(response.body.toString());

if(response.statusCode == 200){
postList.clear();
for(Map<String,dynamic> i in data){
  postList.add(PostsModel.fromJson(i));
}
return postList;
}else{
return postList;
}
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text("Api Course"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
               builder: (context, snapshot) {
                 
                 if(!snapshot.hasData){
                  return Text("Loading");
                 }else{ 
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Title",style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 18),),
                              Text(postList[index].title.toString()),
                              Text("Description",style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 18),),
                              Text(postList[index].body.toString()),
                           
                              
                            ],
                          ),
                        ),
                      );
                    },);
            
                 }
               },),
          )
        ],
      )
    );
  }
}
