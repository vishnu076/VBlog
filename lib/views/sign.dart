import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//ignore: import_of_legacy_library_into_null_safe
import  'package:cloud_firestore/cloud_firestore.dart';
import 'package:VBlog/views/home.dart';
import 'package:VBlog/views/sign.dart';
import 'package:VBlog/views/login.dart';
import 'package:email_validator/email_validator.dart';
import   'package:flutter_pw_validator/flutter_pw_validator.dart';
class SignBlog extends StatefulWidget {

  @override
  _SignBlogState createState() => _SignBlogState();


}

class _SignBlogState extends State<SignBlog> {

   dynamic _validationMsg;
   bool _isChecking=false;
   bool _pa=false;
   bool _use=false;

   final _usernameCtrl= TextEditingController();
   Future<dynamic> checkUser(username) async {
     _validationMsg = null;
     setState(() {});
     _isChecking = true;
     setState(() {});
     final QuerySnapshot result = await FirebaseFirestore.instance.collection(
         "users").get();
     final List<DocumentSnapshot>document = result.docs;
     final List<String> datas = [];
     document.forEach((data) {
       datas.add(data.id);
     });
     _isChecking = false;

     if (datas.contains(username)) {

       _validationMsg = "username is taken";
       setState(() {});
     }
     else{
       _use=true;
       setState(() {});
     }

   }

     TextEditingController email = new TextEditingController();
     TextEditingController password = new TextEditingController();
     final _formKey = GlobalKey<FormState>();
     //CrudMethods crudMethods=CrudMethods();

      good() {
       _pa=true;
     }


     @override
     Widget build(BuildContext context) {
       return Scaffold(

           body: SingleChildScrollView(
               child: Column(
                 key: _formKey,
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(top: 60.0),
                     child: Center(
                       child: Container(

                           height: MediaQuery
                               .of(context)
                               .size
                               .height * 0.3
                           ,
                           /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                           child: Image.asset('assets/images/logo.png')),
                     ),
                   ),
                   Focus(
                     //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),

                     child:TextFormField(
                       controller: _usernameCtrl,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       decoration: InputDecoration(
                         suffixIcon: _isChecking ? Transform.scale(scale: 0.5,child:CircularProgressIndicator()):null,
                         border: OutlineInputBorder(),
                         labelText: 'Email'),
                         validator: (val)=>_validationMsg,


                     ),
                     onFocusChange: (hasFocus){
                       if(!hasFocus) checkUser(_usernameCtrl.text);
                     },

                     ),



                   Padding(
                     padding: const EdgeInsets.only(
                         left: 15.0, right: 15.0, top: 15, bottom: 0),
                     //padding: EdgeInsets.symmetric(horizontal: 15),
                     child: TextFormField(

                       controller: password,
                       obscureText: true,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         labelText: 'Password',
                       ),
                     ),
                   ),
                   FlutterPwValidator(
                     controller: password,
                     width: 300
                     ,
                     height: 60,
                     minLength: 6,
                     specialCharCount: 1,
                     onSuccess: good,
                     uppercaseCharCount: 1,

                   ),
                   SizedBox(
                     height: 200,
                   ),
                   Container(
                     height: 50,
                     width: 250,
                     decoration: BoxDecoration(
                         color: Colors.blue,
                         borderRadius: BorderRadius.circular(20)),
                     child: TextButton(
                       onPressed: () async{if(_pa && _use==true){
                         FirebaseFirestore.instance.collection("users").doc(_usernameCtrl.text).set({'pass':password.text});
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginBlog()));
                         }},
                       child: Text(
                         'Signup',
                         style: TextStyle(color: Colors.white, fontSize: 25),
                       ),
                     ),
                   ),
                 ],
               )
           )
       );
     }
   }
