import 'package:cursopolitecnica/Common/Validate.dart';
import 'package:cursopolitecnica/Model/Post.dart';
import 'package:cursopolitecnica/Model/User.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  Post post;
  User user=User();
  VoidCallbackParam voidCallBackParam;
  FormPage({this.post,this.voidCallBackParam,this.user});
  @override
  State<StatefulWidget> createState() => FormPageState(this.post);
}

class FormPageState extends State<FormPage> {
  Post post;

  FormPageState(this.post);

  TextEditingController ctrlTitle=TextEditingController();
  TextEditingController ctrlBody=TextEditingController();
  GlobalKey<ScaffoldState>keyScaffold=GlobalKey();
  GlobalKey<FormState> keyForm = GlobalKey();
  bool enableTextField=true;

  @override
  void initState() {
    if (this.post != null) {
      ctrlBody.text = this.post.body;
      ctrlTitle.text = this.post.title;
      enableTextField=(this.post.userId==widget.user.id)?true:false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
        appBar: AppBar(
          title: Text("Formulario"),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: keyForm,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      enabled: enableTextField,
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Titulo"),
                      controller: ctrlTitle,
                      maxLength: 200,
                      validator: validateTitle,
                    ),
                    TextFormField(
                      enabled: enableTextField,
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Publicación"),
                      controller: ctrlBody,
                      maxLength: 200,
                      validator: validatePost,
                    ),
                    (enableTextField)?FlatButton(
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      textColor: Colors.grey,
                      onPressed: save,

                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Guardar"),
                    ):SizedBox.shrink()
                  ],
                ))));
  }

  save() async{
    if (keyForm.currentState.validate()) {
      var data ;
      if(post != null) {
        if(ctrlTitle.text!=post.title || ctrlBody.text!=post.body) {
           data =  await Post().update(getText(post).toMap());
        } else {
          Navigator.pop(context);
        }
      }else{
        data = await Post().save(
            {
              "title": ctrlTitle.text,
              "body": ctrlBody.text,
              "userId": "${ widget.user.id}"
            });
      }
      if (data != null) error(data);
    }
  }

  error(data) {
    if (data is Widget) {
      keyScaffold.currentState.showSnackBar(SnackBar(content: data,backgroundColor: Colors.blue,));
    } else {
      if(post==null)widget.voidCallBackParam(data);
      Navigator.pop(context);
    }
  }

  Post getText(Post post) {
    post.title = ctrlTitle.text;
    post.body = ctrlBody.text;
    return post;
  }

  String validateTitle(String value) {
    if (value.length == 0) {
      return "El titulo es requerido";
    }
    return null;
  }

  String validatePost(String value) {
    if (value.length == 0) {
      return "La publicación es requerida";
    }
    return null;
  }
}
