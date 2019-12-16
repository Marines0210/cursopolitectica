import 'package:connectivity/connectivity.dart';
import 'package:cursopolitecnica/Common/Constant.dart';
import 'package:flutter/material.dart';

typedef VoidCallbackParam(var parameter);

class Validate {
  static Widget errorWidget(String error, {String content = ""}) {
    switch (error) {
      case Constant.CONNECTION_DISABLED:
        return textError("Error en la conexion");
        break;

      case Constant.WIFI_DISABLED:
        return textError("Error en la conexion WiFi");
        break;

      case Constant.SERVER_ERROR:
        return textError("Error en el servidor $content");
        break;

      case Constant.MESSAGE:
        return textError(content);
        break;
    }
  }

  static emptyMap(parameters){
    return parameters.toString()=="[]"?null:parameters;
  }

  static connectionError(
      {VoidCallback method, VoidCallbackParam methodParam,Map parameters}) async {
    var connectionResult = await Connectivity().checkConnectivity();
    return (connectionResult == ConnectivityResult.none)
        ? errorWidget(Constant.CONNECTION_DISABLED)
        : (emptyMap(parameters) != null) ? methodParam(parameters) : method();
  }

  static Widget textError(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: 40),
    );
  }
}
