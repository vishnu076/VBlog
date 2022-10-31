import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//ignore: import_of_legacy_library_into_null_safe
import  'package:cloud_firestore/cloud_firestore.dart';
import 'package:VBlog/views/create_blog.dart';
import 'package:VBlog/views/home.dart';
import 'package:VBlog/views/mysquare.dart';
import 'package:VBlog/views/sign.dart';


class HomePage extends StatefulWidget {

  String au="hh";
  HomePage({Key? key,required this.au});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState(this.au);
}

class _HomePageState extends State<HomePage> {
  var au = "hh";

  _HomePageState(this.au);






  List<String> _datas=[];
  @override
  void initState() {
    super.initState();
    getdocs() async {
      QuerySnapshot result=await FirebaseFirestore.instance.collection("blogs").get();
      final List<DocumentSnapshot>document = result.docs;

      document.forEach((data) {
        _datas.add(data['content']);
        setState(() {});
      });
      return _datas;
    }
    getdocs();


  }
  final List _posts=["post1","postt2"];
  Widget build(BuildContext context) {
    print(_datas.length);
    return Scaffold(


      appBar:AppBar(
        title: Row(mainAxisAlignment:MainAxisAlignment.center,children:<Widget>[Text("Flutter",style:TextStyle(fontSize:22)),Text("Blog",style:TextStyle(fontSize:22,color:Colors.blue))]),

        backgroundColor: Colors.transparent,
        elevation:0.0,
      ),
      body: ListView.builder(

        itemCount:_datas.length,
        itemBuilder: (context,index){
          return Padding(

            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              color: Colors.white,
              child:Row(children:<Widget> [
                Flexible(
                child: Text(
                  "${_datas[index]}",
                   style: TextStyle(color:Colors.black.withOpacity(1.0)),
                      
              ),
                )
            ],
            ),
            ),
          );
        }),
        floatingActionButton: Container(padding:EdgeInsets.symmetric(vertical:20),child:Row(mainAxisAlignment:MainAxisAlignment.center,children:<Widget>[FloatingActionButton(onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateBlog(au))); print(_datas) ;} ,child:Icon(Icons.add),)]),
        )

    );
  }
}

