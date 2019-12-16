import 'package:flutter/material.dart';
/* Estamos usando StatefulWidget porque estaremos actualizando datos y los debemos de mostrar en la vista
por lo tanto reconstruiremos todo el diseño  con setState que le pertenece solo a StatefulWidget
* */
class FormPage extends StatefulWidget {

  //createState es el encargado de reconstruir todo el diseño que se encuentra en nuestra clase estado
  @override
  State<StatefulWidget> createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  /*TextEditingController es un controlador que le colocaremos a cada caja de texto para obtener el texto que
  tiene cada una de estas
   */
  TextEditingController ctrlTitle = TextEditingController();
  TextEditingController ctrlPost = TextEditingController();

  //Creamos una llave para poder realizar acciones en nuestro formulario
  GlobalKey<FormState> keyForm = GlobalKey();


  @override
  Widget build(BuildContext context) {
    // estamos creando una pagina por lo tanto necesitamos usar Scaffold para agregar app bar
    return Scaffold(
      //Aqui colocamos el appbar con un text para asignarle un titulo
        appBar: AppBar(
          title: Text("Formulario"),
        ),
        /*El primer widget es importante es agregar SingleChildScrollView porque sino lo agregamos al abrir el teclado
        aparecera una barra de color amarilla y negra indicando que nuestro diseño no entra en la pantalla si quieren
        no le agregue para que ustedes mismos puedan ver que pasa
         */
        body: SingleChildScrollView(
            //Agregamos form para poder tener control de algunas acciones sobre muestras cajas de texto
            child:Form(
              //Agregamos la llave porque sino no podremos tener ese control que les comento
            key: keyForm,

            //Para agregar varias cajas de texto tenemos que usar una columna y de esta manera se ordenaran los widget
              // de manera vertical
            child: Column(
              children: <Widget>[
                //Para crear una caja de texto usamos TextFormField
                TextFormField(
                  //Este atributo es para especificar cuantas lineas queremos que ocupe nuestra caja de texto
                  maxLines: 3,
                  //Especificar el tipo de texto que se escribira para que en el teclado este deacuerdo con este
                  //podemos usar TextInputType.phone, TextInputType.number , TextInputType.datetime, etc.
                  keyboardType: TextInputType.text,

                  /*Para especificar el texto que tiene que colocar el usuario
                  hintText -> es para agregar un texto en la caja cuando el usuario escriba se borrara y mostrara el textoa actual
                  labelText -> muestra el texto que debe colocar el usuario  y cuando escriba se subira en la parte de arriba
                   */
                  decoration: InputDecoration(labelText: "Titulo"),
                  //Agregamos el controlador que creamos anteriormente
                  controller: ctrlTitle,
                  //especificar cuantos caracteres puede agregar en la caja el usuario
                  maxLength: 200,
                  //Validar aqui debemos de crear un metodo para validar precionen control y clic sobre validateTitle para ir al metodo
                  validator: validateTitle,
                ),
                //Hacemos lo mismo para esta caja
                TextFormField(maxLines: 3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Publicación"),
                  controller: ctrlPost,
                  maxLength:200 ,
                  validator: validatePost,
                ),

                // para crear un botos usamos FlatButton
                FlatButton(
                  color: Colors.greenAccent,
                  /*cuando vemos el atributo "shape" nosotro podemos agregarle formas en este caso el boton tendra
                  las orillas redondeadas
                   */
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  //color que quieren que tenga el texto
                  textColor: Colors.grey,
                  //Al momento de dar clic sobre el boton nosotros tenemos que
                  //hacer algo asi que precionamos control y clic sobre save
                  onPressed: save,

                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Guardar"),
                )
              ],
            ))));
  }

  save() {

    /*Aqui nosotros atravez de la llave de form podremos validar nuestras cajas de texto
    el metodo keyForm.currentState.validate() ejecutara todas nuestras validaciones si todo esta bien
    estonces hara lo que esta dentro del if pero sino mostrara los mensajes de error en cada caja */
    if(keyForm.currentState.validate()){

      //Aqui obtenemos el texto de cada caja a travez del controlador y lo imprimimos con print
      print("nombree ${ctrlTitle.text}");
      print("nombree ${ctrlPost.text}");

      //Con la llave del formulario podemos resetear todas las cajas que se encuentran dentro de esta
      keyForm.currentState.reset();

      //Navigator sirve para abrir y cerrar ventanas en este caso con pop cerraremos la ventana
      Navigator.pop(context);
    }
  }

  String validateTitle(String value) {
    //la caja de texto no regresara el texto actual en la caja por eso tenemos el parametro value

    /*con value.length  podemos obtener cuantos caracteres hay en la caja si el numero es igual
     a 0 quiere decir que no han escrito nada por lo tanto retornamos un String con el mensaje de que es necesario llenar
     ese campo */
    if (value.length == 0) {
      return "El titulo es requerido";
    }

    //Retonamos null para regresar y decir que no paso nada
    return null;
  }

  String validatePost(String value) {
    if (value.length == 0) {
      return "La publicación es requerida";
    }
    return null;
  }
}
