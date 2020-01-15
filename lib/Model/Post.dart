import 'package:cursopolitecnica/Common/Validate.dart';
import 'package:cursopolitecnica/HTTPProtocol/EndPoints.dart';

class Post {
  int id;
  String title;
  String body;
  int userId;

  Post({this.id = 0, this.title = "", this.body = "", this.userId = 0});

  factory Post.fromJson(Map<dynamic, dynamic> data) {
    if (data == null) return null;
    Validate validate = Validate(data);
    return Post(
        id: validate.keyExists('id', defaul: 0),
        title: validate.keyExists('title'),
        body: validate.keyExists('body'),
        userId: validate.checkInteger(validate.keyExists('userId',defaul: 0)));
  }

  Map<String, dynamic>toMap(){
    return {
      'id':"${this.id}",
      'title':this.title,
      'body':this.body,
      'userId':"${this.userId}"
    };
  }

  update(parameters)async{
    var data =await EndPoint.updatePost(parameters);
    return Validate(data).isWidget(getObject);
  }

  save(parameters)async{
    var data =await EndPoint.insertPost(parameters);
    return Validate(data).isWidget(getObject);
  }

  delete()async{
    var data =await EndPoint.deletePost(this.id);
    return Validate(data).isWidget(getObject);
  }
  getPosts() async {
    var data = await EndPoint.getPosts();
    return Validate(data).isWidget(getList);
  }
  getObject(data) {
    return Post.fromJson(data);
  }
  getList(data) {
    return (data as List).map((map) => Post.fromJson(map)).toList();
  }
}
