import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' ;
import 'welcome_screen.dart';

class Signup extends StatefulWidget{

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
TextEditingController emailController = TextEditingController();

TextEditingController passwordController = TextEditingController();

void login(String email,password)async{
  print(email);
print(password);
  
  try{

 Response response = await post(
  Uri.parse(""),  // use reqres api 
  headers: {
    
  },
  body:{
    "email" : email,
    "password" : password
  }
   );
 if(response.statusCode == 200){
  var data = jsonDecode(response.body.toString());
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    ),
  );
  print(data["token"]);
print("Login successfully");

 }else{
  print(response.statusCode);
  print(response.body);

 }

  }catch(e){
print(e.toString());
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Api"),
        backgroundColor: Colors.yellow[600],
      ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              
              hintText: "Email",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2
                ),
              )
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
            
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2
                ),
              )
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              login(emailController.text.toString(), passwordController.text.toString());
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                
              ),
              child: Center(
                child: Text("Sign Up",style: TextStyle(color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    ),
    );
    
  }
}