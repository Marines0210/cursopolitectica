import 'package:cursopolitecnica/Common/Constant.dart';
import 'package:cursopolitecnica/HTTPProtocol/HTTPExecute.dart';

class EndPoint{
  static getUser(id){
    return HttPExecute(generateEndPointURL("users/$id")).get();
  }
  static getPosts(){
    return HttPExecute(generateEndPointURL("posts")).get();
  }
  static deletePost(id){
    return HttPExecute(generateEndPointURL("posts/$id")).delete();
  }
  static updatePost(parameters){
    return HttPExecute(generateEndPointURL("posts/${parameters['id']}")).put(parameters);
  }

  static insertPost(parameters){
    return HttPExecute(generateEndPointURL("posts")).post(parameters);
  }

  static generateEndPointURL(String resource){
    return Constant.DOMAIN + Constant.PATH + resource;
  }
}