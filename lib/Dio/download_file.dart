import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFile extends StatelessWidget{
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
      downloadFile();
    }, child: Text("Download File",style: TextStyle(color: Colors.white),)),
  ),
),
        ],
      ),
    );
    
  }
}

Future downloadFile() async {

final dio = Dio();

Directory directory = await getApplicationDocumentsDirectory();
final filePath = '${directory.path}/dioFile.txt';
final response = await dio.download("https://filesamples.com/samples/document/txt/sample1.txt",
filePath,
);


print(response.statusCode);
print("Saved at: $filePath");



}

