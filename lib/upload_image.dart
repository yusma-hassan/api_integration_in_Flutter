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

final _picker = ImagePicker(); /*Think of this as creating an image picker object.
Now this object has functions like :pickImage(),pickMultiImage()
*/

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
 
var stream = new http.ByteStream(image!.openRead()); /*openRead() says
"Read this file as bytes. 
http.ByteStream(...)

The image may be several MB.

Flutter doesn't send all bytes at once.

Instead it sends them little by little.This is much more memory efficient.
*/
stream.cast(); /* This line changes the stream into the type expected by MultipartFile. */
var length = await image!.length(); //The server needs to know "How big is this file?"
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
            //File(image!.path).absolute,
            image!, // this is the simplified form of File(image!.path).absolute,
            
            /*image

is already a File.

So when you write

File(image!.path)

you're creating another File object using the same path.

Imagine this:

File file1 = File("/storage/photo.jpg");
File file2 = File(file1.path);

Now both variables point to the same image.

Nothing new was created on the device.

So in this  code,

File(image!.path)

is actually unnecessary.

 could simply write:

Image.file(image!)

and it would work exactly the same.

5. .absolute

Every file has a path.

For example,

photo.jpg

This is called a relative path.

An absolute path is the complete location:

/storage/emulated/0/DCIM/Camera/photo.jpg

.absolute returns a File whose path is the full absolute path.

In this  case, image_picker already gives you an absolute path.

So

File(image!.path).absolute

doesn't change anything. */
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