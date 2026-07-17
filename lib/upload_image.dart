import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;


class UploadImage extends StatefulWidget{

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
File? image ;

final _picker = ImagePicker();

bool showSpinner = false;

Future getImage()async {

final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
print(pickedFile);
if(pickedFile != null){
 
  setState((){
 image = File(pickedFile.path);
  });
}else{
print("no image selected");
}

}

Future<void> uploadImage() async{

setState(() {
  showSpinner = true;
});

var stream = new http.ByteStream(image!.openRead());
stream.cast();
var length = await image!.length();
var uri = Uri.parse("https://fakestoreapi.com/products");
var request = new http.MultipartRequest("POST", uri);
request.fields["title"] = "Static Title ";
 var multiport = new http.MultipartFile(
  "image",
   stream,
    length);

    request.files.add(multiport);
    var response = await request.send();

    if(response.statusCode == 200){
      setState((){
        showSpinner = false;
      });
      print("image uploaded");
    }else{
      print("failed");
    }
}

  @override
  Widget build(BuildContext context) {
    
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
        title: Text("Upload Image",style: TextStyle(color: Colors.white),),
        backgroundColor : Colors.blue[900],
        ),
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      
          children:[
      
      GestureDetector(
        onTap: () {
          getImage();
        },
        child: Container( 
          
          child:(image == null) ? Center(child: Text("Paste Image")) :
          Container(
           
        child: Center(
          child: Image.file(
            File(image!.path).absolute,
            height: 390,
            width: 390,
            fit: BoxFit.cover,
          ),
        )
          )),
      ),
      
      SizedBox(
        height: 150,
      ),
      GestureDetector(
        onTap: () {
          uploadImage();
        },
        child: Container(
          color: Colors.green,
          height: 50,
        width: 100,
        child: Center(child: Text("Upload Image")),
        ),
      )
          ]
        ),
      ),
    );
    
  }
}