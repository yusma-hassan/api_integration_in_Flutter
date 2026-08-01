
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class UploadPdf extends StatelessWidget{
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
      uploadPdf();
    }, child: Text("Upload Pdf",style: TextStyle(color: Colors.white),)),
  ),
),
        ],
      ),
    );
    
  }
}

Future uploadPdf() async {

final dio = Dio();
FilePickerResult? result = await FilePicker.platform.pickFiles();
if(result != null){
  File file = File(result.files.single.path ?? " ");
  String filename = file.path.split("/").last;
  String filepath = file.path;

  FormData data = FormData.fromMap({
    "x-api-key" : "apikey", // this is not the actual api key so i can selesct file but can not upload it
    "name" : " ",
    "pdf" : await MultipartFile.fromFile(filepath,filename: filename)

  });


final response = await dio.post("https://api.pdf.co/v1/file/upload",
data: data,
onSendProgress:(int sent , int total){
print("$sent,$total");
},
);
print(response.toString);

}else{
  print("Result is Null");
}
}

