(Se me han olvidado hacer los commits mientras hacia la APP)
Video:
https://www.youtube.com/watch?v=0MO5oGNaHNk

Main.dart:
Ejecuta la aplicación

Crearemos diferentes screens para cada una de las funciones de persistencia, además 
añadiremos otra screen que se el home, esta contendrá 3 botones que cada uno llevará 
a su respectiva screen.

Notes_screen:
Tiene un cuadro de texto donde el usuario podrá escribir la anotación que él quiera, está 
se guardará en un fichero que si es la primera vez que se ejecuta se creará dicho fichero
si no sobreescribirá el ficher esto ocurre cuando se pulsa el botón de guardar, si el usuario
le da al botón de cargar aparecera en el cuadro de texto lo que se haya guardado en el fichero 
anteriormente.

Setting_screen:
Guardará las preferencias del usuario, si quiere el modo oscuro o si quiere notificaciones,
esto son dos booleanos que se almacenan en el xml de preferencias

Database_screen:
Función parecida a la lista de la compra, el usuario creará una rutina y está se almacenará
en la base de datos, después la cargará y se podrá visualizar, además se podrá eliminar una
vez realizada la rutina y se eliminara de la base de datos.
