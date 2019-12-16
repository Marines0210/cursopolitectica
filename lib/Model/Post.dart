class Post{
  //Creamos loa atributos de post
  int id;
  String title;
  String body;
  int userId;
  /*Aqui agregamos un contructor recuerden que el contructor
  siempre tendra el nombre de la clase recibimos los atributos
  con llaves para poder poder varios agregar datos opcionales
  * */
  Post({this.id=0,this.title="",this.body="",this.userId=0});

  //aqui vamos a crear una lista de varios post para mostrarlos
  // el nuestro liestview
  static getPosts(){
    //creamos nuestra variable listPost e inicializamos
    List<Post>listPost=List<Post>();
    //Aqui agregamos cada uno de los post en la lista
    listPost.add(Post(id: 1,title: "Porque llueve?",body: "porque sii",userId: 1));
    listPost.add(Post(id: 2,title: "Necesitas ayuda con los arreglos",body: "los arreglos son.",userId: 1));
    listPost.add(Post(id: 3,title: "Codigofacilito",body: "Hay diferentes cursos",userId: 2));
    listPost.add(Post(id: 4,title: "Politecnica",body: "Es un instituto....",userId: 3));
    //Al final retornamos la lista ya llena
    return listPost;
  }

}