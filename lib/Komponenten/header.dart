import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hskl_portal/constants.dart';
import 'package:hskl_portal/login_widget.dart';
import 'package:hskl_portal/main.dart';
import 'package:restart_app/restart_app.dart';


class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Dashboard',
          style: TextStyle(fontSize: 60, color: Colors.grey[800]),
        ),
        Spacer(flex: 2),
        Expanded(child: SearchField()),
        Profile(),
      ],
    );
  }
}

//Profile
class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding/2),
        decoration: BoxDecoration(color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        //border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Image.asset(
              whichProfilePicutre(),
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Text(whichUser(),
              style: TextStyle(fontSize: 22)
              ),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
          
        ),
      ),
      
      offset: Offset(0,52),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        const PopupMenuItem(
          value: 'settings',
          child: ListTile(
            leading: Icon(Icons.settings,color: Colors.white),
            title: Text('Einstellungen'),
            ),
        ),

        const PopupMenuDivider(),

        const PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout_outlined,color: Colors.white),
            title: Text('Abmelden'),
            ),
        ),
      ],
      onSelected: (String value){
        if(value=='logout'){
          FirebaseAuth.instance.signOut();
          Restart.restartApp();
        }
      },
    );
  }
}

//Suchfeld
class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: defaultPadding),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Suche',
          hintStyle: TextStyle(fontSize: 20),
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
              const BorderRadius.all(Radius.circular(10)),
              ),
              suffixIcon: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(defaultPadding*0.75),
                  margin: EdgeInsets.symmetric(
                    horizontal: defaultPadding/2),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Icon(Icons.search),
                  ),
              ),
                
              ),
          ),
    );
  }
}

// Überprüfen welcher Nutzer angemledet ist und gibt dann das hinterlegte Profilbild zurück
String whichProfilePicutre(){
  final user = FirebaseAuth.instance.currentUser!;
  if(user.email! == 'jonas@hs-kl.de')
    return 'assets/images/jonas_profil_picutre.png';
  else if(user.email! == 'conrad@hs-kl.de')
    return 'assets/images/conrad_profil_picutre.jpg';

  else if(user.email! == 'kerpen@hs-kl.de')
    return 'assets/images/kerpen.jpg';

  return 'assets/images/standard_user_profil_picture.jpg';
}

String whichUser(){
  final user = FirebaseAuth.instance.currentUser!;
  if(user.email! == 'jonas@hs-kl.de')
    return 'Jonas Geiser';
  else if(user.email! == 'conrad@hs-kl.de')
    return 'Jan Conrad';
  else if(user.email! == 'kerpen@hs-kl.de')
    return 'Daniel Kerpen';
  else if(user.email! == 'sehn@hs-kl.de')
    return 'Nils Sehn';
  else if(user.email! == 'theresa@hs-kl.de')
    return 'Theresa Nieß';
  return 'Test User';
}