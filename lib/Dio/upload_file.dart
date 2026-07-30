
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class UploadFile extends StatelessWidget{
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
      uploadFile();
    }, child: Text("Upload File",style: TextStyle(color: Colors.white),)),
  ),
),
        ],
      ),
    );
    
  }
}

Future uploadFile() async {

final dio = Dio();
FilePickerResult? result = await FilePicker.platform.pickFiles();

  if(result != null){
    File file =  File(result.files.single.path ?? " ");

    String fileName = file.path.split("/").last;
  

FormData data = FormData.fromMap(
  {
"key" : "136a12bf80f5787c6bd86438c027fe40",
"name" : "MyImage",
"image" :await MultipartFile.fromFile(file.path,

filename:fileName )
  }
);

final response = await dio.post("https://api.imgbb.com/1/upload",
data: data,
onSendProgress: (int sent,int total) {
  print("$sent,$total");
  
},);


print(response.data);




}
else{
  print("Result is null");
}
}

