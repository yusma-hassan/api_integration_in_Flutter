import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Exampletwo extends StatefulWidget{
  @override
  State<Exampletwo> createState() => _ExampletwoState();
}

class _ExampletwoState extends State<Exampletwo> {
  List<Photos> photoList = [];
  Future<List<Photos>> getPhotos()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
photoList.clear();
for(Map<String,dynamic> i in data){
  
  photoList.add(Photos.fromJson(i));
 
}
 return photoList;
    }else{
return photoList;
    }

    

  }
  @override
  Widget build(BuildContext context) {
     
     return Scaffold(
  
  appBar: AppBar(
    title: Text("Rest API",style: TextStyle(color: Colors.white70),),
    backgroundColor: Colors.green[900],
  ),
  body: Column(
    children: [
Expanded(
  child: FutureBuilder(
    future: getPhotos(),
    
     builder: (context,AsyncSnapshot<List<Photos>> snapshot) {
       return ListView.builder(
        itemCount: photoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/200"),
            ),
            subtitle: Text(snapshot.data![index].id.toString()),
            title: Text(snapshot.data![index].title.toString()));
          
        },);
     },),
),

    ],
  ),
     );
  
  }
}

class Photos{

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Photos({
    required this.albumId,
  required this.id,
  required this.title,
  required this.url,
 required this.thumbnailUrl

  }
);
  

  factory Photos.fromJson(Map<String,dynamic> json){
return Photos(

  albumId : json["albumId"],
  id : json["id"],
  title : json["title"],
  url : json["url"],
  thumbnailUrl : json["thumbnailUrl"],

);
  }
  Map<String,dynamic> toJson(){
    return{
"albumId" : albumId,
  "id": id,
   "title":title,
  "url": url,
 "thumbnailUrl": thumbnailUrl

    };
    
  }
}