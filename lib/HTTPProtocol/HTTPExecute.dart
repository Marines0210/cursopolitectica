import 'package:cursopolitecnica/Common/Constant.dart';
import 'package:cursopolitecnica/Common/Validate.dart';
import 'package:http/http.dart' as http;

class HttPExecute {
  String endPointUrl;

  HttPExecute(this.endPointUrl);

  delete() async {
    return Validate.connectionError(method:loadDelete);
  }

  Future get() {
    return Validate.connectionError(method:loadGet);
  }

  post(parameters) {
    return Validate.connectionError(methodParam:loadPost,parameters: parameters);
  }

  put( parameters) {
    return Validate.connectionError(methodParam:loadPut,parameters: parameters);
  }

  Future loadGet() async {
    var response = await http.get(this.endPointUrl,);
    return getResponse(response);
  }

  loadPost(parameters) async {
    var response = await http.post(this.endPointUrl,body: parameters);
    return getResponse(response);
  }

  loadDelete() async {
    var response = await http.delete(this.endPointUrl,);
    return getResponse(response);
  }
  loadPut(parameters) async {
    var response = await http.put(this.endPointUrl);
    return getResponse(response);
  }

  getResponse(response) {
    return (response.statusCode >= 200 && response.statusCode < 300)
        ? response.body.toString()
        : Validate.errorWidget(Constant.SERVER_ERROR,
            content: "${response.statusCode}");
  }
}
