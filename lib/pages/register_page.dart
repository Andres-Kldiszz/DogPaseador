import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paseador/modelo/usuario_modelo.dart';
import 'package:paseador/pages/login_page.dart';
import 'package:paseador/repositorio/usuario_resgitrar.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genero{Femenino, Masculino}

class _RegisterPageState extends State<RegisterPage> {

  final nombres=TextEditingController();
  final apellidos=TextEditingController();
  final telefono=TextEditingController();
  final direccion=TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final passwordConf=TextEditingController();
  Usuario_Registrar usuario= Usuario_Registrar();
  late mensaje msg;
  Genero? _genero= Genero.Femenino;

  void guardarUsuario(Usuario usuNew) async {
    var resultado = await usuario.registrarUsuario(email.text, password.text);
    if (resultado == "invalid-email") {
      msg.mostrarMensaje("El formato del Email no es correcto");
    } else {
      if (resultado == "weak-password") {
        msg.mostrarMensaje("Minimo 6 caracteres para su contraseña");
      } else {
        if (resultado == "unknown") {
          msg.mostrarMensaje("Complete los datos");
        } else {
          if (resultado == "network-request-failed") {
            msg.mostrarMensaje("Sin conexion a internet");
          } else {
            usuNew.id=resultado;
            registrarUsuario(usuNew);
            msg.mensajeOk("Usuario registrado correctamente");
           }
        }
      }
    }
  }
  void registrarUsuario(Usuario usuNew) async {
    var id = await usuario.crearUsuario(usuNew);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()));

  }
  void traerDatos(){

    setState(() {
      if(password.text == passwordConf.text){
        if(nombres.text.isNotEmpty && apellidos.text.isNotEmpty && email.text.isNotEmpty && telefono.text.isNotEmpty && direccion.text.isNotEmpty && password.text.isNotEmpty && passwordConf.text.isNotEmpty){
          String gen = "Femenino";
          if(_genero ==Genero.Masculino){
          }
        var usuNew= Usuario("", nombres.text, apellidos.text, email.text, telefono.text, direccion.text, gen, password.text);
          guardarUsuario(usuNew);
        }else{
          msg.mostrarMensaje("Datos incompletos");
        }
      }else{
        msg.mostrarMensaje("No coincide contraseña");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    msg=mensaje(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fondo_app.jpg"),
              fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(color: Colors.black38,width: 4),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment(0.0, 1.0),
                        colors: <Color>[
                          Color(0xff76ff03),
                          Color(0xff00b8d4),
                        ],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    child: const Image(image: AssetImage("assets/Paseador.png"), width: 120, height: 120),
                  ),
                  TextFormField(
                    controller: nombres,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: "Nombres",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.person,color: Colors.black,)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: apellidos,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: "Apellidos",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.person,color: Colors.black,)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.email_outlined,color: Colors.black,)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: telefono,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: "Telefono",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.phone,color: Colors.black,)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: direccion,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: "Direccion",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.add_location_alt_rounded,color: Colors.black,)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: const Text('Masculino',style: TextStyle(color: Colors.white),),
                    leading: Radio<Genero>(
                      value: Genero.Masculino,
                      groupValue: _genero,
                      onChanged: (Genero? value){
                        setState(() {
                          _genero = value;
                        });
                      }
                    ),
                  ),
                  ListTile(
                    title: const Text('Femenino', style: TextStyle(color: Colors.white),),
                    leading: Radio<Genero>(
                        value: Genero.Femenino,
                        groupValue: _genero,
                        onChanged: (Genero? value){
                          setState(() {
                            _genero = value;
                          });
                        }
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    //keyboardType: TextInputType.emailAddress,
                    //maxLength: 8,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.vpn_key_sharp, color: Colors.white,)
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordConf,
                    //keyboardType: TextInputType.emailAddress,
                    //maxLength: 8,
                    decoration: const InputDecoration(
                        labelText: "Confirmar Password",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.vpn_key_sharp, color: Colors.white,)
                    ),
                  ), const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black12,
                        fixedSize: const Size(300, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20)),
                      onPressed: (){
                        traerDatos();
                      },
                    child: const Text("Registrarse")),
                ],
              ),
            ),
          ),
        ),

      ),
    );

  }
}
