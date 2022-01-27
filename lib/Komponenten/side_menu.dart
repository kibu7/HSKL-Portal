import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../main_screen.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView( 
        //erlaub wenn der Browser kleiner wird, das man die Leiste scrollen kann
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset('assets/images/logo.png')
              ),
      
              // HOME
              DrawerListTile(title: 'Home',
              icon: Icons.home, 
              press: () {  },
              ), 
      
              // Favoriten
              DrawerListTile(title: 'Favoriten',
              icon: Icons.star_border, 
              press: () {  },
              ),
      
              // Archiv
              DrawerListTile(title: 'Archiv',
              icon: Icons.archive_outlined, 
              press: () {  },
              ),
      
              // Papiekorb
              DrawerListTile(title: 'Papierkorb',
              icon: Icons.delete, 
              press: () {  },
              ),
              Divider(
                //color: Colors.black,
                thickness: 2,
              ),
      
              // Speicherplatz
              DrawerListTile(title: 'Speicherplatz',
              icon: Icons.cloud, 
              press: () {  },
              ),
              new CircularPercentIndicator(
                 radius: 60.0,
                 percent: 0.25,
                lineWidth: 5.0,
                center: new Text("25%"),
                progressColor: Colors.green,
                
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '2,5 GB von 10 GB belegt',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54),
              ),
      
          ],
        ),
      ),
    );
  }
}



class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key, 
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      onTap: press,
      leading: Icon(
        icon,
        color: Colors.white54,),
      title: Text(
        title,
        style: TextStyle(
        color: Colors.white54),
        ),
    );
  }
}