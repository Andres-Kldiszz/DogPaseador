import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paseador/pages/login_page.dart';

class MenuPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green
            ),
              child: Image.network('https://misanimales.com/wp-content/uploads/2018/07/perfiles-de-instagram-sobre-perros.jpg')
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.person_pin, size: 20, color: Colors.black),
                title: Text((FirebaseAuth.instance.currentUser?.email).toString(), style: TextStyle(fontSize: 20,),
                ),
                textColor: Colors.black,
          ),

              ListTile(
                leading: const Icon(Icons.exit_to_app, size: 20, color: Colors.black),
                title: const Text("Salir", style: TextStyle(fontSize: 20)
                ),
                textColor: Colors.black,
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())
                );
                },
              ),
            ],
          )

        ],
      ),
    );
  }
}
