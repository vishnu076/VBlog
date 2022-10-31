import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//ignore: import_of_legacy_library_into_null_safe
import  'package:cloud_firestore/cloud_firestore.dart';
import 'package:VBlog/views/create_blog.dart';
import 'package:VBlog/views/home.dart';
import 'package:VBlog/views/sign.dart';
class LoginBlog extends StatefulWidget {
  @override
  _LoginBlogState createState() => _LoginBlogState();


}

class _LoginBlogState extends State<LoginBlog> {
  dynamic _validationMsg;
  bool _isChecking=false;
  bool _pa=false;
  bool _use=false;

  //CrudMethods crudMethods=CrudMethods();
   Future<dynamic> checkUser(username,pass) async {
     _validationMsg = null;
     setState(() {});
     _isChecking = true;
     setState(() {});
     final result = FirebaseFirestore.instance.collection("users");

     var docSnapshot = await  result.doc(username).get();
     print(docSnapshot.exists);
     if (docSnapshot.exists) {
       Map<String, dynamic>? data = docSnapshot.data();
       var value = data?["pass"];
       if(value!=pass){
         _validationMsg="Invalid user or password";
         setState(() {});

       }
       else{
          print(docSnapshot.exists);
         _use=true;
         _pa=true;
         setState(() {});

         };
       }
     else{
       _validationMsg="User not found";
       setState(() {});


   }

   }
     /*
    _isChecking = false;

  if (datas.contains(username)) {

      _validationMsg = "username is taken";
      setState(() {});
    }
    else{
      _use=true;
      setState(() {});*/





  @override
  Widget build(BuildContext context)

  {
    TextEditingController email =new TextEditingController();
    TextEditingController password =new TextEditingController();
    double deviceWidth=MediaQuery.of(context).size.width;

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(

                    height: MediaQuery.of(context).size.height*0.3
                    ,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: password,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val)=>_validationMsg,
                decoration: InputDecoration(

                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    ),
              ),
            ),
            TextButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: ()async{await checkUser(email.text,password.text);
                  if (_pa==true){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage(au:email.text)), ( Route<dynamic>route) => false,);}},
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height:200
            ),
            RichText(
              text:TextSpan(
                text: "New User?",
                children: <TextSpan>[
                  TextSpan(text: "Create Account",style: TextStyle(color:Colors.red),recognizer: TapGestureRecognizer()..onTap=(){Navigator.push(context,MaterialPageRoute(builder: (context)=>SignBlog()));},
                  ),
                ]
              )
            ),
            ],
        ),
      ),
    );
  }
}
