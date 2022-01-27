import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hskl_portal/constants.dart';
import 'package:hskl_portal/firebase_options.dart';
import 'package:hskl_portal/landingpage.dart';
import 'package:hskl_portal/login_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hskl_portal/main_screen.dart';
import 'package:hskl_portal/model/list.dart';
import 'package:hskl_portal/model/listSub.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemList>(create: (context)=> ItemList()),
        ChangeNotifierProvider<ItemListSub>(create: (context)=> ItemListSub()),
      ],
    child: const MyApp(),
  ),
  ); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSKL Portal',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
      ),
      home: LandingPage()//MainPage()
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return const MainScreen();
          
        } else{
          return const LoginWidget();
        }
        
      },
    ),
  );
}

