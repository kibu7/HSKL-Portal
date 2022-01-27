


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hskl_portal/constants.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}
  

class _LoginWidgetState extends State<LoginWidget>{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      alignment: Alignment.center,
      width: 800,
      height: 500,
      decoration: BoxDecoration(color: secondaryColor, borderRadius:const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding*2),
        child: Column(
          children: [
            Text('HS-KL Portal', style: TextStyle(fontSize: 36)),
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                TextField(
                  controller : emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: 'Passwort'),
                  obscureText: true,
                ),
                SizedBox(height: 50),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.lock_open, size: 32),
                  label: Text(
                    'Anmelden',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: signIn,
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

}
