import 'package:cursopolitecnica/Model/Post.dart';
import 'package:cursopolitecnica/Model/User.dart';
import 'package:cursopolitecnica/Pages/FormPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* Estamos usando StatefulWidget porque estaremos actualizando datos y los debemos de mostrar en la vista
por lo tanto reconstruiremos todo el diseño  con setState que le pertenece solo a StatefulWidget
* */
class PostCard extends StatefulWidget {
  //Crearemos un constructor  para poder obtener el post y mostarlo en nuestro card
  Post post;
  User user;
  PostCard(this.post,this.user);

  //createState es el encargado de reconstruir todo el diseño que se encuentra en nuestra clase estado
  //Ahora aqui no nos sirve el post asi que lo pasaremos a la clase estado que ahi si nos sirve
  @override
  State<StatefulWidget> createState() => PostCardState(this.post);
}

//Esta es nuestra clase estado como pueden ver heredamos de estado y especificamos el tipo que es PostCard
//Nota: recuerden cuando digo heredar es porque estamos usando "extends"
class PostCardState extends State<PostCard> {
  //Creamos un contructor pata recibir el post que se nos envia en la parte de arriba ya que aqui si nos servira el post
  Post post;
  User userPost=User();
  PostCardState(this.post);
  @override
  void initState() {
    getUserPost();
  }
  getUserPost() async{
    var user=await User().getUser(post.userId);
    if(user !=null && user is !Widget){
      setState(() {
        this.userPost=user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /*Container es un widget muy util con este podemos agregar diseños mas personalizados especificandoles un tamaño
      en el ancho y alto colores margeny padding
    * */
    return InkWell(
        onTap: ()=> goFormPage(),
    child:Container(
        color: Colors.white,
        child: Card(
          elevation: 15,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.all(20),
          color: Colors.greenAccent,
          child: ListTile(
            title: Text(post.title),
            subtitle: Column(
              children: <Widget>[
                Text(post.body),
                Text("Población 8.1 mill"),
              ],
            ),
          ),
        )));
  }


  goFormPage(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>FormPage(post:this.post,user: widget.user,)));
  }
}
