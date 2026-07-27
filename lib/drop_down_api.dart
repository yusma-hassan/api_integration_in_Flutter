

import 'dart:convert';

import 'package:api_course/Models/drop_down_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropDownApi extends StatefulWidget{

  @override
  State<DropDownApi> createState() => _DropDownApiState();
}

class _DropDownApiState extends State<DropDownApi> {
Future<List<DropDownModel>> getPost()async{

List<DropDownModel> postList=[];

final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
final data = jsonDecode(response.body.toString());
if(response.statusCode == 200){
for(Map<String,dynamic> i in data ){
postList.add( DropDownModel.fromJson(i));

}
return postList;}
else{
  return postList;
}
}

String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
appBar: AppBar(
  title: Text("Dropdown Api"),
  backgroundColor:  Colors.lightGreen.shade900.withOpacity(0.6),
  
),
body: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment:  CrossAxisAlignment.center,
    children: [
      FutureBuilder<List<DropDownModel>>(
        future: getPost(),
         builder: (context, snapshot) {
           return Container(
            color: Colors.lightGreen.shade900.withOpacity(0.6),
             child: DropdownButton<String>(
              isExpanded: true,
             iconEnabledColor: Colors.green.shade900,
              hint: Text("  Select",),
              value: selectedItem,
              items:snapshot.data!.map((e) {
                return DropdownMenuItem(
                  
                  value: e.title.toString(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text( e.id.toString()+" : " +e.title.toString() ),
                  ),
                  );
              },).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              },),
           );
         },),
    ],
  ),
),
    );
    
  }
}