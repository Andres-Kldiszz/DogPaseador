import 'package:flutter/material.dart';
import 'package:paseador/pages/home_page.dart';
import 'package:paseador/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final email=TextEditingController();
  final password=TextEditingController();
  FirebaseAuth auth= FirebaseAuth.instance;
  late final mensaje msg;

  void validarUsuario() async {

    try {
        final user = await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
        if(user != null){
          msg.mensajeOk("Bienvenido!!!");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomePage()));
        }
    } on FirebaseAuthException catch (e) {
      if(e.code=="invalid-email"){
        msg.mostrarMensaje("El formato del Email no es correcto");
      }
      if(e.code=="user-not-found"){
        msg.mostrarMensaje("El usuario no esta registrado");
      }
      if(e.code=="wrong-password"){
        msg.mostrarMensaje("Contraseña incorrecta");
      }
      if(e.code=="unknown"){
        msg.mostrarMensaje("Complete los datos");
      }
      if(e.code=="network-request-failed"){
        msg.mostrarMensaje("Sin conexion a internet");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    msg=mensaje(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(color: Colors.black38,width: 4),
                      color: Colors.lightBlueAccent
                  ),
                  child: const Image(
                      image: AssetImage("assets/Logo.png"),width: 120, height: 120),
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: "Correo electronico",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.email_outlined, color: Colors.black, size: 25)
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.vpn_key_sharp, color: Colors.black, size: 25)
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic, color: Colors.blue)
                    ),
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                    },
                    child: const Text("Registrarse")
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    shadowColor: Colors.black26,
                      textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20
                      )
                  ),
                    onPressed: (){
                    validarUsuario();
                    },
                    child: const Text("Ingresar"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class mensaje{

  late BuildContext context;
  mensaje(this.context);

  void mostrarMensaje(String mensaje){
    final pantalla=ScaffoldMessenger.of(context);
    pantalla.showSnackBar(
      SnackBar(
        content: Text(mensaje, style: const TextStyle(fontSize: 20)),
        backgroundColor: const Color(0xFFD50000),
        duration: const Duration(seconds: 3),
        /*action: SnackBarAction(
          label: 'Aceptar',
          onPressed: (){
            pantalla.hideCurrentSnackBar;
            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
          }
        ),*/
      ),
    );
  }
  void mensajeOk(String mensaje){
    final pantalla=ScaffoldMessenger.of(context);
    pantalla.showSnackBar(
      SnackBar(
        content: Text(mensaje, style: const TextStyle(fontSize: 20)),
        backgroundColor: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
