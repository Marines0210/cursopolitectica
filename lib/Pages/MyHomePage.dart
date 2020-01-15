import 'package:cursopolitecnica/CardView/PostCard.dart';
import 'package:cursopolitecnica/Model/Post.dart';
import 'package:cursopolitecnica/Model/User.dart';
import 'package:flutter/material.dart';

import 'FormPage.dart';
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});
  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { GlobalKey<AnimatedListState> key=GlobalKey();
User user=User();
var data;
int index;
GlobalKey<ScaffoldState>keyScaffold=GlobalKey();
@override
void initState() {
  getProfile();
  getListPost();
}

getProfile() async{
  var user=await User().getUser(1);
  if(user!=null && user is !Widget){
    setState(() {
      this.user=user;
    });
  }
}

getListPost()async{
  var data=await Post().getPosts();
  setState(() {
    this.data=data;
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    key: keyScaffold,
    drawer: Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(this.user.image)
                  )
              ),
            ),
            accountName: Text(this.user.name),
            accountEmail: Text(this.user.email),
          )
        ],
      ),
    ),
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: (this.data is Widget)?this.data:(this.data!=null)?loadListView():LinearProgressIndicator(),
    floatingActionButton: FloatingActionButton(
      onPressed: newPost,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ), // This trailing comma makes auto-formatting nicer for build methods.
  );
}

newPost(){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FormPage(voidCallBackParam: insertPost,user: user,)));
}

insertPost(post){
  this.data.insert(this.data.length,post);
  this.key.currentState.insertItem(this.data.length-1);
}

loadListView(){
  return AnimatedList(
    key: key,
    initialItemCount: this.data.length,
    shrinkWrap: false,
    itemBuilder: (context,index,animation){
      Post post=this.data[index];
      /*En esta parte estamos agregando un filtro para que el usuario pueda eliminar solo sus
        publicaciones (post.userId==user.id)
        */
      return (post.userId==user.id)?Dismissible(
        key: ObjectKey(post),
        onDismissed:
            (direction)async{
          deleteItem(post,index);
        },
        background: Container(color: Colors.red,)
        ,child: PostCard(this.data[index],this.user),):PostCard(this.data[index],this.user);
    },
  );
}

deleteItem(Post post,int index)async{
  var data=await post.delete();
  setState(() {
    this.index=index;
    removePost();
  });
  if(data is Widget && data!=null){
    keyScaffold.currentState.showSnackBar(SnackBar(backgroundColor: Colors.blue,content: data,));
    this.data.insert(this.index,post);
    key.currentState.insertItem(index);
  }
}

removePost(){
  this.data.removeAt(index);
  key.currentState.removeItem(index, (_,__)=>Container());
}
}
