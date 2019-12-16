import 'package:cursopolitecnica/CardView/PostCard.dart';
import 'package:cursopolitecnica/Model/Post.dart';
import 'package:flutter/material.dart';

import 'FormPage.dart';
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() =>  _MyHomePageState(this.title);
}

class _MyHomePageState extends State<MyHomePage> {
  String title;
  List<Post>listPost=Post.getPosts();
  _MyHomePageState(this.title);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text(title)),
      ),
      body: ListView.builder(
        shrinkWrap: true,
          itemCount: listPost.length,
          itemBuilder: (BuildContext context,int index){
            return PostCard(listPost[index]);
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: newPost,
        child: Icon(Icons.person_pin,color: Colors.red,),
      ),
    );
  }
  void newPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>FormPage()));
  }


}
