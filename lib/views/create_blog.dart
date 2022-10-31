import 'package:flutter/material.dart';
//ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
class CreateBlog extends StatefulWidget {
  String auth="ii";
  CreateBlog(this.auth);
  @override
  _CreateBlogState createState() => _CreateBlogState(this.auth);

 
}

class _CreateBlogState extends State<CreateBlog> {
  static String desc=''; 
  //CrudMethods crudMethods=CrudMethods();
  String auth="ii";
  _CreateBlogState(this.auth);



  static String ad="hh";
  @override
  Widget build(BuildContext context)

  {
      return Scaffold(
        appBar:AppBar(
          title: Row(mainAxisAlignment:MainAxisAlignment.center,children:<Widget>[Text("Flutter",style:TextStyle(fontSize:22)),Text("Blog",style:TextStyle(fontSize:22,color:Colors.blue))]),
          backgroundColor: Colors.transparent,
          elevation:0.0,
          
        ),
        body:Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child:TextFormField(
              minLines: 6,
              maxLines: null,
              style: TextStyle(color:Colors.black),
              decoration:InputDecoration(
              filled:true,
              fillColor:Colors.white,
              hintText:"Write here....",
              hintStyle: TextStyle(color:Colors.grey),
              border:OutlineInputBorder(),),
              onChanged: (String val){desc=val;
              },
            )),
          
          Container(
            child:ElevatedButton(
              onPressed: () {   FirebaseFirestore.instance.collection("blogs").add({'content':desc,'auth':auth});},
              child: Text("Post"),
            )
          )
          ],
        )
         
      
      



      );
    }
  }