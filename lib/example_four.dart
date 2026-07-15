import 'dart:convert';

import 'package:api_course/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

Future<ProductModel> getProduct()async{
  final resoponse = 
  await http.get(Uri.parse("https://webhook.site/82897ad2-e81f-4301-a029-23ee90800408"));
  var data = jsonDecode(resoponse.body.toString());
  if(resoponse.statusCode == 200){
 return ProductModel.fromJson(data);
  }else {
     return ProductModel.fromJson(data);
  }
 
}

   return Scaffold(
    appBar: AppBar(
      title: Text("Complex Json",style: TextStyle(color: Colors.white)),
      backgroundColor: const Color.fromARGB(255, 2, 36, 65),
    ),
    body: Column(
      children: [
        Expanded(
          child:FutureBuilder(
            future: getProduct(),
             builder: (context, snapshot) {
              if (snapshot.hasData){
return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  
return Padding(
  padding: const EdgeInsets.all(20.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
ListTile(
  title: Text(snapshot.data!.data![index].shop!.name.toString()),
  subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
  leading: CircleAvatar(
    backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
  ),
),

  Container(
    height: MediaQuery.of(context).size.height*.3,
      width: MediaQuery.of(context).size.width*1,
  
  
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.data![index].images!.length,
      itemBuilder: (context, position) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
           height: MediaQuery.of(context).size.height*.25,
        width: MediaQuery.of(context).size.width*.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: 
            NetworkImage(snapshot.data!.data![index].images![position].url.toString())),
        )
        ),
        
      );
    },)
  ),
  Icon(snapshot.data!.data![index].inWishlist! == true ? Icons.favorite : Icons.favorite_outline),
    ],
  ),
);
                },);
              }else{
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Text("Loading"),
                  ],
                );
              }
        
               
             },) )
      ],
    ),
   );
    
  }
}